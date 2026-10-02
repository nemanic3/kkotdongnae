from django.utils import timezone
from rest_framework import generics, permissions, status
from rest_framework.exceptions import PermissionDenied
from rest_framework.response import Response
from rest_framework.views import APIView

from .models import Order
from .serializers import (
    OrderSerializer,
    OrderCreateSerializer,
    OrderStatusUpdateSerializer,
    ReasonSerializer,
)


class OrderListCreateView(generics.ListCreateAPIView):
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        return Order.objects.filter(user=self.request.user).order_by("-created_at")

    def get_serializer_class(self):
        if self.request.method == "POST":
            return OrderCreateSerializer
        return OrderSerializer


class OrderDetailView(generics.RetrieveAPIView):
    serializer_class = OrderSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        return Order.objects.filter(user=self.request.user)


class OrderCancelRequestView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def post(self, request, order_id):
        order = generics.get_object_or_404(
            Order,
            id=order_id,
            user=request.user
        )

        serializer = ReasonSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        if order.status in ["completed", "cancelled", "refunded"]:
            return Response(
                {"detail": "취소 요청이 불가능한 주문입니다."},
                status=400
            )

        order.status = "cancel_requested"
        order.cancel_reason = serializer.validated_data.get("reason", "")
        order.save()

        return Response(OrderSerializer(order).data)


class OrderPayView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def post(self, request, order_id):
        order = generics.get_object_or_404(
            Order,
            id=order_id,
            user=request.user
        )

        if order.status != "pending":
            return Response(
                {"detail": "결제 가능한 상태가 아닙니다."},
                status=400
            )

        order.status = "paid"
        order.paid_at = timezone.now()
        order.save()

        return Response({
            "message": "결제 완료",
            "order": OrderSerializer(order).data
        })


class SellerOrderListView(generics.ListAPIView):
    serializer_class = OrderSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        if not hasattr(self.request.user, "shop"):
            return Order.objects.none()

        return Order.objects.filter(
            shop=self.request.user.shop
        ).order_by("-created_at")


class SellerOrderDetailView(generics.RetrieveAPIView):
    serializer_class = OrderSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        if not hasattr(self.request.user, "shop"):
            return Order.objects.none()

        return Order.objects.filter(shop=self.request.user.shop)


class SellerOrderAcceptView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def post(self, request, order_id):
        order = self.get_seller_order(request, order_id)

        if order.status != "paid":
            return Response(
                {"detail": "결제 완료 상태의 주문만 수락할 수 있습니다."},
                status=400
            )

        order.status = "accepted"
        order.accepted_at = timezone.now()
        order.save()

        return Response(OrderSerializer(order).data)

    def get_seller_order(self, request, order_id):
        if not hasattr(request.user, "shop"):
            raise PermissionDenied("판매자 꽃집이 없습니다.")

        return generics.get_object_or_404(
            Order,
            id=order_id,
            shop=request.user.shop
        )


class SellerOrderRejectView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def post(self, request, order_id):
        if not hasattr(request.user, "shop"):
            raise PermissionDenied("판매자 꽃집이 없습니다.")

        order = generics.get_object_or_404(
            Order,
            id=order_id,
            shop=request.user.shop
        )

        serializer = ReasonSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        if order.status not in ["paid", "pending"]:
            return Response(
                {"detail": "거절할 수 없는 주문 상태입니다."},
                status=400
            )

        order.status = "rejected"
        order.reject_reason = serializer.validated_data.get("reason", "")
        order.save()

        return Response(OrderSerializer(order).data)


class SellerOrderStatusUpdateView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def post(self, request, order_id):
        if not hasattr(request.user, "shop"):
            raise PermissionDenied("판매자 꽃집이 없습니다.")

        order = generics.get_object_or_404(
            Order,
            id=order_id,
            shop=request.user.shop
        )

        serializer = OrderStatusUpdateSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        order = serializer.update(order, serializer.validated_data)

        return Response(OrderSerializer(order).data)


class SellerOrderRefundView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def post(self, request, order_id):
        if not hasattr(request.user, "shop"):
            raise PermissionDenied("판매자 꽃집이 없습니다.")

        order = generics.get_object_or_404(
            Order,
            id=order_id,
            shop=request.user.shop
        )

        serializer = ReasonSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        if order.status not in ["paid", "accepted", "preparing", "cancel_requested"]:
            return Response(
                {"detail": "환불할 수 없는 주문 상태입니다."},
                status=400
            )

        order.status = "refunded"
        order.refund_reason = serializer.validated_data.get("reason", "")
        order.refunded_at = timezone.now()
        order.save()

        return Response(OrderSerializer(order).data)