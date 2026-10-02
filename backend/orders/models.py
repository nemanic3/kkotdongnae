from django.conf import settings
from django.db import models
from shops.models import Shop, Product, Slot


class Order(models.Model):
    STATUS_CHOICES = [
        ("pending", "주문 대기"),
        ("paid", "결제 완료"),
        ("accepted", "판매자 수락"),
        ("rejected", "판매자 거절"),
        ("preparing", "제작 중"),
        ("ready", "픽업/배송 준비"),
        ("completed", "완료"),
        ("cancel_requested", "취소 요청"),
        ("cancelled", "취소 완료"),
        ("refunded", "환불 완료"),
    ]

    RECEIVE_TYPE_CHOICES = [
        ("pickup", "픽업"),
        ("delivery", "배송"),
    ]

    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name="orders"
    )

    shop = models.ForeignKey(
        Shop,
        on_delete=models.CASCADE,
        related_name="orders"
    )

    product = models.ForeignKey(
        Product,
        on_delete=models.CASCADE,
        related_name="orders"
    )

    slot = models.ForeignKey(
        Slot,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="orders"
    )

    quantity = models.PositiveIntegerField(default=1)
    total_price = models.PositiveIntegerField()

    receive_type = models.CharField(
        max_length=20,
        choices=RECEIVE_TYPE_CHOICES,
        default="pickup"
    )

    request_message = models.TextField(blank=True)
    delivery_address = models.CharField(max_length=255, blank=True)

    status = models.CharField(
        max_length=30,
        choices=STATUS_CHOICES,
        default="pending"
    )

    cancel_reason = models.TextField(blank=True)
    reject_reason = models.TextField(blank=True)
    refund_reason = models.TextField(blank=True)

    paid_at = models.DateTimeField(null=True, blank=True)
    accepted_at = models.DateTimeField(null=True, blank=True)
    completed_at = models.DateTimeField(null=True, blank=True)
    refunded_at = models.DateTimeField(null=True, blank=True)

    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)