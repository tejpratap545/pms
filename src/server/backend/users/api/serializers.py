from backend.users.models import Permission, Role
from rest_framework import serializers

from ..models import Company, Department, Profile, User


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = [
            "id",
            "first_name",
            "last_name",
            "email",
            "username",
            "is_active",
            "is_admin",
            "is_email_verified",
            "date_joined",
            "company",
        ]


class DepartmentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Department
        fields = "__all__"

    def create(self, validated_data):

        if self.context["request"].user.is_superadmin:
            return super().create(validated_data)

        return super().create(
            validated_data | {"company": self.context["request"].user.company}
        )


class PermissionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Permission
        fields = "__all__"

    def create(self, validated_data):

        if self.context["request"].user.is_superadmin:
            return super().create(validated_data)

        return super().create(
            validated_data | {"company": self.context["request"].user.company}
        )


class RoleSerializer(serializers.ModelSerializer):
    class Meta:
        model = Role
        fields = "__all__"

    def create(self, validated_data):

        if self.context["request"].user.is_superadmin:
            return super().create(validated_data)

        return super().create(
            validated_data | {"company": self.context["request"].user.company}
        )


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
        user = User.objects.create_superadmin(
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
