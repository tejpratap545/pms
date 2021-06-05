from typing import Optional

from django.contrib.auth.models import AbstractBaseUser, PermissionsMixin
from django.db import models, transaction
from django.utils import timezone

from .backend import check_password_strength
from .manager import UserManager

# Create your models here.


class PasswordTooWeakError(Exception):
    pass


class Company(models.Model):
    name = models.CharField(max_length=20, unique=True)
    logo = models.ImageField(upload_to="company/logo", blank=True, null=True)
    login_logo = models.ImageField(
        upload_to="company/login_logo", blank=True, null=True
    )
    domain = models.CharField(max_length=50, unique=True, blank=False, null=False)
    setting = models.JSONField(blank=True, null=True)
    is_active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"company : {self.name}"


class Permission(models.Model):
    name = models.CharField(max_length=100)
    company = models.ForeignKey(
        Company, on_delete=models.CASCADE, blank=True, null=True
    )

    def __str__(self):
        return f"permission : {self.name}"


class Role(models.Model):
    name = models.CharField(max_length=20)
    permissions = models.ManyToManyField(Permission)
    company = models.ForeignKey(
        Company, on_delete=models.CASCADE, blank=True, null=True
    )

    def __str__(self):
        return f"role : {self.name}"


class User(AbstractBaseUser, PermissionsMixin):

    first_name = models.CharField(max_length=50, blank=True, null=True)
    username = models.CharField(max_length=50, unique=True, null=False)
    last_name = models.CharField(max_length=50, blank=True, null=True)
    email = models.EmailField(blank=True, null=False, unique=True)
    contact_number = models.CharField(max_length=20, blank=True, null=True)

    is_active = models.BooleanField(default=True)
    is_admin = models.BooleanField(default=False)
    is_superuser = models.BooleanField(default=False)
    is_email_verified = models.BooleanField(default=False, null=True)
    date_joined = models.DateTimeField(auto_now_add=True)
    dummy_password = models.CharField(max_length=10, blank=True, null=True)
    company = models.ForeignKey(
        Company, on_delete=models.CASCADE, blank=True, null=True
    )
    role = models.ForeignKey(Role, on_delete=models.SET_NULL, blank=True, null=True)

    USERNAME_FIELD = "username"
    objects = UserManager()

    @property
    def is_staff(self):
        return self.is_admin

    def __str__(self):
        return f"user : {self.username}"

    def set_password(self, password: Optional[str]) -> None:
        """
        set the password of user
        if password is none then set it to unusable otherwise first check the password strength and the set
        """
        if password is None:
            self.set_unusable_password()
            return

        if not check_password_strength(password):
            raise PasswordTooWeakError

        super().set_password(password)


class Department(models.Model):
    name = models.CharField(max_length=100)
    company = models.ForeignKey(Company, on_delete=models.CASCADE, blank=True)
    logo = models.ImageField(upload_to="department/logo", blank=True, null=True)
    manager = models.ForeignKey(
        "Profile",
        on_delete=models.SET_NULL,
        blank=True,
        null=True,
        related_name="departments",
    )

    def __str__(self):
        return f"department : {self.name}"


class Profile(models.Model):

    EMPLOYMENT_TYPE_CHOICE = (
        ("Contractor", "CONTRACTOR"),
        ("Full-Time", "FULL-TIME"),
        ("Part-Time", "PART-TIME"),
        ("Internship", "INTERN"),
    )

    GENDER_CHOICE = (
        ("Male", "MALE"),
        ("Female", "FEMALE"),
    )

    MARITAL_STATUS_CHOICE = (
        ("Single", "SINGLE"),
        ("Married", "MARRIED"),
        ("Divorced", "DIVORCED"),
        ("Separated", "SEPARATED"),
        ("Widowed", "WIDOWED"),
    )

    # persional information
    user:User = models.OneToOneField(User, on_delete=models.CASCADE)
    avatar = models.ImageField(upload_to="avatar", blank=True, null=True)

    gender = models.CharField(
        max_length=6, choices=GENDER_CHOICE, blank=True, null=True
    )
    martial_status = models.CharField(
        max_length=50,
        choices=MARITAL_STATUS_CHOICE,
        default="Single",
        blank=True,
        null=True,
    )

    # employee information

    date_of_hire = models.DateField(auto_now_add=True)
    employee_id = models.CharField(max_length=50, blank=True, null=True)
    department = models.ForeignKey(
        Department, on_delete=models.SET_NULL, blank=True, null=True
    )
    employment_type = models.CharField(
        max_length=50,
        choices=EMPLOYMENT_TYPE_CHOICE,
        default="Full-Time",
        blank=True,
        null=True,
    )
    job_title = models.CharField(max_length=100, blank=True, null=True)

    first_reporting_manager = models.ForeignKey(
        "Profile",
        on_delete=models.SET_NULL,
        blank=True,
        null=True,
        related_name="first_reporting_employees",
    )
    second_reporting_manager = models.ForeignKey(
        "Profile",
        on_delete=models.SET_NULL,
        blank=True,
        null=True,
        related_name="second_reporting_employees",
    )

    resign_date = models.DateField(null=True)

    # other informayion

    address_1 = models.CharField(max_length=250, blank=True, null=True)
    address_2 = models.CharField(max_length=250, blank=True, null=True)

    skill1 = models.CharField(max_length=50, blank=True, null=True)
    skill2 = models.CharField(max_length=50, blank=True, null=True)
    skill3 = models.CharField(max_length=50, blank=True, null=True)


    @property
    def name(self):
        return f"{self.user.first_name} {self.user.last_name}"  


class AccessToken(models.Model):
    token = models.CharField(max_length=128, blank=True, unique=True)
    user = models.ForeignKey(User, on_delete=models.CASCADE, null=True)
    expires = models.DateTimeField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def is_valid(self):
        return not self.is_expired()

    def is_expired(self):
        if not self.expires:
            return True

        return timezone.now() >= self.expires

    def revoke(self):
        self.delete()

    class Meta:
        db_table = '"auth_access_token"'


class RefreshToken(models.Model):
    user = models.ForeignKey(
        User, on_delete=models.CASCADE, related_name="user_refresh_token", null=True
    )
    token = models.CharField(max_length=255)

    access_token = models.OneToOneField(
        AccessToken,
        on_delete=models.CASCADE,
        related_name="refresh_token",
    )

    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)
    revoked = models.DateTimeField(null=True)

    def revoke(self):

        with transaction.atomic():
            try:
                AccessToken.objects.get(id=self.access_token_id).revoke()
            except AccessToken.DoesNotExist:
                pass
            self.access_token = None
            self.revoked = timezone.now()
            self.save()

    def __str__(self):
        return self.token

    class Meta:
        db_table = '"auth_refresh_token"'
        unique_together = (
            "token",
            "revoked",
        )


class ResetPasswordToken(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    token = models.CharField(max_length=10)
    created_at = models.DateTimeField(auto_now_add=True)


class Logs(models.Model):
    COLOR_CHOCE = (
        ("info", "INFO"),
        ("success", "SUCCESSS"),
        ("errro", "ERROR"),
    )
    user = models.ForeignKey(Profile, on_delete=models.CASCADE, blank=True)
    title = models.CharField(max_length=250)
    description = models.TextField()
    color = models.CharField(max_length=100, choices=COLOR_CHOCE)
