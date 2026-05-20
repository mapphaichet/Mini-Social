from django.contrib import admin

from .models import Comment, Post, PostMedia, Profile, Reaction


class PostMediaInline(admin.TabularInline):
    model = PostMedia
    extra = 0


@admin.register(Post)
class PostAdmin(admin.ModelAdmin):
    list_display = ('id', 'author', 'created_at', 'updated_at')
    list_filter = ('created_at',)
    search_fields = ('content', 'author__username')
    inlines = [PostMediaInline]


@admin.register(Comment)
class CommentAdmin(admin.ModelAdmin):
    list_display = ('id', 'post', 'author', 'is_approved', 'created_at')
    list_filter = ('is_approved', 'created_at')
    search_fields = ('content', 'author__username', 'flagged_reason')
    actions = ['approve_comments']

    @admin.action(description='Approve selected comments')
    def approve_comments(self, request, queryset):
        queryset.update(is_approved=True, flagged_reason='')


@admin.register(Profile)
class ProfileAdmin(admin.ModelAdmin):
    list_display = ('user', 'can_post', 'violation_count', 'created_at')
    list_filter = ('can_post',)
    search_fields = ('user__username', 'bio')


admin.site.register(Reaction)
