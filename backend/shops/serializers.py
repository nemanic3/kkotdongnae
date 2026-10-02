from rest_framework import serializers
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


class ShopSerializer(serializers.ModelSerializer):
    class Meta:
        model = Shop
        fields = "__all__"
        read_only_fields = ["id", "owner", "created_at", "updated_at"]


class SellerShopCreateSerializer(serializers.ModelSerializer):
    class Meta:
        model = Shop
        exclude = ["owner", "is_active", "created_at", "updated_at"]

    def create(self, validated_data):
        user = self.context["request"].user

        if hasattr(user, "shop"):
            raise serializers.ValidationError("이미 등록된 꽃집이 있습니다.")

        return Shop.objects.create(owner=user, **validated_data)


class ProductSerializer(serializers.ModelSerializer):
    shop_id = serializers.ReadOnlyField(source="shop.id")
    shop_name = serializers.ReadOnlyField(source="shop.name")

    class Meta:
        model = Product
        fields = "__all__"
        read_only_fields = ["id", "shop", "created_at", "updated_at"]


class SellerProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = Product
        exclude = ["shop", "created_at", "updated_at"]

    def create(self, validated_data):
        user = self.context["request"].user

        if not hasattr(user, "shop"):
            raise serializers.ValidationError("먼저 꽃집을 등록해야 합니다.")

        return Product.objects.create(shop=user.shop, **validated_data)


class SlotSerializer(serializers.ModelSerializer):
    shop_id = serializers.ReadOnlyField(source="shop.id")
    shop_name = serializers.ReadOnlyField(source="shop.name")
    is_available = serializers.ReadOnlyField()

    class Meta:
        model = Slot
        fields = "__all__"
        read_only_fields = ["id", "shop", "reserved_count", "created_at", "updated_at"]


class SellerSlotSerializer(serializers.ModelSerializer):
    is_available = serializers.ReadOnlyField()

    class Meta:
        model = Slot
        exclude = ["shop", "reserved_count", "created_at", "updated_at"]

    def create(self, validated_data):
        user = self.context["request"].user

        if not hasattr(user, "shop"):
            raise serializers.ValidationError("먼저 꽃집을 등록해야 합니다.")

        return Slot.objects.create(shop=user.shop, **validated_data)


class PostSerializer(serializers.ModelSerializer):
    shop_id = serializers.ReadOnlyField(source="shop.id")
    shop_name = serializers.ReadOnlyField(source="shop.name")

    class Meta:
        model = Post
        fields = "__all__"
        read_only_fields = ["id", "shop", "created_at", "updated_at"]


class SellerPostSerializer(serializers.ModelSerializer):
    class Meta:
        model = Post
        exclude = ["shop", "created_at", "updated_at"]

    def create(self, validated_data):
        user = self.context["request"].user

        if not hasattr(user, "shop"):
            raise serializers.ValidationError("먼저 꽃집을 등록해야 합니다.")

        return Post.objects.create(shop=user.shop, **validated_data)


class ReviewSerializer(serializers.ModelSerializer):
    user_id = serializers.ReadOnlyField(source="user.id")
    shop_name = serializers.ReadOnlyField(source="shop.name")
    product_name = serializers.ReadOnlyField(source="product.name")

    class Meta:
        model = Review
        fields = "__all__"
        read_only_fields = ["id", "user", "created_at"]


class ReviewCreateSerializer(serializers.ModelSerializer):
    class Meta:
        model = Review
        fields = ["shop", "product", "rating", "comment"]

    def validate_rating(self, value):
        if value < 1 or value > 5:
            raise serializers.ValidationError("평점은 1~5 사이여야 합니다.")
        return value

    def create(self, validated_data):
        return Review.objects.create(
            user=self.context["request"].user,
            **validated_data
        )


class FavoriteShopSerializer(serializers.ModelSerializer):
    shop = ShopSerializer(read_only=True)

    class Meta:
        model = FavoriteShop
        fields = ["id", "shop", "created_at"]


class RecentViewProductSerializer(serializers.ModelSerializer):
    product = ProductSerializer(read_only=True)

    class Meta:
        model = RecentViewProduct
        fields = ["id", "product", "viewed_at"]


class ReminderSerializer(serializers.ModelSerializer):
    class Meta:
        model = Reminder
        fields = "__all__"
        read_only_fields = ["id", "user", "created_at"]

    def create(self, validated_data):
        return Reminder.objects.create(
            user=self.context["request"].user,
            **validated_data
        )