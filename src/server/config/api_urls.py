from backend.appraisals.api.views import *
from backend.users.api.views import *
from django.urls.conf import path

urlpatterns = [
    path("profile/me", ProfileInfoView.as_view()),
    path("check/username", check_username),
    path("check/email", check_email),
    path("check/contact_number", check_contact_number),
    path("check/password", check_password),
    path("user/reset_password", reset_password),
    path("user/get_token", get_token),
    path("appraisal/me", MyAppraisalView.as_view()),
    path("appraisal/manager", ManagerAppraisalView.as_view()),
    path("user/short", ShortEmployeeView.as_view()),
    path("appraisal/status", appraisal_status),
]
