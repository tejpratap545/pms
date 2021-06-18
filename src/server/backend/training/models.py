from backend.appraisals.models import Appraisal
from backend.users.models import Company, Profile
from django.core.validators import MaxValueValidator, MinValueValidator
from django.db import models
from django.utils.datetime_safe import date


class GoalCategory(models.Model):
    name = models.CharField(max_length=70, blank=True, null=False)
    company = models.ForeignKey(
        Company, on_delete=models.CASCADE, blank=True, null=False
    )

    def __str__(self):
        return self.name


class CoreValueCategory(models.Model):
    name = models.CharField(max_length=70, blank=True, null=False)
    company = models.ForeignKey(
        Company, on_delete=models.CASCADE, blank=True, null=False
    )

    def __str__(self):
        return self.name


class SkillsCategory(models.Model):
    name = models.CharField(max_length=70, blank=True, null=False)
    company = models.ForeignKey(
        Company, on_delete=models.CASCADE, blank=True, null=False
    )

    def __str__(self):
        return self.name


class Goal(models.Model):
    appraisal = models.ForeignKey(Appraisal, on_delete=models.CASCADE)
    category = models.ForeignKey(
        GoalCategory, on_delete=models.SET_NULL, blank=True, null=True
    )
    summary = models.TextField(blank=True, null=True)
    description = models.TextField(blank=True, null=True)
    due = models.DateField()

    weightage = models.IntegerField(
        validators=[MinValueValidator(1), MaxValueValidator(100)],
        blank=True,
        null=False,
    )

    STATUS_CHOICE = (
        (-1, "REJECTED"),
        (0, "PENDINGD"),
        (1, "APPROVED"),
    )
    status = models.CharField(
        max_length=100, blank=True, null=True, choices=STATUS_CHOICE
    )

    stage1_employee_comment = models.TextField(blank=True, null=True)
    stage1_manager_comment = models.TextField(blank=True, null=True)

    stage2_employee_comment = models.TextField(blank=True, null=True)

    TRACKING_CHOICES = [
        ("null", "null"),
        ("On Track", "On Track"),
        ("Not On Track", "Not On Track"),
    ]

    tracking_status = models.CharField(
        max_length=50, blank=True, null=True, default="null", choices=TRACKING_CHOICES
    )

    stage2_manager_comment = models.TextField(blank=True, null=True)

    stage3_employee_comment = models.TextField(blank=True, null=True)
    stage3_manager_comment = models.TextField(blank=True, null=True)


class KPI(models.Model):
    PROGRESS_CHOICES = (("Working", "Working"), ("Completed", "Completed"))
    goal = models.ForeignKey(Goal, on_delete=models.CASCADE)
    summary = models.TextField(blank=True, null=True)
    due = models.DateField(blank=True, null=True)
    date_created = models.DateField(null=True, default=date.today)
    progress = models.CharField(
        max_length=20,
        blank=True,
        null=False,
        choices=PROGRESS_CHOICES,
        default="Working",
    )

    def __str__(self):
        return self.summary


class CoreValue(models.Model):
    appraisal = models.ForeignKey(Appraisal, on_delete=models.CASCADE)
    category = models.ForeignKey(
        CoreValueCategory, on_delete=models.SET_NULL, blank=True, null=True
    )
    summary = models.TextField(blank=True, null=True)
    description = models.TextField(blank=True, null=True)
    due = models.DateField()

    weightage = models.IntegerField(
        validators=[MinValueValidator(1), MaxValueValidator(100)],
        blank=True,
        null=False,
    )


class Skill(models.Model):
    appraisal = models.ForeignKey(Appraisal, on_delete=models.CASCADE)
    category = models.ForeignKey(
        SkillsCategory, on_delete=models.SET_NULL, blank=True, null=True
    )
    summary = models.TextField(blank=True, null=True)
    description = models.TextField(blank=True, null=True)
    due = models.DateField()

    weightage = models.IntegerField(
        validators=[MinValueValidator(1), MaxValueValidator(100)],
        blank=True,
        null=False,
    )


class DepartmentalGoal(models.Model):
    summary = models.CharField(max_length=150)
    appraisal = models.ForeignKey(Appraisal, on_delete=models.CASCADE)
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
    appraisal = models.ForeignKey(Appraisal, on_delete=models.CASCADE)
    due = models.DateField(null=True, blank=True)
    description = models.CharField(max_length=150, null=True, blank=True)
    category = models.ForeignKey(
        CoreValueCategory, on_delete=models.SET_NULL, blank=True, null=True
    )
    manager = models.ForeignKey(
        Profile, on_delete=models.CASCADE, null=True, blank=True
    )
