from django.contrib.auth import views as auth_views
from django.urls import path

from . import views

urlpatterns = [
    path('', views.feed, name='feed'),
    path('register/', views.register, name='register'),
    path('login/', auth_views.LoginView.as_view(template_name='social/login.html'), name='login'),
    path('logout/', auth_views.LogoutView.as_view(), name='logout'),
    path('password/', views.change_password, name='change_password'),
    path('profile/', views.profile, name='profile'),
    path('posts/new/', views.post_create, name='post_create'),
    path('posts/<int:pk>/', views.post_detail, name='post_detail'),
    path('posts/<int:pk>/edit/', views.post_edit, name='post_edit'),
    path('posts/<int:pk>/delete/', views.post_delete, name='post_delete'),
    path('posts/<int:pk>/like/', views.toggle_like, name='toggle_like'),
    path('posts/<int:pk>/comments/', views.add_comment, name='add_comment'),
    path('comments/<int:pk>/delete/', views.comment_delete, name='comment_delete'),
    path('dashboard/', views.dashboard, name='dashboard'),
    path('dashboard/moderation/', views.moderation_queue, name='moderation_queue'),
    path('dashboard/comments/<int:pk>/approve/', views.approve_comment, name='approve_comment'),
    path('dashboard/comments/<int:pk>/reject/', views.reject_comment, name='reject_comment'),
    path('dashboard/members/', views.member_list, name='member_list'),
    path('dashboard/members/<int:pk>/toggle-ban/', views.toggle_user_ban, name='toggle_user_ban'),
    path('dashboard/posts/<int:pk>/delete/', views.moderator_delete_post, name='moderator_delete_post'),
    path('dashboard/comments/<int:pk>/delete/', views.moderator_delete_comment, name='moderator_delete_comment'),
]
