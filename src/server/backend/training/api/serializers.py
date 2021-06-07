from rest_framework import serializers

from ..models import *


class GoalCategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = GoalCategory
        fields = "__all__"

    def create(self, validated_data):

        if self.context["request"].user.is_superadmin:
            return super().create(validated_data)

        return super().create(
            validated_data | {"company": self.context["request"].user.company}
        )


class CoreValueCategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = CoreValueCategory
        fields = "__all__"

    def create(self, validated_data):

        if self.context["request"].user.is_superadmin:
            return super().create(validated_data)

        return super().create(
            validated_data | {"company": self.context["request"].user.company}
        )


class SkillsCategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = SkillsCategory
        fields = "__all__"

    def create(self, validated_data):

        if self.context["request"].user.is_superadmin:
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
