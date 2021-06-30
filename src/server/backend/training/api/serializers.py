from backend.users.api.serializers import ShortEmployeeSerializer
from rest_framework import serializers

from ..models import *


class GoalCategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = GoalCategory
        fields = "__all__"

    def create(self, validated_data):

        if self.context["request"].user.is_superuser:
            return super().create(validated_data)

        return super().create(
            validated_data | {"company": self.context["request"].user.company}
        )


class CoreValueCategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = CoreValueCategory
        fields = "__all__"

    def create(self, validated_data):

        if self.context["request"].user.is_superuser:
            return super().create(validated_data)

        return super().create(
            validated_data | {"company": self.context["request"].user.company}
        )


class SkillsCategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = SkillsCategory
        fields = "__all__"

    def create(self, validated_data):

        if self.context["request"].user.is_superuser:
            return super().create(validated_data)

        return super().create(
            validated_data | {"company": self.context["request"].user.company}
        )


class GoalSerializer(serializers.ModelSerializer):
    class Meta:
        model = Goal
        fields = "__all__"


class CoreValueSerializer(serializers.ModelSerializer):
    class Meta:
        model = CoreValue
        fields = "__all__"


class SkillSerializer(serializers.ModelSerializer):
    class Meta:
        model = Skill
        fields = "__all__"


class KPISerializer(serializers.ModelSerializer):
    class Meta:
        model = KPI
        fields = "__all__"


class DetailCoreValueSerializer(serializers.ModelSerializer):
    category = CoreValueCategorySerializer()

    class Meta:
        model = CoreValue
        fields = "__all__"


class DetailSkillSerializer(serializers.ModelSerializer):
    category = SkillsCategorySerializer()

    class Meta:
        model = Skill
        fields = "__all__"


class DetailGoalSerializer(serializers.ModelSerializer):
    kpi_set = KPISerializer(many=True)
    category = GoalCategorySerializer()

    class Meta:
        model = Goal
        fields = "__all__"


class DepartmentalGoalSerializer(serializers.ModelSerializer):
    class Meta:
        model = DepartmentalGoal
        fields = "__all__"


class DepartmentalCoreValueSerializer(serializers.ModelSerializer):
    class Meta:
        model = DepartmentalCoreValue
        fields = "__all__"


class DetailDepartmentalGoalSerializer(serializers.ModelSerializer):
    manager = ShortEmployeeSerializer()
    category= GoalCategorySerializer()

    class Meta:
        model = DepartmentalGoal
        fields = "__all__"


class DetailDepartmentalCoreValueSerializer(serializers.ModelSerializer):
    manager = ShortEmployeeSerializer()
    category= CoreValueCategorySerializer()

    class Meta:
        model = DepartmentalCoreValue
        fields = "__all__"
