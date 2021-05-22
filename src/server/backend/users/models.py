from typing import Optional

from django.contrib.auth.models import AbstractBaseUser, PermissionsMixin
from django.db import models

# Create your models here.


class User(AbstractBaseUser, PermissionsMixin):

    ROLE_TYPE = (
        ("HRManager", "HRManager"),
        ("Hr", "Hr"),
        ("Manager", "Manager"),
        ("Employee", "Employee"),
        ("Admin", "Admin"),
    )

    first_name = models.CharField(max_length=50, blank=True, null=True)
    username = models.CharField(max_length=50, unique=True, null=False)
    last_name = models.CharField(max_length=50, blank=True, null=True)
    email = models.EmailField(
        blank=True,
        null=False,
    )

    is_active = models.BooleanField(default=True)
    is_admin = models.BooleanField(default=False)
    is_superuser = models.BooleanField(default=False)
    is_email_verified = models.BooleanField(default=False, null=True)
    date_joined = models.DateTimeField(auto_now_add=True)
    dummy_password = models.CharField(max_length=10, blank=True, null=True)
    role = models.CharField(
        max_length=20, blank=True, null=True, choices=ROLE_TYPE, default="Employee"
    )

    USERNAME_FIELD = "username"

    @property
    def is_staff(self):
        return self.is_admin

    def __str__(self):
        return self.email

    def set_password(self, password: Optional[str]) -> None:
        """
        set the password of user
        if password is none then set it to unusable otherwise first check the password strength and the set
        """
        if password is None:
            self.set_unusable_password()
            return

        super().set_password(password)
