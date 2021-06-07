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


class AppraisalViewset(
    mixins.RetrieveModelMixin, mixins.UpdateModelMixin, viewsets.GenericViewSet
):
    serializer_class = AppraisalSerializer
    queryset = Appraisal.objects.all()

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
