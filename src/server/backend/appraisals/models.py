from backend.users.models import Company, Profile
from django.core.validators import MaxValueValidator, MinValueValidator
from django.db import models
from django.utils.datetime_safe import date

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
    name = models.CharField(max_length=50, blank=False, null=False)
    company = models.ForeignKey(
        Company, on_delete=models.CASCADE, blank=True, null=False
    )
    stage = models.IntegerField(choices=STAGES_CHOICES, default=0, blank=True)

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
        (0, "STAGE 1: Employee Goal settings stage"),
        (1, "STAGE 1: Employee goal submit stage"),
        (2, "STAGE 1: Manager Goal apprave stage"),
        (3, "STAGE 1: Manager Approved the goal"),
        # satge 2
        (4, "STAGE 2: Employee mid year review stage"),
        (5, "STAGE 2: Employee mid year submit stage"),
        (6, "STAGE 2: Manager mid year approve stage"),
        (7, "STAGE 2: Manager Approved mid year review"),
        # stage 3
        (8, "STAGE 3: Employee end year review stage"),
        (9, "STAGE 3: Employee end year submit stage"),
        (10, "STAGE 3: Manager end year approve stage"),
        (11, "STAGE 3: Manager Approved end year review"),
        (12, "STAGE 3: hod end year approve stage"),
        (13, "STAGE 3: hod approved year approve stage"),
    )
    overall_appraisal = models.ForeignKey(OverAllAppraisal, on_delete=models.CASCADE)
    employee: Profile = models.ForeignKey(
        Profile, on_delete=models.CASCADE, blank=True, null=True
    )
    status = models.IntegerField(choices=STATUS_CHOICES, default=0, blank=True)

    stage1_employee_comment = models.TextField(blank=True, null=True)
    stage1_manager_comment = models.TextField(blank=True, null=True)

    stage2_employee_comment = models.TextField(blank=True, null=True)
    stage2_manager_comment = models.TextField(blank=True, null=True)

    stage3_employee_comment = models.TextField(blank=True, null=True)
    stage3_manager_comment = models.TextField(blank=True, null=True)

    stage1_rejection_comment = models.TextField(blank=True, null=True)
    stage2_rejection_comment = models.TextField(blank=True, null=True)
    stage3_rejection_comment = models.TextField(blank=True, null=True)

    other_properties = models.JSONField(blank=True, null=True)

    # def is_all_goal_approaved(self):
    #     if self.goals_set.all()
