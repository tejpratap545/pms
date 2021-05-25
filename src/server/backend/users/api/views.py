from backend.appraisals.models import OverAllAppraisal
from django.db.models import Count, OuterRef, Subquery
from rest_framework import generics, status, viewsets
from rest_framework.decorators import api_view, permission_classes
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


class ProfileViewSet(viewsets.ModelViewSet):
    permission_classes = [IsProfilePermission]
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


class CompanyViewSet(viewsets.ModelViewSet):
    permission_classes = [IsSuperUser]
    serializer_class = CompanySerializer

    def get_queryset(self):
        appraisals_count = OverAllAppraisal.objects.filter(company=OuterRef("pk")).only(
            "pk"
        )
        return Company.objects.exclude(name="admin").annotate(
            employees_count=Count("user", distinct=True),
            departments_count=Count("department", distinct=True),
            appraisal_count=Count(Subquery(appraisals_count)),
        )


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
    serializer_class = RoleSerializer
    filterset_fields = ["company"]
    search_fields = ["name"]

    def get_queryset(self):
        queryset = Role.objects.all()
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


@api_view(["POST"])
@permission_classes([IsAuthenticated])
def check_username(request):
    try:
        username = request.data.get("username")
        if not User.objects.filter(username=username).exists():
            return Response("username is available")
        return Response("username not is available", status=status.HTTP_400_BAD_REQUEST)
    except:
        return Response("username not is available", status=status.HTTP_400_BAD_REQUEST)


@api_view(["POST"])
@permission_classes([IsAuthenticated])
def check_password(request):
    password = request.data.get("password")
    if check_password_strength(password):
        return Response("Password is good")
    return Response("Weak Password", status=status.HTTP_400_BAD_REQUEST)


@api_view(["POST"])
@permission_classes([IsAuthenticated])
def check_email(request):
    try:
        email = request.data.get("email")
        if not User.objects.filter(email=email).exists():
            return Response("email is available")
        return Response("email not is available", status=status.HTTP_400_BAD_REQUEST)
    except:
        return Response("email not is available", status=status.HTTP_400_BAD_REQUEST)


@api_view(["POST"])
@permission_classes([IsAuthenticated])
def check_contact_number(request):
    try:
        contact_number = request.data.get("contact_number")
        if not User.objects.filter(contact_number=contact_number).exists():
            return Response("email is available")
        return Response("email not is available", status=status.HTTP_400_BAD_REQUEST)
    except:
        return Response("email not is available", status=status.HTTP_400_BAD_REQUEST)
