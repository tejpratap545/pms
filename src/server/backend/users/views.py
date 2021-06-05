import secrets

from _datetime import timedelta
from django.db.models.query_utils import Q
from django.shortcuts import render
from django.utils import timezone
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.generics import get_object_or_404
from rest_framework.response import Response
from rest_framework.views import APIView

from backend.users.models import (AccessToken, Company, Profile, RefreshToken,
                                  User)

from .backend import decode_jwt_token, encode_jwt_token

# Create your views here.


class TokenView(APIView):
    def _invalid_grant_response(self):
        return Response(
            data={
                "msg": "Ivalid Grant",
            },
            status=status.HTTP_400_BAD_REQUEST,
        )

    def _generate_token_response(self, user, grant_type):
        access_token = AccessToken.objects.create(
            user=user,
            token=secrets.token_urlsafe(),
            expires=timezone.now() + timedelta(seconds=172800),
        )
        refresh_token = RefreshToken.objects.create(
            user=user,
            access_token=access_token,
            token=secrets.token_urlsafe(),
        )
        return Response(
            data={
                "access_token": encode_jwt_token(
                    expires_in=172800,
                    token_id=access_token.id,
                    token_provider="password",
                    grant_type="access_token",
                    user_id=user.id,
                ),
                "refresh_token": encode_jwt_token(
                    expires_in=31449600,
                    token_id=refresh_token.id,
                    token_provider="password",
                    grant_type="refresh_token",
                    user_id=user.id,
                ),
                "expire": timezone.now() + timedelta(seconds=172800),
                "grant_type": grant_type,
            },
            status=status.HTTP_200_OK,
        )

    def post(self, request):
        grant_type = request.data.get("grant_type", "access_token")
        if grant_type == "access_token":
            username = request.data.get("username")
            password = request.data.get("password")

            try:
                user = User.objects.get(
                    Q(
                        Q(username=username)
                        | Q(email=username)
                        | Q(contact_number=username)
                    )
                    & Q(is_active=True)
                )
                if user.check_password(password):
                    return self._generate_token_response(user, grant_type)
                return self._invalid_grant_response()

            except User.DoesNotExist:
                return self._invalid_grant_response()

        elif grant_type == "refresh_token":
            refresh_token = decode_jwt_token(request.data.get("refresh_token"))
            token = RefreshToken.objects.get(id=refresh_token["token_id"])
            user = token.user
            if token.revoked is None:
                token.delete()
                return self._generate_token_response(user, grant_type)

            else:
                return self._invalid_grant_response()

        else:
            return self._invalid_grant_response()


@api_view(["POST"])
def create_admin_user(request):
    username = request.data.get("username", "superadmin")
    email = request.data.get("email", "admin@pms.com")
    contact_number = request.data.get("contact_number", "")
    password = request.data.get("password", "password")

    domain = request.data.get("domain", "localhost:3000")
    company_name = request.data.get("company_name", "admin")
    user = User.objects.create_superadmin(
        username=username, email=email, contact_number=contact_number, password=password
    )
    user.company = Company.objects.create(name=company_name, domain=domain)
    user.save()

    profile = Profile.objects.create(user=user)
    profile.first_reporting_manager = profile
    profile.second_reporting_manager = profile
    profile.save()

    return Response(status=201, data={"msg": "Superadmin is successfully created"})
