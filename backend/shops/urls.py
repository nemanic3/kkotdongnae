from django.urls import path
from .views import (
    SellerShopCreateView,
    SellerShopMeView,
    ShopListView,
    ShopDetailView,
    ShopNearbyView,
    ShopProductListView,
    ProductDetailView,
    SellerProductCreateView,
    SellerProductDetailView,
    ProductAvailabilityView,
    ProductRecommendedSlotsView,
    ShopSlotListView,
    ShopAvailableSlotListView,
    SellerSlotListCreateView,
    SellerSlotDetailView,
    PostListView,
    ShopPostListView,
    PostDetailView,
    SellerPostCreateView,
    SellerPostDetailView,
    ReviewCreateView,
    ShopReviewListView,
    FavoriteShopCreateView,
    FavoriteShopDeleteView,
    FavoriteShopListView,
    RecentViewProductCreateView,
    RecentViewProductListView,
    ReminderListCreateView,
    ReminderDetailView,
)

urlpatterns = [
    path("seller/shops/", SellerShopCreateView.as_view()),
    path("seller/shops/me/", SellerShopMeView.as_view()),

    path("shops/", ShopListView.as_view()),
    path("shops/nearby/", ShopNearbyView.as_view()),
    path("shops/<int:pk>/", ShopDetailView.as_view()),

    path("shops/<int:shop_id>/products/", ShopProductListView.as_view()),
    path("products/<int:pk>/", ProductDetailView.as_view()),
    path("seller/products/", SellerProductCreateView.as_view()),
    path("seller/products/<int:pk>/", SellerProductDetailView.as_view()),
    path("products/<int:product_id>/availability/", ProductAvailabilityView.as_view()),
    path("products/<int:product_id>/recommended-slots/", ProductRecommendedSlotsView.as_view()),

    path("shops/<int:shop_id>/slots/", ShopSlotListView.as_view()),
    path("shops/<int:shop_id>/slots/available/", ShopAvailableSlotListView.as_view()),
    path("seller/slots/", SellerSlotListCreateView.as_view()),
    path("seller/slots/<int:pk>/", SellerSlotDetailView.as_view()),

    path("posts/", PostListView.as_view()),
    path("shops/<int:shop_id>/posts/", ShopPostListView.as_view()),
    path("posts/<int:pk>/", PostDetailView.as_view()),
    path("seller/posts/", SellerPostCreateView.as_view()),
    path("seller/posts/<int:pk>/", SellerPostDetailView.as_view()),

    path("reviews/", ReviewCreateView.as_view()),
    path("shops/<int:shop_id>/reviews/", ShopReviewListView.as_view()),

    path("favorites/shops/<int:shop_id>/", FavoriteShopCreateView.as_view()),
    path("favorites/shops/<int:shop_id>/delete/", FavoriteShopDeleteView.as_view()),
    path("favorites/shops/", FavoriteShopListView.as_view()),

    path("recent-views/products/<int:product_id>/", RecentViewProductCreateView.as_view()),
    path("recent-views/products/", RecentViewProductListView.as_view()),

    path("reminders/", ReminderListCreateView.as_view()),
    path("reminders/<int:pk>/", ReminderDetailView.as_view()),
]