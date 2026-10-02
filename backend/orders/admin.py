from django.contrib import admin
from .models import Order


@admin.register(Order)
class OrderAdmin(admin.ModelAdmin):
    list_display = [
        "id",
        "user",
        "shop",
        "product",
        "quantity",
        "total_price",
        "status",
        "receive_type",
        "created_at",
    ]