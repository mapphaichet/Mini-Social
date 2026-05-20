TOXIC_TERMS = {
    'hate',
    'idiot',
    'stupid',
    'toxic',
    'kill',
    'spam',
    'abuse',
}


def moderate_comment(text):
    lowered = text.lower()
    matches = sorted(term for term in TOXIC_TERMS if term in lowered)
    if matches:
        return False, f'Suspected terms: {", ".join(matches)}'
    return True, ''
