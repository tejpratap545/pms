from backend.users.permissions import *
from rest_framework import viewsets
from rest_framework.permissions import IsAdminUser, IsAuthenticated

from ..models import *
from .serializers import *


class GoalCategoryViewSet(viewsets.ModelViewSet):
    permission_classes = [
        IsCompanyAdmin | IsPermission(permissions=["CAN_MANAGE_COMPANY"])
    ]
    serializer_class = GoalCategorySerializer
    filterset_fields = ["company"]
    search_fields = ["name"]

    def get_queryset(self):
        queryset = GoalCategory.objects.all()
        if not self.request.user.is_superuser:
            queryset = queryset.filter(company=self.request.user.company)

        return queryset


class CoreValueCategoryViewSet(viewsets.ModelViewSet):
    permission_classes = [
        IsCompanyAdmin | IsPermission(permissions=["CAN_MANAGE_COMPANY"])
    ]
    serializer_class = CoreValueCategorySerializer
    filterset_fields = ["company"]
    search_fields = ["name"]

    def get_queryset(self):
        queryset = CoreValueCategory.objects.all()
        if not self.request.user.is_superuser:
            queryset = queryset.filter(company=self.request.user.company)

        return queryset


class SkillsCategoryViewSet(viewsets.ModelViewSet):
    permission_classes = [
        IsCompanyAdmin | IsPermission(permissions=["CAN_MANAGE_COMPANY"])
    ]
    serializer_class = SkillsCategorySerializer
    filterset_fields = ["company"]
    search_fields = ["name"]

    def get_queryset(self):
        queryset = SkillsCategory.objects.all()
        if not self.request.user.is_superuser:
            queryset = queryset.filter(company=self.request.user.company)

        return queryset
