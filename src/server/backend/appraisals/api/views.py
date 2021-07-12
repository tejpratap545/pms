from cmath import log
import profile
from backend.users.api.serializers import EmptySerializer
from backend.users.models import User
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
from rest_framework import status
from ..models import *
from .pagination import *
from .serializers import *
from drf_spectacular.types import OpenApiTypes


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
            return (
                super()
                .get_queryset()
                .select_related(
                    "overall_appraisal",
                    "employee",
                    "employee__user",
                    "employee__department",
                    "employee__first_reporting_manager",
                    "employee__first_reporting_manager__user",
                    "employee__second_reporting_manager",
                    "employee__second_reporting_manager__user",
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
                    "goal_set__category",
                    "goal_set__kpi_set",
                    "corevalue_set",
                    "corevalue_set__category",
                    "skill_set",
                    "skill_set__category",
                    "overall_appraisal__departmentalgoal_set",
                    "overall_appraisal__departmentalcorevalue_set",
                    "employee",
                    "employee__user",
                    "employee__department",
                    "employee__first_reporting_manager",
                    "employee__first_reporting_manager__user",
                    "employee__second_reporting_manager",
                    "employee__second_reporting_manager__user",
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
    @action(detail=True, methods=["post"], url_path="up-stage/")
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
            stage in manager_stage
            and appraisal.employee.first_reporting_manager == self.request.user.profile
        ):
            if appraisal.can_upsatus(user=self.request.user.profile):

                appraisal.status += 1
                appraisal.save()
                return Response("Appraisal is successfully Updated")
        return Response(status=400, data="Bad request (something invalid)")

    @action(detail=True, methods=["post"], url_path="up-stage/submit")
    def submit(self, request, pk=None):
        """
        Submit appraisal to manager
        1. At least one goal , core value and skill
        2. All goals have at least one kpi
        3. All gols , core value and skill have 100 weightage
        4. user must be employee
        5. Overall Appraisal must in stage 0
        """
        appraisal: Appraisal = self.get_object()
        if appraisal.employee != self.request.user.profile:
            return Response(status=status.HTTP_401_UNAUTHORIZED)
        if (
            appraisal.stage == 0
            and appraisal.status == 0
            and appraisal.is_100_weightage
            and appraisal.is_at_least_one_kpi
        ):
            appraisal.status += 1
            appraisal.save()

            # create logs and notifications

            title = f"{appraisal.employee.name} submit appraisal {appraisal.name}"
            description = (
                f"Hi {appraisal.employee.first_reporting_manager.name} Employee {appraisal.employee.name} submit appraisal {appraisal.name} . "
                f"Please approve all goals and then approve appraisal "
            )
            color = "info"
            Logs.objects.create(user=appraisal.employee, title=title, color=color)
            Notification.objects.create(
                user=appraisal.employee.first_reporting_manager,
                title=title,
                description=description,
                color=color,
            )
            try:
                send_mail(
                    title,
                    description,
                    settings.OFFICIAL_MAIL,
                    [appraisal.employee.first_reporting_manager.user.email],
                )
            except:
                pass
            return Response("Appraisal is successfully approved")

        return Response(
            status=status.HTTP_400_BAD_REQUEST,
            data="Error is approving appraisal",
        )

    @action(detail=True, methods=["post"], url_path="up-stage/approve")
    def approve(self, request, pk=None):
        """
        Approve appraisal by manager
        1. user must be first reporting manager of employee
        2. Overall Appraisal must in stage 0
        3. Must be all goal approved by the first reporting manager

        """
        appraisal: Appraisal = self.get_object()
        if appraisal.employee.first_reporting_manager != self.request.user.profile:
            return Response(status=status.HTTP_401_UNAUTHORIZED)
        if (
            appraisal.stage == 0
            and appraisal.status == 1
            and appraisal.is_all_goal_approved
        ):
            appraisal.status += 1
            appraisal.save()
            # create logs and notifications

            title = f"{appraisal.employee.first_reporting_manager.name} approve appraisal {appraisal.name}"
            description = f"Hi {appraisal.employee.name} manager {appraisal.employee.first_reporting_manager.name} approve appraisal {appraisal.name} . "
            color = "success"
            Logs.objects.create(
                user=appraisal.employee.first_reporting_manager,
                title=title,
                color=color,
            )
            Notification.objects.create(
                user=appraisal.employee,
                title=title,
                description=description,
                color=color,
            )
            try:
                send_mail(
                    title,
                    description,
                    settings.OFFICIAL_MAIL,
                    [appraisal.employee.user.email],
                )
            except:
                pass
            return Response("Appraisal is successfully submitted")

        return Response(
            status=status.HTTP_400_BAD_REQUEST,
            data="Appraisal is successfully submitted",
        )

    @action(detail=True, methods=["post"], url_path="up-stage/employee/mid-review")
    def mid_review_employee(self, request, pk=None):
        """
        Submit Mid Review By Employee

        """
        appraisal: Appraisal = self.get_object()
        if appraisal.employee != self.request.user.profile:
            return Response(status=status.HTTP_401_UNAUTHORIZED)
        if appraisal.stage == 1 and (appraisal.status == 2 or appraisal.status == 3):
            appraisal.status = 3
            appraisal.save()

            # create logs and notifications

            title = f"{appraisal.employee.name} input mid year review of appraisal  {appraisal.name}"
            color = "info"
            Logs.objects.create(user=appraisal.employee, title=title, color=color)
            return Response("Appraisal is successfully submitted")

        return Response(
            status=status.HTTP_400_BAD_REQUEST,
            data="Appraisal is successfully submitted",
        )

    @action(detail=True, methods=["post"], url_path="up-stage/employee/mid-submit")
    def mid_submit_employee(self, request, pk=None):
        """
        Submit Mid Review By Employee

        """
        appraisal: Appraisal = self.get_object()
        if appraisal.employee != self.request.user.profile:
            return Response(status=status.HTTP_401_UNAUTHORIZED)
        if appraisal.stage == 1 and appraisal.status == 3:
            appraisal.status += 1
            appraisal.save()

            # create logs and notifications

            title = f"{appraisal.employee.name} submit mid year review of appraisal {appraisal.name}"
            description = (
                f"Hi {appraisal.employee.first_reporting_manager.name} Employee {appraisal.employee.name} submit mid year review of appraisa {appraisal.name} . "
                f"Please add mid year comment and approve mid year review  "
            )
            color = "info"
            Logs.objects.create(user=appraisal.employee, title=title, color=color)
            Notification.objects.create(
                user=appraisal.employee.first_reporting_manager,
                title=title,
                description=description,
                color=color,
            )
            try:
                send_mail(
                    title,
                    description,
                    settings.OFFICIAL_MAIL,
                    [appraisal.employee.first_reporting_manager.user.email],
                )
            except:
                pass
            return Response("Appraisal is successfully submitted")

        return Response(
            status=status.HTTP_400_BAD_REQUEST,
            data="Appraisal is successfully submitted",
        )

    @action(detail=True, methods=["post"], url_path="up-stage/manager/mid-review")
    def mid_review_manager(self, request, pk=None):
        """
        Mid Review By Manager

        """
        appraisal: Appraisal = self.get_object()
        if appraisal.employee.first_reporting_manager != self.request.user.profile:
            return Response(status=status.HTTP_401_UNAUTHORIZED)
        if appraisal.stage == 1 and appraisal.status == 4 or appraisal.status == 5:
            appraisal.status = 5
            appraisal.save()
            return Response("Appraisal is successfully submitted")

        return Response(
            status=status.HTTP_400_BAD_REQUEST,
            data="Appraisal is successfully submitted",
        )

    @action(detail=True, methods=["post"], url_path="up-stage/manager/mid-approve")
    def mid_approve_manager(self, request, pk=None):
        """
        Approve Mid Review By Manager

        """
        appraisal: Appraisal = self.get_object()
        if appraisal.employee.first_reporting_manager != self.request.user.profile:
            return Response(status=status.HTTP_401_UNAUTHORIZED)
        if appraisal.stage == 1 and appraisal.status == 5:
            appraisal.status += 1
            appraisal.save()

            # create logs and notifications

            title = f"{appraisal.employee.first_reporting_manager.name} approve mid year review of  appraisal {appraisal.name}"
            description = f"Hi {appraisal.employee.name} manager {appraisal.employee.first_reporting_manager.name} approve mid year review of  appraisal {appraisal.name} . "
            color = "success"
            Logs.objects.create(
                user=appraisal.employee.first_reporting_manager,
                title=title,
                color=color,
            )
            Notification.objects.create(
                user=appraisal.employee,
                title=title,
                description=description,
                color=color,
            )
            try:
                send_mail(
                    title,
                    description,
                    settings.OFFICIAL_MAIL,
                    [appraisal.employee.user.email],
                )
            except:
                pass
            return Response("Appraisal is successfully submitted")

        return Response(
            status=status.HTTP_400_BAD_REQUEST,
            data="Appraisal is successfully submitted",
        )

    @action(detail=True, methods=["post"], url_path="up-stage/employee/end-review")
    def end_review_employee(self, request, pk=None):
        """
        End Year Review By Employee

        """
        appraisal: Appraisal = self.get_object()
        if appraisal.employee != self.request.user.profile:
            return Response(status=status.HTTP_401_UNAUTHORIZED)
        if appraisal.stage == 2 and (appraisal.status == 6 or appraisal.status == 7):
            appraisal.status = 7
            appraisal.save()
            return Response("Appraisal is successfully submitted")

        return Response(
            status=status.HTTP_400_BAD_REQUEST,
            data="Appraisal is successfully submitted",
        )

    @action(detail=True, methods=["post"], url_path="up-stage/employee/end-submit")
    def end_submit_employee(self, request, pk=None):
        """
        Submit End Year Review By Employee

        """
        appraisal: Appraisal = self.get_object()
        if appraisal.employee != self.request.user.profile:
            return Response(status=status.HTTP_401_UNAUTHORIZED)
        if appraisal.stage == 2 and appraisal.status == 7:
            appraisal.status += 1
            appraisal.save()

            # create logs and notifications

            title = f"{appraisal.employee.name} submit end year review of appraisal {appraisal.name}"
            description = (
                f"Hi {appraisal.employee.first_reporting_manager.name} Employee {appraisal.employee.name} submit end year review of appraisal {appraisal.name} . "
                f"Please add end year comment and approve end year review ."
            )
            color = "info"
            Logs.objects.create(user=appraisal.employee, title=title, color=color)
            Notification.objects.create(
                user=appraisal.employee.first_reporting_manager,
                title=title,
                description=description,
                color=color,
            )
            try:
                send_mail(
                    title,
                    description,
                    settings.OFFICIAL_MAIL,
                    [appraisal.employee.first_reporting_manager.user.email],
                )
            except:
                pass
            return Response("Appraisal is successfully submitted")

        return Response(
            status=status.HTTP_400_BAD_REQUEST,
            data="Appraisal is successfully submitted",
        )

    @action(detail=True, methods=["post"], url_path="up-stage/manager/end-review")
    def end_review_manager(self, request, pk=None):
        """
        Mid Review By Manager

        """
        appraisal: Appraisal = self.get_object()
        if appraisal.employee.first_reporting_manager != self.request.user.profile:
            return Response(status=status.HTTP_401_UNAUTHORIZED)
        if appraisal.stage == 2 and (appraisal.status == 8 or appraisal.status == 9):
            appraisal.status = 9
            appraisal.save()
            return Response("Appraisal is successfully submitted")

        return Response(
            status=status.HTTP_400_BAD_REQUEST,
            data="Appraisal is successfully submitted",
        )

    @action(detail=True, methods=["post"], url_path="up-stage/manager/end-approve")
    def end_aprove_manager(self, request, pk=None):
        """
        Approve End Review By Manager

        """
        appraisal: Appraisal = self.get_object()
        if appraisal.employee.first_reporting_manager != self.request.user.profile:
            return Response(status=status.HTTP_401_UNAUTHORIZED)
        if appraisal.stage == 2 and appraisal.status == 9:
            appraisal.status += 1
            appraisal.save()

            # create logs and notifications

            title = f"{appraisal.employee.first_reporting_manager.name} approve end year review of  appraisal {appraisal.name}"
            description = f"Hi {appraisal.employee.name} manager {appraisal.employee.first_reporting_manager.name} approve end year review of  appraisal {appraisal.name} . "
            color = "success"
            Logs.objects.create(
                user=appraisal.employee.first_reporting_manager,
                title=title,
                color=color,
            )
            Notification.objects.create(
                user=appraisal.employee,
                title=title,
                description=description,
                color=color,
            )
            try:
                send_mail(
                    title,
                    description,
                    settings.OFFICIAL_MAIL,
                    [appraisal.employee.user.email],
                )
            except:
                pass
            return Response("Appraisal is successfully submitted")

        return Response(
            status=status.HTTP_400_BAD_REQUEST,
            data="Appraisal is successfully submitted",
        )

    @action(detail=True, methods=["POST"], url_path="up-stage/reject/stage-0")
    def stage_0_reject(self, request, pk=None):
        appraisal: Appraisal = self.get_object()
        if appraisal.employee.first_reporting_manager != self.request.user.profile:
            return Response(status=status.HTTP_401_UNAUTHORIZED)

        appraisal.status = 0
        appraisal.stage0_rejection_comment = request.data.get(
            "stage0_rejection_comment", "No comment"
        )
        appraisal.save()

        # create logs and notifications
        title = f"{appraisal.employee.first_reporting_manager.name} reject appraisal {appraisal.name} in goal settings stage"
        description = f"Hi {appraisal.employee.name} manager {appraisal.employee.first_reporting_manager.name} reject appraisal {appraisal.name} in goal settings stage. Manager goal settings stage rejection comment is {appraisal.stage0_rejection_comment} . Please edit goals , core value and skills and then submit. "
        color = "error"
        Logs.objects.create(
            user=appraisal.employee.first_reporting_manager,
            title=title,
            color=color,
        )
        Notification.objects.create(
            user=appraisal.employee,
            title=title,
            description=description,
            color=color,
        )
        try:
            send_mail(
                title,
                description,
                settings.OFFICIAL_MAIL,
                [appraisal.employee.user.email],
            )
        except:
            pass

        return Response(
            {
                "msg": f"{appraisal.name} is successfully rejected in goal settings stage",
                "comment": appraisal.stage0_rejection_comment,
            }
        )

    @action(detail=True, methods=["POST"], url_path="up-stage/reject/stage-1")
    def stage_1_reject(self, request, pk=None):
        appraisal: Appraisal = self.get_object()
        if appraisal.employee.first_reporting_manager != self.request.user.profile:
            return Response(status=status.HTTP_401_UNAUTHORIZED)

        appraisal.status = 3
        appraisal.stage1_rejection_comment = request.data.get(
            "stage1_rejection_comment", "No comment"
        )
        appraisal.save()
        # create logs and notifications
        title = f"{appraisal.employee.first_reporting_manager.name} reject appraisal {appraisal.name} in mid year review stage."
        description = f"Hi {appraisal.employee.name} manager {appraisal.employee.first_reporting_manager.name} reject appraisal {appraisal.name} in mid year review  stage. Manager mid year review stage rejection comment is {appraisal.stage1_rejection_comment} . Please edit mid year review and then submit again. "
        color = "error"
        Logs.objects.create(
            user=appraisal.employee.first_reporting_manager,
            title=title,
            color=color,
        )
        Notification.objects.create(
            user=appraisal.employee,
            title=title,
            description=description,
            color=color,
        )
        try:
            send_mail(
                title,
                description,
                settings.OFFICIAL_MAIL,
                [appraisal.employee.user.email],
            )
        except:
            pass
        return Response(
            {
                "msg": f"{appraisal.name} is successfully rejected in  mid review stage",
                "comment": appraisal.stage1_rejection_comment,
            }
        )

    @action(detail=True, methods=["POST"], url_path="up-stage/reject/stage-2")
    def stage_2_reject(self, request, pk=None):
        appraisal: Appraisal = self.get_object()
        if appraisal.employee.first_reporting_manager != self.request.user.profile:
            return Response(status=status.HTTP_401_UNAUTHORIZED)

        appraisal.status = 7
        appraisal.stage2_rejection_comment = request.data.get(
            "stage2_rejection_comment", "No comment"
        )
        appraisal.save()

        title = f"{appraisal.employee.first_reporting_manager.name} reject appraisal {appraisal.name} in end year review stage."
        description = f"Hi {appraisal.employee.name} manager {appraisal.employee.first_reporting_manager.name} reject appraisal {appraisal.name} in end year review  stage. Manager end year review stage rejection comment is {appraisal.stage1_rejection_comment} . Please edit end year review and then submit again. "
        color = "error"
        Logs.objects.create(
            user=appraisal.employee.first_reporting_manager,
            title=title,
            color=color,
        )
        Notification.objects.create(
            user=appraisal.employee,
            title=title,
            description=description,
            color=color,
        )
        try:
            send_mail(
                title,
                description,
                settings.OFFICIAL_MAIL,
                [appraisal.employee.user.email],
            )
        except:
            pass
        return Response(
            {
                "msg": f"{appraisal.name} is successfully rejected in  end year review stage ",
                "comment": appraisal.stage2_rejection_comment,
            }
        )


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
