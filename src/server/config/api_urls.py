from backend.users.api.views import *
from django.urls.conf import path

urlpatterns = [path("profile/me", ProfileInfoView.as_view())]
