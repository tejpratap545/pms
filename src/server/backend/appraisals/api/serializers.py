from backend.users.models import Logs, Profile
from django.core.mail import send_mail
from django.db import transaction
from rest_framework import serializers

from ..models import *

STAGE1_EMAIL = """"Dear employees {employee_name}, \n \n
The Year {{appraisal_name}}  E-PMP (Performance Management Program) has started. \n  Stage 1: Goal setting is now launched from {{goal_start_date}} to {{goal_end_date}}. \n  Kindly speak to your supervisor on your goals and Key Performance Indicators (KPI) and enter that in the Denselight E-PMP system by the due date as stated above. \n \n \n
Thank you.
"""
STAGE2_EMAIL = """Dear employees {employee_name}, \n \n
The {{appraisal_name}} Year’s Mid Year review for the E-PMP (Performance Management Program) has started. \n   Stage 2 is now launched from {{mid_start_date}} to {{mid_end_date}}.  \n  Kindly in-put your status of each of your goals by reviewing the Key Performance Indicators (KPI) and enter the updates into the Denselight E-PMP system by the due date as stated above. \n \n \n
Thank you.
"""

STAGE3_EMAIL = """Dear employees {employee_name}, \n \n
The {{appraisal_name}} Year’s Final Year review for the E-PMP (Performance Management Program) has started. \n  Stage 3 is now launched from {{end_start_date}} to {{end_end_date}}.  \n  Kindly in-put your status of each of your goals by reviewing the Key Performance Indicators (KPI) and enter the updates into the Denselight E-PMP system by the due date as stated above.  After you have updated your performance for each goal, you need to self-rate on your overall performance. \n  Do note after this, your supervisor will also give his rating of his performance. \n  The final rating will be decided at the moderated committee meeting and your final rating will be updated in your e-PMP after the discussion.  \n \n \n
Thank you
"""
from django.conf import settings


class OverAllAppraisalSerializer(serializers.ModelSerializer):
    employee_count = serializers.IntegerField(read_only=True)
    individual_employees = serializers.ListField(write_only=True, required=False)
    departments = serializers.ListField(write_only=True, required=False)
    is_company = serializers.BooleanField(write_only=True, default=False)

    class Meta:
        model = OverAllAppraisal
        fields = "__all__"

    def create(self, validated_data):
        with transaction.atomic():
            is_company = validated_data.pop("is_company", False)
            individual_employees = validated_data.pop("individual_employees", [])
            departments = validated_data.pop("departments", [])
            overall_appraisal = OverAllAppraisal.objects.create(
                company=self.context["request"].user.company,
                stage=0,
                **validated_data,
            )
            appraisal_bulk_data = []
            logs_bulk_data = []

            if is_company:

                # filter employee of current admin company
                for profile in Profile.objects.select_related("user").filter(
                    user__company=self.context["request"].user.company
                ):
                    appraisal_bulk_data.append(
                        Appraisal(employee=profile, overall_appraisal=overall_appraisal)
                    )

                    title = f"{overall_appraisal.name} appraisal created"
                    description = (
                        f"Hi {profile.name}  {self.context['request'].user.profile.name} created "
                        f"{overall_appraisal.name} "
                        f"Please go to dashboard and then add goals , kpis , core values and skills and then "
                        f"submitted to manager "
                    )
                    logs_bulk_data.append(
                        Logs(
                            user=profile,
                            title=title,
                            description=description,
                            color="info",
                        )
                    )
                    try:
                        send_mail(
                            title,
                            STAGE1_EMAIL.format(
                                employee_name=profile.name,
                                appraisal_name=overall_appraisal.name,
                                goal_start_date=overall_appraisal.start_date,
                                goal_end_date=overall_appraisal.goals_setting_end_date,
                            ),
                            settings.OFFICIAL_MAIL,
                            [profile.email],
                        )
                    except:
                        pass

            elif len(departments) > 0:
                for profile in Profile.objects.prefech_related("user").filter(
                    department__in=departments,
                    user__company=self.context["request"].user.company,
                ):
                    appraisal_bulk_data.append(
                        Appraisal(employee=profile, overall_appraisal=overall_appraisal)
                    )
                    title = f"{overall_appraisal.name} appraisal created"
                    description = (
                        f"Hi {profile.name}  {self.context['request'].user.profile.name} created "
                        f"{overall_appraisal.name} "
                        f"Please go to dashboard and then add goals , kpis , core values and skills and then "
                        f"submitted to manager "
                    )
                    logs_bulk_data.append(
                        Logs(
                            user=profile,
                            title=title,
                            description=description,
                            color="info",
                        )
                    )
                    try:
                        send_mail(
                            title,
                            STAGE1_EMAIL.format(
                                employee_name=profile.name,
                                appraisal_name=overall_appraisal.name,
                                goal_start_date=overall_appraisal.start_date,
                                goal_end_date=overall_appraisal.goals_setting_end_date,
                            ),
                            settings.OFFICIAL_MAIL,
                            [profile.email],
                        )
                    except:
                        pass

            elif len(individual_employees) > 0:

                for profile in Profile.objects.prefech_related("user").filter(
                    id__in=individual_employees,
                    user__company=self.context["request"].user.company,
                ):
                    appraisal_bulk_data.append(
                        Appraisal(employee=profile, overall_appraisal=overall_appraisal)
                    )
                    title = f"{overall_appraisal.name} appraisal created"
                    description = (
                        f"Hi {profile.name}  {self.context['request'].user.profile.name} created "
                        f"{overall_appraisal.name} "
                        f"Please go to dashboard and then add goals , kpis , core values and skills and then "
                        f"submitted to manager "
                    )
                    logs_bulk_data.append(
                        Logs(
                            user=profile,
                            title=title,
                            description=description,
                            color="info",
                        )
                    )
                    try:
                        send_mail(
                            title,
                            STAGE1_EMAIL.format(
                                employee_name=profile.name,
                                appraisal_name=overall_appraisal.name,
                                goal_start_date=overall_appraisal.start_date,
                                goal_end_date=overall_appraisal.goals_setting_end_date,
                            ),
                            settings.OFFICIAL_MAIL,
                            [profile.email],
                        )
                    except:
                        pass

            else:
                return serializers.ValidationError("Something went wrong")

            Appraisal.objects.bulk_create(appraisal_bulk_data)
            Logs.objects.bulk_create(logs_bulk_data)

        return overall_appraisal


class ShortOverallAppraisalSerSerializer(serializers.ModelSerializer):
    class Meta:
        model = OverAllAppraisal
        fields = (
            "id",
            "name",
            "stage",
            "calibration_end_date",
        )


class AppraisalSerializer(serializers.ModelSerializer):
    class Meta:
        model = Appraisal
        fields = "__all__"
