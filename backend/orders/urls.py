from django.urls import path
from .views import (
    OrderListCreateView,
    OrderDetailView,
    OrderCancelRequestView,
    OrderPayView,
    SellerOrderListView,
    SellerOrderDetailView,
    SellerOrderAcceptView,
    SellerOrderRejectView,
    SellerOrderStatusUpdateView,
    SellerOrderRefundView,
)

urlpatterns = [
    path("orders/", OrderListCreateView.as_view()),
    path("orders/<int:pk>/", OrderDetailView.as_view()),
    path("orders/<int:order_id>/cancel-request/", OrderCancelRequestView.as_view()),
    path("orders/<int:order_id>/pay/", OrderPayView.as_view()),

    path("seller/orders/", SellerOrderListView.as_view()),
    path("seller/orders/<int:pk>/", SellerOrderDetailView.as_view()),
    path("seller/orders/<int:order_id>/accept/", SellerOrderAcceptView.as_view()),
    path("seller/orders/<int:order_id>/reject/", SellerOrderRejectView.as_view()),
    path("seller/orders/<int:order_id>/update-status/", SellerOrderStatusUpdateView.as_view()),
    path("seller/orders/<int:order_id>/refund/", SellerOrderRefundView.as_view()),
]