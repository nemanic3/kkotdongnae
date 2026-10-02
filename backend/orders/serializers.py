from django.utils import timezone
from rest_framework import serializers

from shops.models import Product, Slot
from .models import Order


class OrderSerializer(serializers.ModelSerializer):
    product_name = serializers.ReadOnlyField(source="product.name")
    shop_name = serializers.ReadOnlyField(source="shop.name")

    class Meta:
        model = Order
        fields = [
            "id",
            "user",
            "shop",
            "shop_name",
            "product",
            "product_name",
            "slot",
            "quantity",
            "total_price",
            "receive_type",
            "request_message",
            "delivery_address",
            "status",
            "cancel_reason",
            "reject_reason",
            "refund_reason",
            "paid_at",
            "accepted_at",
            "completed_at",
            "refunded_at",
            "created_at",
            "updated_at",
        ]
        read_only_fields = [
            "id",
            "user",
            "shop",
            "total_price",
            "status",
            "paid_at",
            "accepted_at",
            "completed_at",
            "refunded_at",
            "created_at",
            "updated_at",
        ]


class OrderCreateSerializer(serializers.ModelSerializer):
    class Meta:
        model = Order
        fields = [
            "product",
            "slot",
            "quantity",
            "receive_type",
            "request_message",
            "delivery_address",
        ]

    def validate(self, attrs):
        product = attrs["product"]
        slot = attrs.get("slot")
        quantity = attrs.get("quantity", 1)

        if not product.is_available:
            raise serializers.ValidationError("판매 중인 상품이 아닙니다.")

        if quantity < 1:
            raise serializers.ValidationError("수량은 1개 이상이어야 합니다.")

        if slot:
            if slot.shop != product.shop:
                raise serializers.ValidationError("상품의 꽃집과 슬롯의 꽃집이 다릅니다.")

            if not slot.is_available:
                raise serializers.ValidationError("예약 가능한 슬롯이 아닙니다.")

        return attrs

    def create(self, validated_data):
        product = validated_data["product"]
        quantity = validated_data.get("quantity", 1)

        order = Order.objects.create(
            user=self.context["request"].user,
            shop=product.shop,
            total_price=product.price * quantity,
            **validated_data
        )

        slot = validated_data.get("slot")
        if slot:
            slot.reserved_count += 1
            slot.save()

        return order


class OrderStatusUpdateSerializer(serializers.Serializer):
    status = serializers.ChoiceField(
        choices=[
            "preparing",
            "ready",
            "completed",
        ]
    )

    def update(self, instance, validated_data):
        instance.status = validated_data["status"]

        if instance.status == "completed":
            instance.completed_at = timezone.now()

        instance.save()
        return instance


class ReasonSerializer(serializers.Serializer):
    reason = serializers.CharField(required=False, allow_blank=True)