from backend.appraisals.api.views import *
from backend.training.api.views import *
from backend.users.api.views import *
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
router.register(
    "over-all-appraisal", OverAllAppraisalViewSet, basename="OverAllAppraisal"
)
router.register("goal", GoalViewSET, basename="Goal")
router.register(
    "departmental-goal", DepartmentalGoalViewset, basename="DepartmentalGoal"
)
router.register(
    "departmental-core-value",
    DepartmentalCoreValueViewset,
    basename="DepartmentalCoreValue",
)
router.register("skill", SkillViewSET, basename="Skill")
router.register("core-value", CoreValueViewSET, basename="CoreValue")
router.register("appraisal", AppraisalViewset, basename="Appraisal")
router.register("kpi", KPIViewSet, basename="KPI")
router.register("notification", NotificationViewSet, basename="Notification")
router.register("log", LogViewSet, basename="Logs")
app_name = "pms"
urlpatterns = router.urls
