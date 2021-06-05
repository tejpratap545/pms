from backend.users.permissions import *
from django.db.models import Count
from rest_framework.viewsets import ModelViewSet

from ..models import *
from .serializers import *


class OverAllAppraisalViewSet(ModelViewSet):
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
