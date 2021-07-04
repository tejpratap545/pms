from statistics import mode
from typing import TYPE_CHECKING, List

from backend.appraisals.models import Appraisal, OverAllAppraisal
from backend.users.models import Company, Profile
from django.core.validators import MaxValueValidator, MinValueValidator
from django.db import models
from django.utils.datetime_safe import date

if TYPE_CHECKING:
    from backend.training.models import Goal


class GoalCategory(models.Model):
    name: str = models.CharField(max_length=70, blank=True, null=False)
    company: Company = models.ForeignKey(
        Company, on_delete=models.CASCADE, blank=True, null=False
    )

    def __str__(self):
        return self.name


class CoreValueCategory(models.Model):
    name: str = models.CharField(max_length=70, blank=True, null=False)
    company: Company = models.ForeignKey(
        Company, on_delete=models.CASCADE, blank=True, null=False
    )

    def __str__(self):
        return self.name


class SkillsCategory(models.Model):
    name: str = models.CharField(max_length=70, blank=True, null=False)
    company: Company = models.ForeignKey(
        Company, on_delete=models.CASCADE, blank=True, null=False
    )

    def __str__(self):
        return self.name


class KPI(models.Model):
    PROGRESS_CHOICES = (("Working", "Working"), ("Completed", "Completed"))
    goal = models.ForeignKey("Goal", on_delete=models.CASCADE)
    summary: str = models.TextField(blank=True, null=True)
    due: date = models.DateField(blank=True, null=True)
    date_created: date = models.DateField(null=True, default=date.today)
    progress = models.CharField(
        max_length=20,
        blank=True,
        null=False,
        choices=PROGRESS_CHOICES,
        default="Working",
    )

    def __str__(self):
        return self.summary


class Goal(models.Model):
    appraisal: Appraisal = models.ForeignKey(Appraisal, on_delete=models.CASCADE)
    category: GoalCategory = models.ForeignKey(
        GoalCategory, on_delete=models.SET_NULL, blank=True, null=True
    )
    summary: str = models.TextField(blank=True, null=True)
    description: str = models.TextField(blank=True, null=True)
    due: date = models.DateField()

    weightage: int = models.IntegerField(
        validators=[MinValueValidator(1), MaxValueValidator(100)],
        blank=True,
        null=False,
    )

    STATUS_CHOICE = (
        (-1, "REJECTED"),
        (0, "PENDINGD"),
        (1, "APPROVED"),
    )
    status: int = models.IntegerField(blank=True, choices=STATUS_CHOICE, default=0)

    stage1_employee_comment: str = models.TextField(blank=True, null=True)
    stage1_manager_comment: str = models.TextField(blank=True, null=True)

    stage2_employee_comment: str = models.TextField(blank=True, null=True)

    TRACKING_CHOICES = [
        ("null", "null"),
        ("On Track", "On Track"),
        ("Not On Track", "Not On Track"),
    ]

    tracking_status: str = models.CharField(
        max_length=50, blank=True, null=True, default="null", choices=TRACKING_CHOICES
    )

    stage2_manager_comment: str = models.TextField(blank=True, null=True)
    RATING_CHOICES = [
        (1, "1 - Major Improvement Needed"),
        (2, "2 - Needs Improvement"),
        (3, "3 - Meets Expectations"),
        (4, "4 - Exceeds Expectations"),
        (5, "5 - Far Exceed Expectations"),
    ]
    employee_rating: int = models.IntegerField(
        blank=True, null=True, choices=RATING_CHOICES
    )
    manager_rating: int = models.IntegerField(
        blank=True, null=True, choices=RATING_CHOICES
    )

    stage3_employee_comment: str = models.TextField(blank=True, null=True)
    stage3_manager_comment: str = models.TextField(blank=True, null=True)

    def kpi(self) -> List[KPI]:
        return self.kpi_set.all()

    def kpi_count(self):
        return self.kpi().count()


class CoreValue(models.Model):
    appraisal: Appraisal = models.ForeignKey(Appraisal, on_delete=models.CASCADE)
    category: CoreValueCategory = models.ForeignKey(
        CoreValueCategory, on_delete=models.SET_NULL, blank=True, null=True
    )
    summary: str = models.TextField(blank=True, null=True)
    description: str = models.TextField(blank=True, null=True)
    due: date = models.DateField()

    weightage: int = models.IntegerField(
        validators=[MinValueValidator(1), MaxValueValidator(100)],
        blank=True,
        null=False,
    )


class Skill(models.Model):
    appraisal: Appraisal = models.ForeignKey(Appraisal, on_delete=models.CASCADE)
    category: SkillsCategory = models.ForeignKey(
        SkillsCategory, on_delete=models.SET_NULL, blank=True, null=True
    )
    summary: str = models.TextField(blank=True, null=True)
    description: str = models.TextField(blank=True, null=True)
    due: date = models.DateField()

    weightage: int = models.IntegerField(
        validators=[MinValueValidator(1), MaxValueValidator(100)],
        blank=True,
        null=False,
    )


class DepartmentalGoal(models.Model):
    summary = models.CharField(max_length=150)
    appraisal = models.ForeignKey(OverAllAppraisal, on_delete=models.CASCADE)
    due = models.DateField(null=True, blank=True)
    description = models.CharField(max_length=150, null=True, blank=True)
    category = models.ForeignKey(
        GoalCategory, on_delete=models.SET_NULL, null=True, blank=True
    )
    manager = models.ForeignKey(
        Profile, on_delete=models.CASCADE, null=True, blank=True
    )


class DepartmentalCoreValue(models.Model):
    summary = models.CharField(max_length=150)
    appraisal = models.ForeignKey(OverAllAppraisal, on_delete=models.CASCADE)
    due = models.DateField(null=True, blank=True)
    description = models.CharField(max_length=150, null=True, blank=True)
    category = models.ForeignKey(
        CoreValueCategory, on_delete=models.SET_NULL, blank=True, null=True
    )
    manager = models.ForeignKey(
        Profile, on_delete=models.CASCADE, null=True, blank=True
    )
