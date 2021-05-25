import logging

from django.conf import settings
from django.middleware.csrf import CsrfViewMiddleware
from rest_framework import authentication, exceptions

from .backend import decode_jwt_token, encode_jwt_token
from .models import AccessToken, User


class CSRFCheck(CsrfViewMiddleware):
    def _reject(self, request, reason):
        # Return the failure reason instead of an HttpResponse
        return reason


def enforce_csrf(request):
    """
    Enforce CSRF validation
    """
    check = CSRFCheck()
    # populates request.META['CSRF_COOKIE'], which is used in process_view()
    check.process_request(request)
    reason = check.process_view(request, None, (), {})
    logging.warning(reason)
    if reason:
        # CSRF failed, bail with explicit error message
        raise exceptions.PermissionDenied("CSRF Failed: %s" % reason)


class JWTAuthentication(authentication.BaseAuthentication):
    """
    jwt token based authentication. Clients should authenticate by passing the token key in the
    "Authorization" HTTP header, prepended with the string "Bearer ".
    For example: Authorization: Bearer eyJhbGciOiJub25lIn0.
                eyJpc3MiOiJqb2UiLA0KICJleHAiOjEzMDA4MTkzODAsDQogImh0dHA6Ly9leGFt.
                cGxlLmNvbS9pc19yb290Ijp0cnVlfQ
    """

    authentication_header_prefix = "Bearer"

    def authenticate(self, request):

        request.user = None

        auth_header = authentication.get_authorization_header(request).split()
        auth_header_prefix = self.authentication_header_prefix.lower()

        if not auth_header:
            return None

        if len(auth_header) == 1:

            return None

        elif len(auth_header) > 2:

            return None

        prefix = auth_header[0].decode("utf-8")
        token = auth_header[1].decode("utf-8")

        if prefix.lower() != auth_header_prefix:

            return None

        return self._authenticate_credentials(request, token)

    def _authenticate_credentials(self, request, token):

        try:
            payload = decode_jwt_token(token)
        except:
            msg = "Invalid authentication. Could not decode token."
            raise exceptions.AuthenticationFailed(msg)

        try:
            user = self._get_valid_user(payload)
        except User.DoesNotExist:
            msg = "No user matching this token was found."
            raise exceptions.AuthenticationFailed(msg)

        if not user.is_active:
            msg = "This user has been deactivated."
            raise exceptions.AuthenticationFailed(msg)
        # enforce_csrf(request)
        return user, token

    def _get_valid_user(self, payload):
        token_id = payload.get("token_id")
        try:
            access_token = (
                AccessToken.objects.select_related(
                    "user",
                    "user__profile",
                    "user__profile__department",
                    "user__company",
                    "user__role",
                )
                .prefetch_related("user__role__permissions")
                .get(id=token_id)
            )
            if access_token.is_valid():
                return access_token.user
            msg = "Token was not valid."
            raise exceptions.AuthenticationFailed(msg)
        except AccessToken.DoesNotExist:
            msg = "No matching token was found."
            raise exceptions.AuthenticationFailed(msg)


from drf_spectacular.extensions import OpenApiAuthenticationExtension


class TokenScheme(OpenApiAuthenticationExtension):
    target_class = "backend.Profile.authentication.JWTAuthentication"
    name = "JWTAuth"
    match_subclasses = True
    priority = 1

    def get_security_definition(self, auto_schema):
        return {
            "type": "http",
            "scheme": "bearer",
            "bearerFormat": "password access_token",
        }
