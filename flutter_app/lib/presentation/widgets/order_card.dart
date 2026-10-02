import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/models.dart';

/// 주문 내역 카드 위젯
class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.order,
  });

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          // TODO: 주문 상세 페이지로 이동
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('주문번호: ${order.orderNumber}')),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 헤더 (주문번호 & 상태)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    order.orderNumber,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  _buildStatusBadge(),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),

              // 가게 정보
              if (order.shop != null)
                Row(
                  children: [
                    Icon(Icons.store, size: 16, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        order.shop!.name,
                        style: AppTextStyles.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: AppSpacing.sm),

              // 주문 상품
              ...order.items.take(2).map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        // 상품 이미지
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Container(
                            width: 40,
                            height: 40,
                            color: AppColors.primaryLight,
                            child: item.imageUrl != null
                                ? Image.network(
                                    item.imageUrl!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => const Icon(
                                      Icons.local_florist,
                                      size: 20,
                                      color: AppColors.primary,
                                    ),
                                  )
                                : const Icon(
                                    Icons.local_florist,
                                    size: 20,
                                    color: AppColors.primary,
                                  ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            '${item.name} x ${item.quantity}',
                            style: AppTextStyles.bodySmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          '${_formatPrice(item.unitPrice * item.quantity)}원',
                          style: AppTextStyles.bodySmall,
                        ),
                      ],
                    ),
                  )),

              if (order.items.length > 2)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    '외 ${order.items.length - 2}개 상품',
                    style: AppTextStyles.caption,
                  ),
                ),

              const Divider(height: AppSpacing.lg),

              // 하단 (금액 & 픽업 정보)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (order.pickupDate != null)
                        Text(
                          '픽업: ${_formatDate(order.pickupDate!)} ${order.pickupTime ?? ''}',
                          style: AppTextStyles.caption,
                        ),
                      Text(
                        _formatOrderDate(order.createdAt),
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                  Text(
                    '${_formatPrice(order.totalAmount)}원',
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge() {
    Color color;
    String label = order.orderStatus.orderStatusLabel;

    switch (order.orderStatus) {
      case 'pending':
        color = AppColors.textSecondary;
        break;
      case 'confirmed':
        color = AppColors.accent;
        break;
      case 'preparing':
        color = AppColors.primary;
        break;
      case 'ready':
        color = AppColors.secondary;
        break;
      case 'completed':
        color = AppColors.textHint;
        break;
      case 'cancelled':
        color = AppColors.error;
        break;
      default:
        color = AppColors.textSecondary;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }

  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}';
  }

  String _formatOrderDate(DateTime? date) {
    if (date == null) return '';
    return '주문일: ${date.year}.${date.month}.${date.day}';
  }
}
