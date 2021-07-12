from backend.users.models import Permission, Role
from drf_spectacular.types import OpenApiTypes
from drf_spectacular.utils import *
from rest_framework import serializers

from ..models import Company, Department, Logs, Notification, Profile, User


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        read_only_fields = (
            "is_active",
            "is_admin",
            "is_email_verified",
            "date_joined",
            "is_superuser",
        )
        exclude = (
            "user_permissions",
            "groups",
            "dummy_password",
        )

        extra_kwargs = {"password": {"write_only": True}}


class ShortEmployeeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Profile
        fields = (
            "id",
            "name",
            "email",
        )


class ProfileSerializer(serializers.ModelSerializer):
    user = UserSerializer()

    class Meta:
        model = Profile
        fields = "__all__"

    def create(self, validated_data):
        user = dict(validated_data.pop("user"))

        if self.context["request"].user.is_superuser:
            user = User.objects.create_user(**user)
        else:
            user = User.objects.create_user(
                **dict(user | {"company": self.context["request"].user.company})
            )
        return super().create(validated_data | {"user": user})

    def update(self, instance, validated_data):
        user: User = instance.user
        user_data: User = validated_data.pop("user")

        user.email = user_data.get("email", user.email)
        user.first_name = user_data.get("first_name", user.first_name)
        user.last_name = user_data.get("last_name", user.last_name)
        user.username = user_data.get("username", user.email)
        user.contact_number = user_data.get("contact_number", user.contact_number)
        user.role = user_data.get("role", user.role)
        user.save()

        return super().update(instance, validated_data)


class DepartmentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Department
        fields = "__all__"

    def create(self, validated_data):

        if self.context["request"].user.is_superuser:
            return super().create(validated_data)

        return super().create(
            validated_data | {"company": self.context["request"].user.company}
        )


class PermissionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Permission
        fields = "__all__"

    def create(self, validated_data):

        if self.context["request"].user.is_superuser:
            return super().create(validated_data)

        return super().create(
            validated_data | {"company": self.context["request"].user.company}
        )


class RoleSerializer(serializers.ModelSerializer):
    class Meta:
        model = Role
        fields = "__all__"

    def create(self, validated_data):

        if self.context["request"].user.is_superuser:
            return super().create(validated_data)

        return super().create(
            validated_data | {"company": self.context["request"].user.company}
        )


class ShortProfileSerializer(serializers.ModelSerializer):
    department = DepartmentSerializer()
    first_reporting_manager = ShortEmployeeSerializer()
    second_reporting_manager = ShortEmployeeSerializer()

    class Meta:
        model = Profile
        fields = (
            "id",
            "department",
            "date_of_hire",
            "first_reporting_manager",
            "second_reporting_manager",
            "email",
            "name",
            "username",
        )


class RoleInfoSerializer(serializers.ModelSerializer):
    permissions = PermissionSerializer(many=True)

    class Meta:
        model = Role
        fields = "__all__"


class UserInfoSerializer(serializers.ModelSerializer):
    role = RoleSerializer()

    class Meta:
        model = User
        exclude = ("user_permissions", "groups", "password", "dummy_password")


class ProfileInfoSerializer(serializers.ModelSerializer):
    user = UserInfoSerializer()
    department = DepartmentSerializer()
    first_reporting_manager = ShortProfileSerializer()
    second_reporting_manager = ShortProfileSerializer()

    class Meta:
        model = Profile
        fields = "__all__"


class CompanySerializer(serializers.ModelSerializer):
    employees_count = serializers.IntegerField(read_only=True)
    departments_count = serializers.IntegerField(read_only=True)
    appraisal_count = serializers.IntegerField(read_only=True)

    # for default admin user
    admin_username = serializers.CharField(write_only=True, required=False)
    admin_email = serializers.EmailField(write_only=True, required=False)
    admin_name = serializers.CharField(write_only=True, required=False)
    admin_password = serializers.CharField(write_only=True, required=True)
    admin_contact_number = serializers.CharField(write_only=True, required=False)

    class Meta:
        model = Company

        fields = "__all__"

    def create(self, validated_data):

        # extract data
        name = validated_data.get("name").lower()
        username = validated_data.pop("admin_username", f"{name}admin")
        email = validated_data.pop("admin_email", f"admin@{name}.com")
        name = validated_data.pop("admin_name", f"{name} admin")
        password = validated_data.pop("admin_password")
        contact_number = validated_data.pop("admin_contact_number", "")

        # create company
        company = super().create(validated_data)

        # create profile for admin user
        user = User.objects.create_admin_user(
            username=username,
            email=email,
            contact_number=contact_number,
            password=password,
            company=company,
        )
        profile = Profile.objects.create(user=user)
        profile.first_reporting_manager = profile
        profile.second_reporting_manager = profile
        profile.save()

        # create default permissions

        p1, p2, p3, p4, p5 = Permission.objects.bulk_create(
            [
                Permission(name="CAN_SUBMIT_APPRAISAL", company=company),
                Permission(name="CAN_APPROVE_APPRAISAL", company=company),
                Permission(name="CAN_MANAGE_EMPLOYEE", company=company),
                Permission(name="CAN_MANAGE_APPRAISAL", company=company),
                Permission(name="CAN_MANAGE_COMPANY", company=company),
            ]
        )

        employee, manager, hr, hrmanager, admin = Role.objects.bulk_create(
            [
                Role(name="employee", company=company),
                Role(name="manager", company=company),
                Role(name="hr", company=company),
                Role(name="hrmanager", company=company),
                Role(name="admin", company=company),
            ],
        )

        employee.permissions.add(p1)
        manager.permissions.add(p1, p2)
        hr.permissions.add(p1, p2, p3)
        hrmanager.permissions.add(p1, p2, p3, p4)
        admin.permissions.add(p5)

        user.role = admin
        user.save()

        department = Department.objects.create(
            name="admin", company=company, manager=profile
        )
        profile.department = department
        profile.save()

        # create department

        return company


class SetPasswordSerializer(serializers.Serializer):
    password1 = serializers.CharField()
    password2 = serializers.CharField()

    def validate(self, data):
        if data["password1"] == data["password2"]:
            return data
        raise serializers.ValidationError("password must be same")


class ChangePasswordSerializer(serializers.Serializer):
    password = serializers.CharField()
    password1 = serializers.CharField()
    password2 = serializers.CharField()

    def validate(self, data):
        if data["password1"] == data["password2"]:
            return data
        raise serializers.ValidationError("password must be same")


class ResetPasswordSerializer(serializers.Serializer):
    token = serializers.CharField()
    password1 = serializers.CharField()
    password2 = serializers.CharField()

    def validate(self, data):
        if data["password1"] == data["password2"]:
            return data
        raise serializers.ValidationError("password must be same")


class ResetPasswordTokenSerializer(serializers.Serializer):
    username = serializers.CharField()


class EmptySerializer(serializers.Serializer):
    pass


class CheckUsernameSerializer(serializers.Serializer):
    username = serializers.CharField()


class CheckEmailSerializer(serializers.Serializer):
    email = serializers.CharField()


class CheckPasswordSerializer(serializers.Serializer):
    password = serializers.CharField()


class CheckContactNumberSerializer(serializers.Serializer):
    contact_number = serializers.CharField()


class LogsSerializer(serializers.ModelSerializer):
    user = ShortEmployeeSerializer()

    class Meta:
        model = Logs
        fields = "__all__"


class NotificationSerializer(serializers.ModelSerializer):
    user = ShortEmployeeSerializer()

    class Meta:
        model = Notification
        fields = "__all__"
