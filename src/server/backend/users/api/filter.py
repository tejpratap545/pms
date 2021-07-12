from django_filters import rest_framework as filters


from backend.users.models import Logs


class LogsFilter(filters.FilterSet):
    start_date = filters.DateFilter(field_name="created_at", lookup_expr="gte")
    end_date = filters.DateFilter(field_name="created_at", lookup_expr="lte")

    class Meta:
        model = Logs
        fields =  ('start_date','end_date',)
