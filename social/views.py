from datetime import timedelta

from django.contrib import messages
from django.contrib.admin.views.decorators import staff_member_required
from django.contrib.auth import login, update_session_auth_hash
from django.contrib.auth.decorators import login_required
from django.contrib.auth.forms import PasswordChangeForm
from django.contrib.auth.models import User
from django.db.models import Count, Q
from django.db.models.functions import TruncDate
from django.shortcuts import get_object_or_404, redirect, render
from django.utils import timezone
from django.views.decorators.http import require_POST

from .forms import CommentForm, PostForm, ProfileForm, RegisterForm
from .moderation import moderate_comment
from .models import Comment, Post, PostMedia, Profile, Reaction


def _can_contribute(user):
    return user.is_authenticated and user.is_active and user.profile.can_post


def _visible_comments(post, user):
    comments = post.comments.select_related('author', 'author__profile')
    if not user.is_authenticated:
        return comments.filter(is_approved=True)
    if user.is_staff:
        return comments
    return comments.filter(Q(is_approved=True) | Q(author=user))


def _attach_post_state(posts, user):
    liked_ids = set()
    if user.is_authenticated:
        liked_ids = set(
            Reaction.objects.filter(user=user, post__in=posts).values_list('post_id', flat=True)
        )
    for post in posts:
        post.visible_comments = _visible_comments(post, user)
        post.is_liked = post.id in liked_ids
    return posts


def register(request):
    if request.method == 'POST':
        form = RegisterForm(request.POST)
        if form.is_valid():
            user = form.save()
            login(request, user)
            messages.success(request, 'Registration complete.')
            return redirect('feed')
    else:
        form = RegisterForm()
    return render(request, 'social/register.html', {'form': form})


@login_required
def feed(request):
    posts = list(
        Post.objects.select_related('author', 'author__profile')
        .prefetch_related('media', 'comments__author', 'reactions')[:50]
    )
    return render(request, 'social/feed.html', {'posts': _attach_post_state(posts, request.user)})


@login_required
def profile(request):
    if request.method == 'POST':
        form = ProfileForm(request.POST, request.FILES, instance=request.user.profile)
        if form.is_valid():
            form.save()
            messages.success(request, 'Profile updated.')
            return redirect('profile')
    else:
        form = ProfileForm(instance=request.user.profile)
    posts = Post.objects.filter(author=request.user).prefetch_related('media', 'reactions')
    return render(request, 'social/profile.html', {'form': form, 'posts': posts})


@login_required
def change_password(request):
    if request.method == 'POST':
        form = PasswordChangeForm(request.user, request.POST)
        if form.is_valid():
            user = form.save()
            update_session_auth_hash(request, user)
            messages.success(request, 'Password changed.')
            return redirect('profile')
    else:
        form = PasswordChangeForm(request.user)
    return render(request, 'social/change_password.html', {'form': form})


@login_required
def post_create(request):
    if not _can_contribute(request.user):
        messages.error(request, 'Your account is not allowed to post right now.')
        return redirect('feed')
    if request.method == 'POST':
        form = PostForm(request.POST)
        files = request.FILES.getlist('media')
        if form.is_valid():
            post = form.save(commit=False)
            post.author = request.user
            post.save()
            for uploaded in files:
                PostMedia.objects.create(post=post, file=uploaded)
            messages.success(request, 'Post published.')
            return redirect('feed')
    else:
        form = PostForm()
    return render(request, 'social/post_form.html', {'form': form, 'title': 'New post'})


@login_required
def post_detail(request, pk):
    post = get_object_or_404(
        Post.objects.select_related('author', 'author__profile').prefetch_related('media', 'reactions'),
        pk=pk,
    )
    _attach_post_state([post], request.user)
    return render(request, 'social/post_detail.html', {'post': post, 'comment_form': CommentForm()})


@login_required
def post_edit(request, pk):
    post = get_object_or_404(Post, pk=pk, author=request.user)
    if request.method == 'POST':
        form = PostForm(request.POST, instance=post)
        if form.is_valid():
            form.save()
            messages.success(request, 'Post updated.')
            return redirect('post_detail', pk=post.pk)
    else:
        form = PostForm(instance=post)
    return render(request, 'social/post_form.html', {'form': form, 'title': 'Edit post'})


@login_required
@require_POST
def post_delete(request, pk):
    post = get_object_or_404(Post, pk=pk, author=request.user)
    post.delete()
    messages.success(request, 'Post deleted.')
    return redirect('feed')


@login_required
@require_POST
def toggle_like(request, pk):
    post = get_object_or_404(Post, pk=pk)
    reaction, created = Reaction.objects.get_or_create(user=request.user, post=post)
    if not created:
        reaction.delete()
    return redirect(request.POST.get('next') or 'feed')


@login_required
@require_POST
def add_comment(request, pk):
    if not _can_contribute(request.user):
        messages.error(request, 'Your account is not allowed to comment right now.')
        return redirect('post_detail', pk=pk)
    post = get_object_or_404(Post, pk=pk)
    form = CommentForm(request.POST)
    if form.is_valid():
        comment = form.save(commit=False)
        comment.post = post
        comment.author = request.user
        comment.is_approved, comment.flagged_reason = moderate_comment(comment.content)
        comment.save()
        if not comment.is_approved:
            profile = request.user.profile
            profile.violation_count += 1
            profile.save(update_fields=['violation_count'])
            messages.warning(request, 'Comment awaiting administrator approval due to suspected violation of community standards.')
        else:
            messages.success(request, 'Comment added.')
    return redirect('post_detail', pk=pk)


@login_required
@require_POST
def comment_delete(request, pk):
    comment = get_object_or_404(Comment.objects.select_related('post'), pk=pk)
    can_delete = comment.author == request.user or comment.post.author == request.user or request.user.is_staff
    if not can_delete:
        messages.error(request, 'You do not have permission to delete this comment.')
        return redirect('post_detail', pk=comment.post_id)
    post_id = comment.post_id
    comment.delete()
    messages.success(request, 'Comment deleted.')
    return redirect('post_detail', pk=post_id)


@staff_member_required(login_url='login')
def dashboard(request):
    since = timezone.now() - timedelta(days=7)
    posts_by_day = list(
        Post.objects.filter(created_at__gte=since)
        .annotate(day=TruncDate('created_at'))
        .values('day')
        .annotate(total=Count('id'))
        .order_by('day')
    )
    comments_by_day = list(
        Comment.objects.filter(created_at__gte=since)
        .annotate(day=TruncDate('created_at'))
        .values('day')
        .annotate(total=Count('id'))
        .order_by('day')
    )
    users_by_day = list(
        User.objects.filter(date_joined__gte=since)
        .annotate(day=TruncDate('date_joined'))
        .values('day')
        .annotate(total=Count('id'))
        .order_by('day')
    )
    clean_count = Comment.objects.filter(is_approved=True).count()
    toxic_count = Comment.objects.filter(is_approved=False).count()
    violators = Profile.objects.select_related('user').filter(violation_count__gt=0).order_by('-violation_count')[:10]
    context = {
        'post_count': Post.objects.count(),
        'comment_count': Comment.objects.count(),
        'user_count': User.objects.count(),
        'pending_count': toxic_count,
        'clean_count': clean_count,
        'toxic_count': toxic_count,
        'posts_by_day': posts_by_day,
        'comments_by_day': comments_by_day,
        'users_by_day': users_by_day,
        'violators': violators,
    }
    return render(request, 'social/dashboard.html', context)


@staff_member_required(login_url='login')
def moderation_queue(request):
    comments = Comment.objects.filter(is_approved=False).select_related('author', 'post').order_by('-created_at')
    return render(request, 'social/moderation_queue.html', {'comments': comments})


@staff_member_required(login_url='login')
@require_POST
def approve_comment(request, pk):
    comment = get_object_or_404(Comment, pk=pk, is_approved=False)
    comment.is_approved = True
    comment.flagged_reason = ''
    comment.save(update_fields=['is_approved', 'flagged_reason'])
    messages.success(request, 'Comment approved.')
    return redirect('moderation_queue')


@staff_member_required(login_url='login')
@require_POST
def reject_comment(request, pk):
    comment = get_object_or_404(Comment, pk=pk, is_approved=False)
    comment.delete()
    messages.success(request, 'Comment rejected and deleted.')
    return redirect('moderation_queue')


@staff_member_required(login_url='login')
def member_list(request):
    users = User.objects.select_related('profile').annotate(
        post_total=Count('posts'),
        comment_total=Count('comments'),
    ).order_by('username')
    return render(request, 'social/member_list.html', {'users': users})


@staff_member_required(login_url='login')
@require_POST
def toggle_user_ban(request, pk):
    user = get_object_or_404(User, pk=pk)
    if user == request.user:
        messages.error(request, 'You cannot ban your own account.')
    else:
        user.is_active = not user.is_active
        user.save(update_fields=['is_active'])
        user.profile.can_post = user.is_active
        user.profile.save(update_fields=['can_post'])
        messages.success(request, 'Member status updated.')
    return redirect('member_list')


@staff_member_required(login_url='login')
@require_POST
def moderator_delete_post(request, pk):
    post = get_object_or_404(Post, pk=pk)
    post.delete()
    messages.success(request, 'Post deleted by moderator.')
    return redirect('dashboard')


@staff_member_required(login_url='login')
@require_POST
def moderator_delete_comment(request, pk):
    comment = get_object_or_404(Comment, pk=pk)
    comment.delete()
    messages.success(request, 'Comment deleted by moderator.')
    return redirect(request.POST.get('next') or 'dashboard')

# Create your views here.
