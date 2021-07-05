from __future__ import annotations
from statistics import mode

from typing import TYPE_CHECKING, List

from backend.users.models import Company, Profile
from django.core.validators import MaxValueValidator, MinValueValidator
from django.db import models
from django.utils.datetime_safe import date

from .manger import AppraisalManger

if TYPE_CHECKING:
    from backend.training.models import CoreValue, Goal, Skill
# Create your models here.


class OverAllAppraisal(models.Model):

    STAGES_CHOICES = (
        (0, "STAGE 1 :Goals Setting Stage"),
        (1, "STAGE 2 :Mid-Year Review"),
        (3, "STAGE 3 :Year-End Review"),
        (4, "STAGE 4 :Reports"),
        (5, "STAGE 5 :Calibration"),
        (6, "STAGE 6 :Completed"),
    )
    name: str = models.CharField(max_length=50, blank=False, null=False)
    company: Company = models.ForeignKey(
        Company, on_delete=models.CASCADE, blank=True, null=False
    )
    stage: int = models.IntegerField(choices=STAGES_CHOICES, default=0, blank=True)

    goal_weightage = models.IntegerField(
        validators=[MinValueValidator(0), MaxValueValidator(100)],
        blank=True,
        default=50,
    )
    core_value_weightage = models.IntegerField(
        validators=[MinValueValidator(0), MaxValueValidator(100)],
        blank=True,
        default=25,
    )
    skill_weightage = models.IntegerField(
        validators=[MinValueValidator(0), MaxValueValidator(100)],
        blank=True,
        default=25,
    )

    stage1_start_date = models.DateField(default=date.today)
    stage1_end_date = models.DateField(default=date.today)

    stage2_start_date = models.DateField(default=date.today)
    stage2_end_date = models.DateField(default=date.today)

    stage3_start_date = models.DateField(default=date.today)
    stage3_end_date = models.DateField(default=date.today)

    reports_end_date = models.DateField(default=date.today)
    calibration_end_date = models.DateField(default=date.today)


class Appraisal(models.Model):
    STATUS_CHOICES = (
        # stage 1
        (0, "STAGE 0: Employee Goal settings stage"),
        (1, "STAGE 0: Manager Goal apprave stage"),
        # satge 2
        (2, "STAGE 1: Employee mid year review stage"),
        (3, "STAGE 1: Employee mid year submit stage"),
        (4, "STAGE 1: Manager mid year review stage"),
        (5, "STAGE 1: Manager mid year approve stage"),
        # stage 3
        (5, "STAGE 2: Employee end year review stage"),
        (6, "STAGE 2: Employee end year submit stage"),
        (7, "STAGE 2: Manager end year review stage"),
        (8, "STAGE 2: Manager end year approve stage"),
        (9, "STAGE 2: Manager Approved end year review"),
        (10, "STAGE 2: hod end year approve stage"),
        (11, "STAGE 2: hod approved year approve stage"),
    )

    RATING_CHOICES = [
        (1, "1 - Major Improvement Needed"),
        (2, "2 - Needs Improvement"),
        (3, "3 - Meets Expectations"),
        (4, "4 - Exceeds Expectations"),
        (5, "5 - Far Exceed Expectations"),
    ]
    overall_appraisal: OverAllAppraisal = models.ForeignKey(
        OverAllAppraisal, on_delete=models.CASCADE
    )
    employee: Profile = models.ForeignKey(
        Profile, on_delete=models.CASCADE, blank=True, null=True
    )
    status = models.IntegerField(choices=STATUS_CHOICES, default=0, blank=True)

    stage0_employee_comment: str = models.TextField(blank=True, null=True)
    stage0_manager_comment: str = models.TextField(blank=True, null=True)

    stage1_employee_comment: str = models.TextField(blank=True, null=True)
    stage1_manager_comment: str = models.TextField(blank=True, null=True)

    stage2_employee_comment: str = models.TextField(blank=True, null=True)
    stage2_manager_comment: str = models.TextField(blank=True, null=True)

    stage0_rejection_comment: str = models.TextField(blank=True, null=True)
    stage1_rejection_comment: str = models.TextField(blank=True, null=True)
    stage2_rejection_comment: str = models.TextField(blank=True, null=True)
    core_value_employee_comment : str =models.TextField(blank=True, null=True)
    core_value_employee_rating : str = models.IntegerField(
        blank=True, null=True, choices=RATING_CHOICES
    )
    core_value_manager_rating : str = models.IntegerField(
        blank=True, null=True, choices=RATING_CHOICES
    )
    core_value_hod_rating : str = models.IntegerField(
        blank=True, null=True, choices=RATING_CHOICES
    )
    core_value_manager_comment : str =models.TextField(blank=True, null=True)

    core_value_hod_comment : str =models.TextField(blank=True, null=True)


    hod_comment: str = models.TextField(blank=True, null=True)
    hod_rating: int = models.IntegerField(blank=True, null=True, choices=RATING_CHOICES)

    other_properties = models.JSONField(blank=True, null=True)

    objects = AppraisalManger()

    # appraisal goals properties
    def goals(self) -> List[Goal]:
        return self.goal_set.all()

    def goals_weightage(self) -> int:
        return sum(x.weightage for x in self.goals())

    def goals_count(self) -> int:
        return self.goals().count()

    # appraisal core value properties
    def core_values(self) -> List[CoreValue]:
        return self.corevalue_set.all()

    def core_values_count(self) -> int:
        return self.core_values.count()

    def core_values_weightage(self) -> int:
        return sum(x.weightage for x in self.core_values())

    # appraisal skills properties
    def skills(self) -> List[Skill]:
        return self.skill_set.all()

    def skills_weightage(self) -> int:
        return sum(x.weightage for x in self.skills())

    def skills_count(self) -> int:
        return self.skills().count()

    @property
    def is_100_weightage(self) -> bool:
        return (
            self.goals_weightage()
            == 100
            # and self.core_values_weightage() == 100
            # and self.skills_weightage() == 100
        )

    @property
    def is_all_goal_approved(self) -> bool:
        return all(goal.status == 1 for goal in self.goals())

    @property
    def is_at_least_one_kpi(self) -> bool:
        """
        return true is all goals have at least one kpi
        """
        return not any(goal.kpi_count == 0 for goal in self.goals())

    @property
    def name(self) -> str:
        return self.overall_appraisal.name

    @property
    def stage(self) -> str:
        return self.overall_appraisal.stage

    # status in which employee can up stage the apprisal
    @classmethod
    def employee_stages(cls) -> List[int]:
        return [0, 3, 4, 7, 8]

    # status in which manager can upstage the appraisal
    @classmethod
    def manager_stages(cls) -> List[int]:
        return [1, 5, 9]

    # appraisal status for overall appraisal stage 1
    @classmethod
    def stage_1(cls) -> List[int]:
        return range(0, 3)

    # appraisal status for overall appraisal stage 2
    @classmethod
    def stage_2(cls) -> List[int]:
        return range(3, 7)

    # appraisal status for overall appraisal stage 3
    @classmethod
    def stage_3(cls) -> List[int]:
        return range(7, 13)

    def can_upsatus(self, user: Profile) -> bool:
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
        if (self.employee.id == user.id and self.status in self.employee_stages()) or (
            self.employee.first_reporting_manager.id == user.id
        ):

            if self.status == 0 and self.is_100_weightage and self.is_at_least_one_kpi:
                return True

            if self.status == 1 and self.is_all_goal_approved:
                return True
            pass

        return False
