from .health import health
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path("api/health/", health),
    path("admin/", admin.site.urls),
    path("api/", include("accounts.urls")),
    path("api/", include("shops.urls")),
    path("api/", include("orders.urls")),
]