from backend.users.api.views import *
from django.urls.conf import path

urlpatterns = [
    path("profile/me", ProfileInfoView.as_view()),
    path("check/username", check_username),
    path("check/email", check_email),
    path("check/password", check_password),
]
