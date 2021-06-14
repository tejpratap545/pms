import secrets

from backend.appraisals.models import OverAllAppraisal
from django.conf import settings
from django.core.mail import send_mail
from django.db.models import Count, OuterRef, Q, Subquery
from django.utils.datetime_safe import datetime
from drf_spectacular.types import OpenApiTypes
from drf_spectacular.utils import (OpenApiExample, OpenApiParameter,
                                   extend_schema)
from rest_framework import generics, status, viewsets
from rest_framework.decorators import action, api_view, permission_classes
from rest_framework.generics import get_object_or_404
from rest_framework.permissions import IsAdminUser, IsAuthenticated
from rest_framework.response import Response

from ..models import *
from ..permissions import *
from ..permissions import IsSuperUser
from .serializers import *


class ProfileInfoView(generics.RetrieveAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = ProfileInfoSerializer

    def get_object(self):
        return self.request.user.profile


class ShortEmployeeView(generics.ListAPIView):
    serializer_class = ShortEmployeeSerializer

    def get_queryset(self):
        return Profile.objects.select_related("user").only(
            "user__email",
            "user__first_name",
            "user__last_name",
        )


class ProfileViewSet(viewsets.ModelViewSet):
    permission_classes = [IsPermission(permissions="CAN_MANAGE_EMPLOYEE") | IsSuperUser]
    filterset_fields = [
        "user__company",
        "first_reporting_manager",
        "second_reporting_manager",
        "department",
        "gender",
        "user__role",
        "user__first_name",
        "user__username",
    ]
    search_fields = ["name"]
    serializer_class = ProfileSerializer

    def get_queryset(self):
        queryset = Profile.objects.prefetch_related(
            "user",
            "user__company",
            "user__role",
            "user__role__permissions",
        ).all()
        if not self.request.user.is_superuser:
            queryset = queryset.filter(user__company=self.request.user.company)

        return queryset

    @extend_schema(
        request=SetPasswordSerializer,
        responses={
            200: OpenApiResponse(
                description="Password is sccuessfully set",
            ),
            400: OpenApiResponse(description="Bad Request (Something Invalid)"),
            401: OpenApiResponse(
                description="Authentication credentials were not provided."
            ),
        },
    )
    @action(detail=True, methods=["post"])
    def set_password(self, request, pk=None):
        user = self.get_object().user
        serializer = SetPasswordSerializer(data=request.data)
        if serializer.is_valid():
            user.set_password(serializer.validated_data["password1"])
            user.save()
            return Response("Password is sccuessfully set")
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    @extend_schema(
        request=ChangePasswordSerializer,
        responses={
            200: OpenApiResponse(
                description="Password is Successfully Changed",
            ),
            400: OpenApiResponse(description="Bad Request (Something Invalid)"),
            400: OpenApiResponse(description="Wrong Password"),
            401: OpenApiResponse(
                description="Authentication credentials were not provided."
            ),
        },
    )
    @action(detail=True, methods=["post"])
    def change_password(self, request, pk=None):
        user: User = self.get_object().user
        serializer = SetPasswordSerializer(data=request.data)
        if serializer.is_valid():
            if user.check_password(serializer.validated_data["password"]):
                user.set_password(serializer.validated_data["password1"])
                user.save()
                return Response("Password is Successfully Changed")
            return Response(
                {"status": "Wrong  Password"}, status=status.HTTP_400_BAD_REQUEST
            )
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    @extend_schema(
        parameters=[
            OpenApiParameter(
                name="replace_employee",
                type={"type": "int"},
                location=OpenApiParameter.QUERY,
                required=True,
                style="form",
                explode=False,
            )
        ],
        request=EmptySerializer,
        responses={
            200: OpenApiResponse(
                description="User is successfully resignd",
            ),
            400: OpenApiResponse(description="Bad Request (Something Invalid)"),
            401: OpenApiResponse(
                description="Authentication credentials were not provided."
            ),
        },
    )
    @action(detail=True, methods=["post"])
    def resign(self, request, pk=None):
        profile: Profile = self.get_object()
        user: User = profile.user
        replace_employee: Profile = get_object_or_404(
            Profile, id=request.data.get("replace_employee")
        )
        user.is_active = False
        profile.resign_date = datetime.today()
        profile.save()
        Profile.objects.filter(first_reporting_manager=profile).update(
            first_reporting_manager=replace_employee
        )
        Profile.objects.filter(second_reporting_manager=profile).update(
            second_reporting_manager=replace_employee
        )

        user.save()

        return Response("User is successfully resignd")

    @extend_schema(
        request=EmptySerializer,
        responses={
            200: OpenApiResponse(
                description="User is successfully Revieve",
            ),
            400: OpenApiResponse(description="Bad Request (Something Invalid)"),
            401: OpenApiResponse(
                description="Authentication credentials were not provided."
            ),
        },
    )
    @action(detail=True, methods=["post"])
    def revieve(self, request, pk=None):
        profile: Profile = self.get_object()
        user: User = profile.user
        user.is_active = True
        profile.resign_date = None
        profile.save()
        user.save()

        return Response( "User is successfully Revieve")


class CompanyViewSet(viewsets.ModelViewSet):
    permission_classes = [IsSuperUser]
    serializer_class = CompanySerializer

    def get_queryset(self):
        # appraisals_count = OverAllAppraisal.objects.filter(
        #     company=OuterRef("pk")
        # ).values("pk")
        # return Company.objects.exclude(name="admin").annotate(
        #     employees_count=Count("user", distinct=True),
        #     departments_count=Count("department", distinct=True),
        #     appraisal_count=Count(Subquery(appraisals_count)),
        # )
        return Company.objects.all()


class DepartmentViewSet(viewsets.ModelViewSet):
    permission_classes = [IsCompanyAdmin]
    serializer_class = DepartmentSerializer
    filterset_fields = ["company", "manager"]
    search_fields = ["name"]

    def get_queryset(self):
        queryset = Department.objects.all()
        if not self.request.user.is_superuser:
            queryset = queryset.filter(company=self.request.user.company)

        return queryset


class RoleViewSet(viewsets.ModelViewSet):
    permission_classes = [IsCompanyAdmin]
    filterset_fields = ["company"]
    search_fields = ["name"]

    def get_serializer_class(self):
        if self.request.method == "GET":
            return RoleInfoSerializer
        return RoleSerializer

    def get_queryset(self):
        queryset = Role.objects.prefetch_related("permissions").all()
        if not self.request.user.is_superuser:
            queryset = queryset.filter(company=self.request.user.company)

        return queryset


class PermissionViewSet(viewsets.ModelViewSet):
    permission_classes = [IsCompanyAdmin]
    serializer_class = PermissionSerializer
    filterset_fields = ["company"]
    search_fields = ["name"]

    def get_queryset(self):
        queryset = Permission.objects.all()
        if not self.request.user.is_superuser:
            queryset = queryset.filter(company=self.request.user.company)

        return queryset


@extend_schema(
    request=ResetPasswordTokenSerializer,
    responses={
        200: OpenApiResponse(
            description="Token succcessfully send to  user@email.com . Please check your email.",
        ),
        400: OpenApiResponse(description="error sending  token"),
    },
    auth=None,
)
@api_view(["POST"])
def get_token(request):
    serializer = ResetPasswordTokenSerializer(data=request.data)

    if serializer.is_valid():
        try:
            username = serializer.validated_data["username"]

            token = secrets.token_hex(3)
            user: User = User.objects.get(
                Q(email=username) | Q(contact_number=username) | Q(username=username),
            )

            ResetPasswordToken.objects.create(user=user, token=token)

            send_mail(
                "Password reset token",
                f"Hi {user.username} your one time token for reset password is {token} ",
                settings.OFFICIAL_MAIL,
                [user.email],
            )

            return Response(
                f"Token succcessfully send to  {user.email}. Please check your email."
            )
        except:
            return Response({"msg": "Errors"}, status=status.HTTP_400_BAD_REQUEST)

    else:
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@extend_schema(
    request=ResetPasswordSerializer,
    responses={
        200: OpenApiResponse(
            description="password  is successfully reset",
        ),
        400: OpenApiResponse(description="error reset password"),
    },
    auth=None,
)
@api_view(["POST"])
def reset_password(request):
    serializer = ResetPasswordSerializer(data=request.data)
    if serializer.is_valid():
        username = serializer.validated_data["username"]
        user = User.objects.get(
            Q(email=username) | Q(contact_number=username) | Q(username=username),
        )
        if ResetPasswordToken.objects.filter(
            token=serializer.validated_data["token"], user=user
        ).exists():
            ResetPasswordToken.objects.filter(
                token=serializer.validated_data["token"], user=user
            ).delete()
            user.set_password(serializer.validated_data["password1"])
            user.save()
            return Response("password  is successfully reset")
        return Response("error reset password", status=status.HTTP_400_BAD_REQUEST)
    else:
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@extend_schema(
    request=CheckUsernameSerializer,
    responses={
        200: OpenApiResponse(
            description="username is available",
        ),
        400: OpenApiResponse(description="username is not available"),
        401: OpenApiResponse(
            description="Authentication credentials were not provided."
        ),
    },
)
@api_view(["POST"])
@permission_classes([IsAuthenticated])
def check_username(request):
    try:
        username = request.data.get("username")
        if not User.objects.filter(username=username).exists():
            return Response("username is available")
        return Response("username is not available", status=status.HTTP_400_BAD_REQUEST)
    except:
        return Response("username is not available", status=status.HTTP_400_BAD_REQUEST)


@extend_schema(
    request=ChangePasswordSerializer,
    responses={
        200: OpenApiResponse(
            description="Password is strong",
        ),
        400: OpenApiResponse(description="Password is Weak"),
        401: OpenApiResponse(
            description="Authentication credentials were not provided."
        ),
    },
)
@api_view(["POST"])
@permission_classes([IsAuthenticated])
def check_password(request):
    password = request.data.get("password")
    if check_password_strength(password):
        return Response("Password is good")
    return Response("Password is Weak", status=status.HTTP_400_BAD_REQUEST)


@extend_schema(
    request=CheckEmailSerializer,
    responses={
        200: OpenApiResponse(
            description="email is available",
        ),
        400: OpenApiResponse(description="email is not available"),
        401: OpenApiResponse(
            description="Authentication credentials were not provided."
        ),
    },
)
@api_view(["POST"])
@permission_classes([IsAuthenticated])
def check_email(request):
    try:
        email = request.data.get("email")
        if not User.objects.filter(email=email).exists():
            return Response("email is available")
        return Response("email is not available", status=status.HTTP_400_BAD_REQUEST)
    except:
        return Response("email is not available", status=status.HTTP_400_BAD_REQUEST)


@extend_schema(
    request=CheckContactNumberSerializer,
    responses={
        200: OpenApiResponse(
            description="Contact Numbe is available",
        ),
        400: OpenApiResponse(description="Contact Number is not available"),
        401: OpenApiResponse(
            description="Authentication credentials were not provided."
        ),
    },
)
@api_view(["POST"])
@permission_classes([IsAuthenticated])
def check_contact_number(request):
    try:
        contact_number = request.data.get("contact_number")
        if not User.objects.filter(contact_number=contact_number).exists():
            return Response("Contact Number is available")
        return Response(
            "Contact Number is not available", status=status.HTTP_400_BAD_REQUEST
        )
    except:
        return Response(
            "Contact Number is not  available", status=status.HTTP_400_BAD_REQUEST
        )
