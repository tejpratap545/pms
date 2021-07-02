from django.db import models
from django.db.models import Count


class AppraisalQuerySet(models.QuerySet):
    def detail(self):
        """

        queryset return all details about goal , core value , skills , overallapprial
        including departmental goal and departmental core value
        including short profile details about the employee
        """
        return self.prefetch_related(
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

    def short1(self):
        """
        querset return appraisal name , stage and status
        """
        return self.select_related("overall_appraisal",).only(
            "overall_appraisal__name",
            "overall_appraisal__stage",
            "status",
        )

    def short2(self):
        """
        return detail about appraisal name , stage and status and
        with employee details including  employee  first_reporting_manager, second_reporting_manager and department
        """
        return self.select_related(
            "overall_appraisal",
            "employee",
            "employee__department",
            "employee__first_reporting_manager",
            "employee__second_reporting_manager",
        ).only(
            "overall_appraisal__name",
            "overall_appraisal__stage",
            "status",
            "employee",
        )

    def count_goals(self):
        return self.annotate(
            goal_count=Count("goal", distinct=True),
            corevalue_count=Count("corevalue", distinct=True),
            skill_count=Count("skill", distinct=True),
        )

    def exclude_complete_appraisals(self):
        return self.exclude(overall_appraisal__stage=6)


class AppraisalManger(models.Manager):
    def get_queryset(self):
        return AppraisalQuerySet(self.model, using=self._db)

    def detail(self):
        """
        return all details about goal , core value , skills , overallapprial
        including departmental goal and departmental core value
        """
        return self.get_queryset().detail().count_goals().exclude_complete_appraisals()

    def short1(self):
        """

        return  appraisal name , stage and status
        """
        return self.get_queryset().short1().count_goals().exclude_complete_appraisals()

    def short2(self):

        """
        return short detail about appraisal name , stage and status and
        with employee details including  employee  first_reporting_manager, second_reporting_manager and department
        """
        return self.get_queryset().short2().count_goals().exclude_complete_appraisals()
