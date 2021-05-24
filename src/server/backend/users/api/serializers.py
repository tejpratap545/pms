from rest_framework import serializers

from ..models import Department, Profile, User


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = [
            "username",
            "is_active",
            "is_admin",
            "is_email_verified",
            "date_joined",
            "company"
        ]


class DepartmentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Department
        fields = "__all__"


class ShortEmployeeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Profile
        fields = (
            "id",
            "name",
            "email",
        )


class ShortProfileSerializer(serializers.ModelSerializer):
    department = DepartmentSerializer()

    class Meta:
        model = Profile
        fields = (
            "id",
            "department",
            "date_of_hire",
            "first_reporting_manager",
            "second_reporting_manager",
        )


class ProfileInfoSerializer(serializers.ModelSerializer):
    user = UserSerializer()
    department = DepartmentSerializer()
    first_reporting_manager = ShortProfileSerializer()
    second_reporting_manager = ShortProfileSerializer()

    class Meta:
        model = Profile
        fields = "__all__"
