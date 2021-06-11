from backend.users.api.serializers import EmptySerializer
from backend.users.permissions import *
from django.db.models import Count
from drf_spectacular.utils import (
    OpenApiExample,
    OpenApiParameter,
    OpenApiResponse,
    extend_schema,
)
from rest_framework import generics, mixins, viewsets
from rest_framework.decorators import action, api_view, permission_classes
from rest_framework.generics import get_object_or_404
from rest_framework.response import Response

from ..models import *
from .pagination import *
from .serializers import *


class OverAllAppraisalViewSet(viewsets.ModelViewSet):
    serializer_class = OverAllAppraisalSerializer
    permission_classes = [IsPermission(permissions=["CAN_MANAGE_APPRAISAL"])]
    filterset_fields = ["name", "stage", "company"]

    def get_queryset(self):
        queryset = OverAllAppraisal.objects.all()
        if not self.request.user.is_superuser:
            queryset = queryset.filter(company=self.request.user.company).annotate(
                employee_count=Count("appraisal", distinct=True)
            )

        return queryset


class AppraisalViewset(viewsets.ModelViewSet):
    pagination_class = StandardResultsSetPagination
    filterset_fields = [
        "status",
        "overall_appraisal",
        "overall_appraisal__stage",
        "overall_appraisal__company",
        "employee",
        "employee__department",
        "employee__first_reporting_manager",
        "employee__second_reporting_manager",
    ]

    search_fields = [
        "overall_appraisal__name",
        "employee__department__name",
        "employee__user__name",
        "employee__user__email",
        "employee__first_reporting_manager__name",
        "employee__second_reporting_manager__name",
        "employee__first_reporting_manager__email",
        "employee__second_reporting_manager__email",
    ]

    def get_serializer_class(self):
        if self.action == "retrieve":
            return DetailAppraisalSerializer

        if self.action == "list":
            return ShortAppraisalSerializer
        return AppraisalSerializer

    queryset = Appraisal.objects.all()

    def get_queryset(self):
        if not self.request.user.is_superuser:
            return super().get_queryset().filter(company=self.request.user.company)

        return super().get_queryset()

    def get_queryset(self):
        if self.action == "list":
            return (
                Appraisal.objects.select_related(
                    "overall_appraisal",
                    "employee",
                    "employee__department",
                    "employee__first_reporting_manager",
                    "employee__second_reporting_manager",
                )
                .only(
                    "overall_appraisal__name",
                    "overall_appraisal__stage",
                    "status",
                    "employee",
                )
                .annotate(
                    goal_count=Count("goal", distinct=True),
                    corevalue_count=Count("corevalue", distinct=True),
                    skill_count=Count("skill", distinct=True),
                )
            )

        if self.action == "retrieve":
            return (
                super()
                .get_queryset()
                .prefetch_related(
                    "overall_appraisal",
                    "goal_set",
                    "goal_set__goal__category",
                    "goal_set__kpi",
                    "corevalue_set",
                    "corevalue_set__category",
                    "skill_set",
                    "skill_set__category",
                )
                .annotate(
                    goal_count=Count("goal", distinct=True),
                    corevalue_count=Count("corevalue", distinct=True),
                    skill_count=Count("skill", distinct=True),
                )
            )
        return super().get_queryset()

    @extend_schema(
        request=EmptySerializer,
        responses={
            201: OpenApiResponse(
                response=None,
                description="Stage of Appraisal  is successfully up",
            ),
            400: OpenApiResponse(description="Bad request (something invalid)"),
        },
    )
    @action(detail=True, methods=["post"], url_path="up-stage")
    def up_stage(self, request, pk=None):
        appraisal: Appraisal = self.get_object()
        employee_stage = [0, 1, 4, 5, 8, 9]
        manager_stage = [2, 6, 10]
        stage_1 = [0, 1, 2, 3]
        stage: int = appraisal.status

        if (stage in employee_stage and appraisal.employee == request.user.profile) or (
            stage in manager_stage and appraisal.employee.manager == self.request.user
        ):

            appraisal.status += 1
            appraisal.save()
            pass

        return Response({"status": "Appraisal is successfully Updated"})


def appraisal_query():
    return Appraisal.objects.prefetch_related(
        "overall_appraisal",
        "goal_set",
        "goal_set__goal__category",
        "goal_set__kpi",
        "corevalue_set",
        "corevalue_set__category",
        "skill_set",
        "skill_set__category",
    ).annotate(
        goal_count=Count("goal", distinct=True),
        corevalue_count=Count("corevalue", distinct=True),
        skill_count=Count("skill", distinct=True),
    )


class MyAppraisalView(generics.ListAPIView):
    serializer_class = DetailAppraisalSerializer

    def get_queryset(self):
        return appraisal_query().filter(employee=self.request.user.profile)


class ManagerAppraisalView(generics.ListAPIView):
    serializer_class = ShortAppraisalSerializer

    def get_queryset(self):
        queryset = appraisal_query()
        return (
            Appraisal.objects.select_related(
                "overall_appraisal",
                "employee",
                "employee__department",
                "employee__first_reporting_manager",
                "employee__second_reporting_manager",
            )
            .only(
                "overall_appraisal__name",
                "overall_appraisal__stage",
                "status",
                "employee",
            )
            .annotate(
                goal_count=Count("goal", distinct=True),
                corevalue_count=Count("corevalue", distinct=True),
                skill_count=Count("skill", distinct=True),
            )
            .filter(employee__first_reporting_manager=self.request.user.profile)
        )
