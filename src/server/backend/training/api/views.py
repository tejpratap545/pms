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
from django.db.models import Sum


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
    queryset = Goal.objects.all()
    serializer_class = GoalSerializer

    def perform_create(self, serializer):

        validated_data = serializer.validated_data
        weightage_sum = self.get_object().appraisal.goal_set.aggregate(Sum("weightage"))
        if weightage_sum["weightage__sum"] is None:
            return super().perform_create(serializer)

        elif (
            int(validated_data.get("weightage")) + int(weightage_sum["weightage__sum"])
            > 100
        ):
            raise ValueError("Total weightage should be less then 100")
        else:
            return super().perform_create(serializer)

    def perform_update(self, serializer):
        validated_data = serializer.validated_data
        if validated_data.get("weightage"):
            weightage_sum = self.get_object().appraisal.goal_set.aggregate(
                Sum("weightage")
            )
            if weightage_sum["weightage__sum"] is None:
                return super().perform_update(serializer)
            elif (
                int(validated_data.get("weightage"))
                + int(weightage_sum["weightage__sum"])
                - self.get_object().weightage
                > 100
            ):
                raise ValueError("Total weightage should be less then 100")
            else:
                return super().perform_update(serializer)

        return super().perform_update(serializer)

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
    queryset = CoreValue.objects.all()
    serializer_class = CoreValueSerializer

    def perform_create(self, serializer):

        validated_data = serializer.validated_data
        weightage_sum = self.get_object().appraisal.corevalue_set.aggregate(
            Sum("weightage")
        )
        if weightage_sum["weightage__sum"] is None:
            return super().perform_create(serializer)

        elif (
            int(validated_data.get("weightage")) + int(weightage_sum["weightage__sum"])
            > 100
        ):
            raise ValueError("Total weightage should be less then 100")
        else:
            return super().perform_create(serializer)

    def perform_update(self, serializer):
        validated_data = serializer.validated_data
        if validated_data.get("weightage"):
            weightage_sum = self.get_object().appraisal.corevalue_set.aggregate(
                Sum("weightage")
            )
            if weightage_sum["weightage__sum"] is None:
                return super().perform_update(serializer)
            elif (
                int(validated_data.get("weightage"))
                + int(weightage_sum["weightage__sum"])
                - self.get_object().weightage
                > 100
            ):
                raise ValueError("Total weightage should be less then 100")
            else:
                return super().perform_update(serializer)

        return super().perform_update(serializer)


class SkillViewSET(viewsets.ModelViewSet):
    queryset = Skill.objects.all()
    serializer_class = SkillSerializer

    def perform_create(self, serializer):

        validated_data = serializer.validated_data
        weightage_sum = self.get_object().appraisal.skill_set.aggregate(
            Sum("weightage")
        )
        if weightage_sum["weightage__sum"] is None:
            return super().perform_create(serializer)

        elif (
            int(validated_data.get("weightage")) + int(weightage_sum["weightage__sum"])
            > 100
        ):
            raise ValueError("Total weightage should be less then 100")
        else:
            return super().perform_create(serializer)

    def perform_update(self, serializer):
        validated_data = serializer.validated_data
        if validated_data.get("weightage"):
            weightage_sum = self.get_object().appraisal.skill_set.aggregate(
                Sum("weightage")
            )
            if weightage_sum["weightage__sum"] is None:
                return super().perform_update(serializer)
            elif (
                int(validated_data.get("weightage"))
                + int(weightage_sum["weightage__sum"])
                - self.get_object().weightage
                > 100
            ):
                raise ValueError("Total weightage should be less then 100")
            else:
                return super().perform_update(serializer)

        return super().perform_update(serializer)


class KPIViewSet(viewsets.ModelViewSet):
    queryset = KPI.objects.all()
    serializer_class = KPISerializer


class DepartmentalGoalViewset(viewsets.ModelViewSet):
    queryset = DepartmentalGoal.objects.all()
    serializer_class = DepartmentalGoalSerializer


class DepartmentalCoreValueViewset(viewsets.ModelViewSet):
    queryset = DepartmentalCoreValue.objects.all()
    serializer_class = DepartmentalCoreValueSerializer
