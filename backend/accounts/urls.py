from django.urls import path
from rest_framework_simplejwt.views import TokenRefreshView

from .views import (
    SignupView,
    LoginView,
    LogoutView,
    UserMeView,
    MyNotificationListView,
    NotificationReadView,
)

urlpatterns = [
    path("auth/signup/", SignupView.as_view()),
    path("auth/login/", LoginView.as_view()),
    path("auth/logout/", LogoutView.as_view()),
    path("auth/refresh/", TokenRefreshView.as_view()),

    path("users/me/", UserMeView.as_view()),
    path("users/me/notifications/", MyNotificationListView.as_view()),
    path("users/me/notifications/<int:id>/read/", NotificationReadView.as_view()),
]