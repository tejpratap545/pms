from backend.training.api.views import *
from backend.users.api.views import *
from backend.users.api.views import CompanyViewSet, DepartmentViewSet
from django.conf import settings
from rest_framework.routers import DefaultRouter, SimpleRouter

if settings.DEBUG:
    router = DefaultRouter()
else:
    router = SimpleRouter()


router.register("company", CompanyViewSet, basename="Company")
router.register("user", ProfileViewSet, basename="Pofile")
router.register("department", DepartmentViewSet, basename="Department")
router.register("role", RoleViewSet, basename="Role")
router.register("permission", PermissionViewSet, basename="Permission")

router.register("category/goal", GoalCategoryViewSet, basename="GoalCategory")
router.register(
    "category/core_value", CoreValueCategoryViewSet, basename="CoreValueCategory"
)
router.register("category/skills", SkillsCategoryViewSet, basename="SkillsCategory")
app_name = "pms"
urlpatterns = router.urls
