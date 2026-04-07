import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/models.dart';

/// 장바구니 Provider
final cartProvider = StateNotifierProvider<CartNotifier, CartModel>((ref) {
  return CartNotifier();
});

/// 장바구니 아이템 수 Provider
final cartItemCountProvider = Provider<int>((ref) {
  final cart = ref.watch(cartProvider);
  return cart.items.fold(0, (sum, item) => sum + item.quantity);
});

/// 장바구니 총 금액 Provider
final cartTotalAmountProvider = Provider<int>((ref) {
  final cart = ref.watch(cartProvider);
  return cart.items.fold(0, (sum, item) => sum + (item.unitPrice * item.quantity));
});

/// 장바구니 상태 관리 Notifier
class CartNotifier extends StateNotifier<CartModel> {
  CartNotifier() : super(const CartModel());

  /// 상품 추가
  void addItem({
    required String shopId,
    required ProductModel product,
    int quantity = 1,
    FlowerShopModel? shop,
  }) {
    // 다른 가게 상품이면 장바구니 초기화
    if (state.shopId != null && state.shopId != shopId) {
      state = CartModel(shopId: shopId, shop: shop);
    }

    final existingIndex = state.items.indexWhere(
      (item) => item.productId == product.id,
    );

    if (existingIndex >= 0) {
      // 기존 상품 수량 증가
      final updatedItems = List<CartItemModel>.from(state.items);
      final existingItem = updatedItems[existingIndex];
      updatedItems[existingIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + quantity,
      );
      state = state.copyWith(items: updatedItems);
    } else {
      // 새 상품 추가
      final newItem = CartItemModel(
        id: 'cart_${DateTime.now().millisecondsSinceEpoch}',
        productId: product.id,
        name: product.name,
        quantity: quantity,
        unitPrice: product.discountedPrice ?? product.price,
        imageUrl: product.imageUrl,
      );
      state = state.copyWith(
        shopId: shopId,
        shop: shop ?? state.shop,
        items: [...state.items, newItem],
      );
    }
  }

  /// 수량 변경
  void updateQuantity(String itemId, int quantity) {
    if (quantity <= 0) {
      removeItem(itemId);
      return;
    }

    final updatedItems = state.items.map((item) {
      if (item.id == itemId) {
        return item.copyWith(quantity: quantity);
      }
      return item;
    }).toList();

    state = state.copyWith(items: updatedItems);
  }

  /// 상품 제거
  void removeItem(String itemId) {
    final updatedItems = state.items.where((item) => item.id != itemId).toList();

    if (updatedItems.isEmpty) {
      // 장바구니가 비면 초기화
      state = const CartModel();
    } else {
      state = state.copyWith(items: updatedItems);
    }
  }

  /// 장바구니 비우기
  void clear() {
    state = const CartModel();
  }
}
