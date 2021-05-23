from django.contrib.auth.models import BaseUserManager


class UserManager(BaseUserManager):
    def create_user(self, email, username, password=None, *args, **kwargs):
        """Create the user by the email , contact number and password  and save into the database"""
        if not email:
            raise ValueError("Users must have an email address")
        if not username:
            raise ValueError("Users must have a username")

        user = self.model(
            email=self.normalize_email(email), username=username, *args, **kwargs
        )
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superadmin(self, email, username, password=None, *args, **kwargs):
        user = self.create_user(email, username, password, *args, **kwargs)
        user.is_admin = True
        user.is_superuser = True
        user.save(using=self._db)
        return user

    def create_admin_user(self, email, username, password=None, *args, **kwargs):
        user = self.create_user(email, username, password, *args, **kwargs)
        user.is_admin = True
        user.is_superuser = False
        user.save(using=self._db)
        return user
