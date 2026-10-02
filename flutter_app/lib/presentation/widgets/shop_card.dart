import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/flower_shop_model.dart';
import '../../services/location_service.dart';
import '../providers/favorite_provider.dart';

class ShopCard extends ConsumerWidget {
  final FlowerShopModel shop;
  final VoidCallback? onTap;
  final bool showFavoriteButton;

  const ShopCard({
    super.key,
    required this.shop,
    this.onTap,
    this.showFavoriteButton = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteIds = ref.watch(favoriteShopIdsProvider);
    final isFavorite = favoriteIds.contains(shop.id);

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: shop.primaryPhotoUrl != null
                    ? CachedNetworkImage(
                        imageUrl: shop.primaryPhotoUrl!,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => Container(
                          color: AppColors.divider,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (_, __, ___) => _buildPlaceholder(),
                      )
                    : _buildPlaceholder(),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name & Verified badge
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          shop.name,
                          style: AppTextStyles.heading3,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (shop.isVerified)
                        const Icon(
                          Icons.verified,
                          size: 18,
                          color: AppColors.verified,
                        ),
                      if (showFavoriteButton)
                        IconButton(
                          icon: Icon(
                            isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: isFavorite
                                ? AppColors.primary
                                : AppColors.textSecondary,
                          ),
                          onPressed: () {
                            ref
                                .read(favoritesProvider.notifier)
                                .toggleFavorite(shop.id);
                          },
                        ),
                    ],
                  ),

                  // Rating & Reviews
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 16,
                        color: AppColors.star,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        shop.averageRating.toStringAsFixed(1),
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '(${shop.reviewCount})',
                        style: AppTextStyles.bodySmall,
                      ),
                      const Spacer(),
                      if (shop.distanceMeters != null)
                        Text(
                          LocationService.formatDistance(shop.distanceMeters),
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),

                  // Address
                  Text(
                    shop.address,
                    style: AppTextStyles.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: AppColors.primaryLight,
      child: const Center(
        child: Icon(
          Icons.local_florist,
          size: 48,
          color: AppColors.primary,
        ),
      ),
    );
  }
}

// Compact version for lists
class ShopListTile extends ConsumerWidget {
  final FlowerShopModel shop;
  final VoidCallback? onTap;

  const ShopListTile({
    super.key,
    required this.shop,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteIds = ref.watch(favoriteShopIdsProvider);
    final isFavorite = favoriteIds.contains(shop.id);

    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: 60,
          height: 60,
          child: shop.primaryPhotoUrl != null
              ? CachedNetworkImage(
                  imageUrl: shop.primaryPhotoUrl!,
                  fit: BoxFit.cover,
                  errorWidget: (_, __, ___) => _buildSmallPlaceholder(),
                )
              : _buildSmallPlaceholder(),
        ),
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              shop.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (shop.isVerified)
            const Padding(
              padding: EdgeInsets.only(left: 4),
              child: Icon(
                Icons.verified,
                size: 16,
                color: AppColors.verified,
              ),
            ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.star, size: 14, color: AppColors.star),
              const SizedBox(width: 2),
              Text(
                '${shop.averageRating.toStringAsFixed(1)} (${shop.reviewCount})',
                style: AppTextStyles.caption,
              ),
              if (shop.distanceMeters != null) ...[
                const SizedBox(width: 8),
                Text(
                  LocationService.formatDistance(shop.distanceMeters),
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ],
          ),
          Text(
            shop.address,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.caption,
          ),
        ],
      ),
      trailing: IconButton(
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? AppColors.primary : AppColors.textSecondary,
        ),
        onPressed: () {
          ref.read(favoritesProvider.notifier).toggleFavorite(shop.id);
        },
      ),
    );
  }

  Widget _buildSmallPlaceholder() {
    return Container(
      color: AppColors.primaryLight,
      child: const Icon(
        Icons.local_florist,
        color: AppColors.primary,
      ),
    );
  }
}
