from math import radians, sin, cos, sqrt, atan2

from django.utils import timezone
from rest_framework import generics, permissions
from rest_framework.exceptions import NotFound
from rest_framework.response import Response
from rest_framework.views import APIView

from .models import (
    Shop,
    Product,
    Slot,
    Post,
    Review,
    FavoriteShop,
    RecentViewProduct,
    Reminder,
)
from .serializers import (
    ShopSerializer,
    SellerShopCreateSerializer,
    ProductSerializer,
    SellerProductSerializer,
    SlotSerializer,
    SellerSlotSerializer,
    PostSerializer,
    SellerPostSerializer,
    ReviewSerializer,
    ReviewCreateSerializer,
    FavoriteShopSerializer,
    RecentViewProductSerializer,
    ReminderSerializer,
)


class SellerShopCreateView(generics.CreateAPIView):
    serializer_class = SellerShopCreateSerializer
    permission_classes = [permissions.IsAuthenticated]


class SellerShopMeView(generics.RetrieveUpdateAPIView):
    serializer_class = ShopSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_object(self):
        try:
            return self.request.user.shop
        except Shop.DoesNotExist:
            raise NotFound("등록된 꽃집이 없습니다.")


class ShopListView(generics.ListAPIView):
    serializer_class = ShopSerializer
    permission_classes = [permissions.AllowAny]

    def get_queryset(self):
        queryset = Shop.objects.filter(is_active=True)

        if self.request.query_params.get("same_day") == "true":
            queryset = queryset.filter(same_day=True)
        if self.request.query_params.get("pickup") == "true":
            queryset = queryset.filter(pickup=True)
        if self.request.query_params.get("delivery") == "true":
            queryset = queryset.filter(delivery=True)
        if self.request.query_params.get("is_open_now") == "true":
            now = timezone.localtime().time()
            queryset = queryset.filter(open_time__lte=now, close_time__gte=now)

        return queryset.order_by("-created_at")


class ShopDetailView(generics.RetrieveAPIView):
    serializer_class = ShopSerializer
    permission_classes = [permissions.AllowAny]

    def get_queryset(self):
        return Shop.objects.filter(is_active=True)


class ShopNearbyView(APIView):
    permission_classes = [permissions.AllowAny]

    def get(self, request):
        lat = request.query_params.get("lat")
        lng = request.query_params.get("lng")
        radius = request.query_params.get("radius", 5)

        if not lat or not lng:
            return Response({"detail": "lat, lng는 필수입니다."}, status=400)

        lat = float(lat)
        lng = float(lng)
        radius = float(radius)

        result = []

        for shop in Shop.objects.filter(is_active=True):
            distance = self.calculate_distance(lat, lng, float(shop.lat), float(shop.lng))

            if distance <= radius:
                data = ShopSerializer(shop).data
                data["distance_km"] = round(distance, 2)
                result.append(data)

        result.sort(key=lambda x: x["distance_km"])
        return Response(result)

    def calculate_distance(self, lat1, lng1, lat2, lng2):
        r = 6371
        dlat = radians(lat2 - lat1)
        dlng = radians(lng2 - lng1)

        a = (
            sin(dlat / 2) ** 2
            + cos(radians(lat1)) * cos(radians(lat2)) * sin(dlng / 2) ** 2
        )

        return r * 2 * atan2(sqrt(a), sqrt(1 - a))


class ShopProductListView(generics.ListAPIView):
    serializer_class = ProductSerializer
    permission_classes = [permissions.AllowAny]

    def get_queryset(self):
        return Product.objects.filter(
            shop_id=self.kwargs["shop_id"],
            shop__is_active=True,
            is_available=True
        ).order_by("-created_at")


class ProductDetailView(generics.RetrieveAPIView):
    serializer_class = ProductSerializer
    permission_classes = [permissions.AllowAny]

    def get_queryset(self):
        return Product.objects.filter(shop__is_active=True, is_available=True)


class SellerProductCreateView(generics.CreateAPIView):
    serializer_class = SellerProductSerializer
    permission_classes = [permissions.IsAuthenticated]


class SellerProductDetailView(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = SellerProductSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        if not hasattr(self.request.user, "shop"):
            return Product.objects.none()

        return Product.objects.filter(shop=self.request.user.shop)


class ProductAvailabilityView(APIView):
    permission_classes = [permissions.AllowAny]

    def get(self, request, product_id):
        product = generics.get_object_or_404(
            Product,
            id=product_id,
            shop__is_active=True,
            is_available=True
        )

        return Response({
            "product_id": product.id,
            "date": request.query_params.get("date"),
            "is_available": product.is_available,
            "same_day_available": product.same_day_available,
        })


class ProductRecommendedSlotsView(APIView):
    permission_classes = [permissions.AllowAny]

    def get(self, request, product_id):
        product = generics.get_object_or_404(
            Product,
            id=product_id,
            shop__is_active=True,
            is_available=True
        )

        return Response({
            "product_id": product.id,
            "date": request.query_params.get("date"),
            "recommended_slots": ["10:00", "12:00", "14:00", "16:00", "18:00"]
        })


class ShopSlotListView(generics.ListAPIView):
    serializer_class = SlotSerializer
    permission_classes = [permissions.AllowAny]

    def get_queryset(self):
        queryset = Slot.objects.filter(
            shop_id=self.kwargs["shop_id"],
            shop__is_active=True,
            is_active=True
        )

        date = self.request.query_params.get("date")
        if date:
            queryset = queryset.filter(date=date)

        return queryset.order_by("date", "start_time")


class ShopAvailableSlotListView(generics.ListAPIView):
    serializer_class = SlotSerializer
    permission_classes = [permissions.AllowAny]

    def get_queryset(self):
        queryset = Slot.objects.filter(
            shop_id=self.kwargs["shop_id"],
            shop__is_active=True,
            is_active=True
        )

        date = self.request.query_params.get("date")
        product_type = self.request.query_params.get("product_type")

        if date:
            queryset = queryset.filter(date=date)
        if product_type:
            queryset = queryset.filter(product_type=product_type)

        return [slot for slot in queryset.order_by("date", "start_time") if slot.is_available]


class SellerSlotListCreateView(generics.ListCreateAPIView):
    serializer_class = SellerSlotSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        if not hasattr(self.request.user, "shop"):
            return Slot.objects.none()

        queryset = Slot.objects.filter(shop=self.request.user.shop)

        date = self.request.query_params.get("date")
        if date:
            queryset = queryset.filter(date=date)

        return queryset.order_by("date", "start_time")


class SellerSlotDetailView(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = SellerSlotSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        if not hasattr(self.request.user, "shop"):
            return Slot.objects.none()

        return Slot.objects.filter(shop=self.request.user.shop)


class PostListView(generics.ListAPIView):
    serializer_class = PostSerializer
    permission_classes = [permissions.AllowAny]

    def get_queryset(self):
        return Post.objects.filter(is_active=True, shop__is_active=True).order_by("-created_at")


class ShopPostListView(generics.ListAPIView):
    serializer_class = PostSerializer
    permission_classes = [permissions.AllowAny]

    def get_queryset(self):
        return Post.objects.filter(
            shop_id=self.kwargs["shop_id"],
            is_active=True,
            shop__is_active=True
        ).order_by("-created_at")


class PostDetailView(generics.RetrieveAPIView):
    serializer_class = PostSerializer
    permission_classes = [permissions.AllowAny]

    def get_queryset(self):
        return Post.objects.filter(is_active=True, shop__is_active=True)


class SellerPostCreateView(generics.CreateAPIView):
    serializer_class = SellerPostSerializer
    permission_classes = [permissions.IsAuthenticated]


class SellerPostDetailView(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = SellerPostSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        if not hasattr(self.request.user, "shop"):
            return Post.objects.none()

        return Post.objects.filter(shop=self.request.user.shop)


class ReviewCreateView(generics.CreateAPIView):
    serializer_class = ReviewCreateSerializer
    permission_classes = [permissions.IsAuthenticated]


class ShopReviewListView(generics.ListAPIView):
    serializer_class = ReviewSerializer
    permission_classes = [permissions.AllowAny]

    def get_queryset(self):
        return Review.objects.filter(shop_id=self.kwargs["shop_id"]).order_by("-created_at")


class FavoriteShopCreateView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def post(self, request, shop_id):
        shop = generics.get_object_or_404(Shop, id=shop_id, is_active=True)

        favorite, created = FavoriteShop.objects.get_or_create(
            user=request.user,
            shop=shop
        )

        return Response({
            "message": "찜 등록 완료",
            "shop_id": shop.id,
            "created": created
        }, status=201)


class FavoriteShopDeleteView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def delete(self, request, shop_id):
        FavoriteShop.objects.filter(user=request.user, shop_id=shop_id).delete()
        return Response(status=204)


class FavoriteShopListView(generics.ListAPIView):
    serializer_class = FavoriteShopSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        return FavoriteShop.objects.filter(user=self.request.user).order_by("-created_at")


class RecentViewProductCreateView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def post(self, request, product_id):
        product = generics.get_object_or_404(Product, id=product_id, is_available=True)

        recent, created = RecentViewProduct.objects.get_or_create(
            user=request.user,
            product=product
        )
        recent.save()

        return Response({
            "message": "최근 조회 등록 완료",
            "product_id": product.id
        }, status=201)


class RecentViewProductListView(generics.ListAPIView):
    serializer_class = RecentViewProductSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        return RecentViewProduct.objects.filter(user=self.request.user).order_by("-viewed_at")


class ReminderListCreateView(generics.ListCreateAPIView):
    serializer_class = ReminderSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        return Reminder.objects.filter(user=self.request.user).order_by("remind_at")


class ReminderDetailView(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = ReminderSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        return Reminder.objects.filter(user=self.request.user)