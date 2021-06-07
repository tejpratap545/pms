from backend.users.api.serializers import EmptySerializer
from backend.users.permissions import *
from drf_spectacular.utils import (
    OpenApiExample,
    OpenApiParameter,
    OpenApiResponse,
    extend_schema,
)
from rest_framework import viewsets
from rest_framework.decorators import action, api_view, permission_classes
from rest_framework.permissions import IsAdminUser, IsAuthenticated
from rest_framework.response import Response

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


class GoalViewSET(viewsets.ModelViewSet):
    querset = Goal.objects.all()
    serializer_class = GoalSerializer

    @extend_schema(
        request=EmptySerializer,
        responses={
            201: OpenApiResponse(
                response=None,
                description="Goal is successfully Approvaed",
            ),
            400: OpenApiResponse(description="Bad request (something invalid)"),
        },
    )
    @action(detail=True, methods=["post"])
    def approve(self, request, pk=None):
        goal: Goal = self.get_object()
        goal.status = 1
        goal.save()

        return Response({"status": "Goal is successfully Approvaed"})

    @extend_schema(
        request=EmptySerializer,
        responses={
            201: OpenApiResponse(
                response=None,
                description="Goal is successfully Rejected",
            ),
            400: OpenApiResponse(description="Bad request (something invalid)"),
        },
    )
    @action(detail=True, methods=["post"])
    def reject(self, request, pk=None):
        goal: Goal = self.get_object()
        goal.status = -1
        goal.save()

        return Response({"status": "Goal is successfully Rejected"})


class CoreValueViewSET(viewsets.ModelViewSet):
    querset = CoreValue.objects.all()
    serializer_class = CoreValueSerializer


class SkillViewSET(viewsets.ModelViewSet):
    querset = Skill.objects.all()
    serializer_class = SkillSerializer
