from backend.users.api.serializers import EmptySerializer
from backend.users.permissions import *
from django.db.models import Count, Prefetch, Q
from drf_spectacular.utils import (
    OpenApiExample,
    OpenApiParameter,
    OpenApiResponse,
    extend_schema,
)
from rest_framework import generics, mixins, viewsets
from rest_framework.decorators import action, api_view, permission_classes
from rest_framework.generics import get_object_or_404
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

from ..models import *
from .pagination import *
from .serializers import *


class OverAllAppraisalViewSet(viewsets.ModelViewSet):
    permission_classes = [IsPermission(permissions=["CAN_MANAGE_APPRAISAL"])]
    filterset_fields = ["name", "stage", "company"]

    def get_queryset(self):
        queryset = OverAllAppraisal.objects.all()
        if not self.request.user.is_superuser:
            queryset = queryset.filter(company=self.request.user.company).annotate(
                employee_count=Count("appraisal", distinct=True)
            )

        if self.request.method == "GET":
            queryset = queryset.prefetch_related(
                "departmentalgoal_set", "departmentalcorevalue_set"
            )

        return queryset

    def get_serializer_class(self):
        if self.request.method == "GET":
            return DetailOverallAppraisalSerializer
        return OverAllAppraisalSerializer


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
        "employee__user__first_name",
        "employee__user__email",
        "employee__user__username",
        "employee__first_reporting_manager__user__first_name",
        "employee__second_reporting_manager__user__first_name",
        "employee__first_reporting_manager__user__username",
        "employee__second_reporting_manager__user__username",
        "employee__first_reporting_manager__user__email",
        "employee__second_reporting_manager__user__email",
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
            return super().get_queryset()

        if self.action == "retrieve":
            return super().get_queryset()
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
        """
        Which users and in which satge they can up status the appraisal.
        Employee can upsatge the appraisal in employee stages

        For status 0 ----> status 1
           1. At least one goal , core value and skill
           2. All goals have at least one kpi
           3. All gols , core value and skill have 100 weightage
           4. user must be employee
           5. Overall Appraisal must in stage 1

        for status 1 -----> status 2
           1. user must be first reporting manager of employee
           2. Overall Appraisal must in stage 1
           3. Must be all goal approved by the first reporting manager


        """
        appraisal: Appraisal = self.get_object()
        employee_stage = appraisal.employee_stages()
        manager_stage = appraisal.manager_stages()
        stage_1 = [0, 1, 2, 3]
        stage: int = appraisal.status

        if (stage in employee_stage and appraisal.employee == request.user.profile) or (
            stage in manager_stage and appraisal.employee.manager == self.request.user
        ):
            if appraisal.can_upsatus(user=self.request.user.profile):

                appraisal.status += 1
                appraisal.save()
                return Response({"status": "Appraisal is successfully Updated"})
        return Response(status=400, data="Bad request (something invalid)")


class MyAppraisalView(generics.ListAPIView):
    serializer_class = DetailAppraisalSerializer

    def get_queryset(self):
        return Appraisal.objects.detail().filter(employee=self.request.user.profile)


class ManagerAppraisalView(generics.ListAPIView):
    serializer_class = ShortAppraisalSerializer

    def get_queryset(self):
        return Appraisal.objects.short2().filter(
            employee__first_reporting_manager=self.request.user.profile
        )


@extend_schema(
    responses={
        201: OpenApiResponse(
            response=StatusSerializer,
            description="Employee current appraisal status",
        ),
        400: OpenApiResponse(description="Bad request (something invalid)"),
        401: OpenApiResponse(
            description="Authentication credentials were not provided."
        ),
    },
)
@api_view(["GET"])
@permission_classes([IsAuthenticated])
def appraisal_status(request):

    queryset = (
        Appraisal.objects.select_related("overall_appraisal")
        .filter(employee=request.user.profile)
        .only("id", "overall_appraisal__stage")
        .aggregate(
            a1=Count("id", filter=Q(overall_appraisal__stage=0)),
            a2=Count("id", filter=Q(overall_appraisal__stage=1)),
            a3=Count("id", filter=Q(overall_appraisal__stage=2)),
        )
    )

    serializer = StatusSerializer(queryset)

    return Response(serializer.data)


class ShortManagerAppraisal(generics.ListAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = ShortProfile2Serializer

    def get_queryset(self):
        return Profile.objects.prefetch_related(
            Prefetch(
                "appraisal_set",
                Appraisal.objects.short1(),
            ),
            "department",
            "user",
        ).filter(first_reporting_manager=self.request.user.profile)


class ShortHodAppraisal(generics.ListAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = ShortProfile2Serializer

    def get_queryset(self):
        return Profile.objects.prefetch_related(
            Prefetch(
                "appraisal_set",
                Appraisal.objects.short1(),
            ),
            "department",
            "user",
        ).filter(second_reporting_manager=self.request.user.profile)
