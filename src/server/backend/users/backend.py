import base64
import json
from datetime import datetime, timedelta
from secrets import compare_digest

import jwt
from django.conf import settings
from django.core.exceptions import ImproperlyConfigured
from zxcvbn import zxcvbn


def check_password_strength(password: str) -> bool:
    if len(password) < settings.MIN_PASSWORD_LENGTH:
        return False

    if compare_digest(password, ""):
        return False

    if int(zxcvbn(password)["guesses"]) < settings.PASSWORD_MIN_GUESSES:
        return False

    return True


def generate_payload(expires_in, token_id, token_provider, grant_type, **extra_data):

    now = datetime.utcnow()
    issued_at = now
    expiration = now + timedelta(seconds=expires_in)
    payload = {
        "exp": expiration,
        "iat": issued_at,
        "token_provider": token_provider,
        "token_id": token_id,
        "grant_type": grant_type,
    }

    if extra_data:
        payload.update(**extra_data)

    return payload


def encode_jwt_token(expires_in, token_id, token_provider, grant_type, **extra_data):
    algorithm = "RS256"

    with open("jwt-pri.key") as f:
        private_key = f.read()

    if not private_key:
        raise ImproperlyConfigured("Missing setting private key")
    payload = generate_payload(
        expires_in, token_id, token_provider, grant_type, **extra_data
    )
    encoded = jwt.encode(payload, private_key, algorithm=algorithm)
    return encoded


def decode_jwt_token(jwt_value):

    try:
        headers_enc, payload_enc, verify_signature = jwt_value.split(".")
    except ValueError:
        raise jwt.InvalidTokenError()

    payload_enc += "=" * (-len(payload_enc) % 4)

    algorithms = "RS256"

    with open("jwt-pub.key") as f:
        public_key = f.read()

    if not public_key:
        raise ImproperlyConfigured("Missing setting  pubic key")

    decoded = jwt.decode(jwt_value, public_key, algorithms=algorithms)
    return decoded
