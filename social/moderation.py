from django.conf import settings


TOXIC_TERMS = {
    'hate',
    'idiot',
    'stupid',
    'toxic',
    'kill',
    'spam',
    'abuse',
}

MODEL_TOXIC_REASON = 'Detected toxic comment by Naive Bayes model'

_predictor = None
_predictor_load_attempted = False


def _keyword_moderate_comment(text):
    lowered = text.lower()
    matches = sorted(term for term in TOXIC_TERMS if term in lowered)
    if matches:
        return False, f'Suspected terms: {", ".join(matches)}'
    return True, ''


def _get_predictor():
    global _predictor, _predictor_load_attempted

    if _predictor_load_attempted:
        return _predictor

    _predictor_load_attempted = True
    try:
        from .model import NaiveBayesClassifier

        db_name = str(settings.BASE_DIR / 'database.db')
        predictor = NaiveBayesClassifier(db_name=db_name)
        predictor.load()
        _predictor = predictor
    except Exception:
        _predictor = None

    return _predictor


def moderate_comment(text):
    try:
        predictor = _get_predictor()
        if predictor is not None:
            labels, _scores = predictor.predict([text])
            label = labels[0]
            if label == 'NEG':
                return False, MODEL_TOXIC_REASON
            if label == 'POS':
                return True, ''
    except Exception:
        pass

    return _keyword_moderate_comment(text)
