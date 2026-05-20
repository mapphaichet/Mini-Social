from unittest.mock import patch

from django.contrib.auth.models import User
from django.test import TestCase
from django.urls import reverse

from . import moderation
from .models import Comment, Post


class StubPredictor:
    def __init__(self, label):
        self.label = label
        self.samples = None

    def predict(self, samples):
        self.samples = samples
        return [self.label], [{self.label: 0.0}]


class CommentModerationTests(TestCase):
    def test_moderate_comment_marks_neg_label_as_toxic(self):
        predictor = StubPredictor('NEG')

        with patch('social.moderation._get_predictor', return_value=predictor):
            is_approved, reason = moderation.moderate_comment('Do not allow this comment')

        self.assertFalse(is_approved)
        self.assertEqual(reason, moderation.MODEL_TOXIC_REASON)
        self.assertEqual(predictor.samples, ['Do not allow this comment'])

    def test_moderate_comment_marks_pos_label_as_clean(self):
        predictor = StubPredictor('POS')

        with patch('social.moderation._get_predictor', return_value=predictor):
            is_approved, reason = moderation.moderate_comment('This is a normal comment')

        self.assertTrue(is_approved)
        self.assertEqual(reason, '')

    def test_moderate_comment_falls_back_to_keywords_when_predictor_fails(self):
        with patch('social.moderation._get_predictor', side_effect=RuntimeError('model unavailable')):
            is_approved, reason = moderation.moderate_comment('That was a stupid reply')

        self.assertFalse(is_approved)
        self.assertEqual(reason, 'Suspected terms: stupid')


class AddCommentModerationTests(TestCase):
    def setUp(self):
        self.user = User.objects.create_user(username='member', password='password123')
        self.post = Post.objects.create(author=self.user, content='Welcome')
        self.client.force_login(self.user)

    def test_add_comment_rejects_neg_prediction_and_counts_violation(self):
        with patch('social.moderation._get_predictor', return_value=StubPredictor('NEG')):
            response = self.client.post(
                reverse('add_comment', args=[self.post.pk]),
                {'content': 'A toxic comment'},
            )

        self.assertRedirects(response, reverse('post_detail', args=[self.post.pk]))
        comment = Comment.objects.get()
        self.assertFalse(comment.is_approved)
        self.assertEqual(comment.flagged_reason, moderation.MODEL_TOXIC_REASON)
        self.user.profile.refresh_from_db()
        self.assertEqual(self.user.profile.violation_count, 1)

    def test_add_comment_approves_pos_prediction(self):
        with patch('social.moderation._get_predictor', return_value=StubPredictor('POS')):
            response = self.client.post(
                reverse('add_comment', args=[self.post.pk]),
                {'content': 'A friendly comment'},
            )

        self.assertRedirects(response, reverse('post_detail', args=[self.post.pk]))
        comment = Comment.objects.get()
        self.assertTrue(comment.is_approved)
        self.assertEqual(comment.flagged_reason, '')
        self.user.profile.refresh_from_db()
        self.assertEqual(self.user.profile.violation_count, 0)
