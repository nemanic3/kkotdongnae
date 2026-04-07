import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/models.dart';
import '../../providers/cart_provider.dart';
import '../../widgets/cart_item_tile.dart';

/// 장바구니 화면
class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final totalAmount = ref.watch(cartTotalAmountProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('장바구니'),
        actions: [
          if (cart.items.isNotEmpty)
            TextButton(
              onPressed: () => _showClearDialog(context, ref),
              child: Text(
                '비우기',
                style: TextStyle(color: AppColors.error),
              ),
            ),
        ],
      ),
      body: cart.items.isEmpty
          ? _buildEmptyCart()
          : _buildCartContent(context, ref, cart, totalAmount),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 80,
            color: AppColors.textHint,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            '장바구니가 비어있습니다',
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '마음에 드는 상품을 담아보세요',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textHint,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartContent(
    BuildContext context,
    WidgetRef ref,
    CartModel cart,
    int totalAmount,
  ) {
    return Column(
      children: [
        // 가게 정보
        if (cart.shop != null) _buildShopInfo(cart.shop!),

        // 상품 목록
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.md),
            itemCount: cart.items.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final item = cart.items[index];
              return CartItemTile(
                item: item,
                onQuantityChanged: (quantity) {
                  ref.read(cartProvider.notifier).updateQuantity(item.id, quantity);
                },
                onRemove: () {
                  ref.read(cartProvider.notifier).removeItem(item.id);
                },
              );
            },
          ),
        ),

        // 결제 정보
        _buildCheckoutSection(context, totalAmount),
      ],
    );
  }

  Widget _buildShopInfo(FlowerShopModel shop) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      color: AppColors.primaryLight.withOpacity(0.3),
      child: Row(
        children: [
          Icon(Icons.store, color: AppColors.primary),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  shop.name,
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  shop.address,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutSection(BuildContext context, int totalAmount) {
    return Container(
      padding: EdgeInsets.only(
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.md,
        bottom: MediaQuery.of(context).padding.bottom + AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '총 결제금액',
                style: AppTextStyles.bodyLarge,
              ),
              Text(
                '${_formatPrice(totalAmount)}원',
                style: AppTextStyles.heading3.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // TODO: 결제 화면으로 이동
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('주문하기 기능은 준비중입니다')),
                );
              },
              child: Text('${_formatPrice(totalAmount)}원 주문하기'),
            ),
          ),
        ],
      ),
    );
  }

  void _showClearDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('장바구니 비우기'),
        content: const Text('장바구니를 비우시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              ref.read(cartProvider.notifier).clear();
              Navigator.pop(context);
            },
            child: Text('비우기', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
}
