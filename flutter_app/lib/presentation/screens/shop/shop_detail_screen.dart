import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../core/theme/app_theme.dart';
import '../../../services/location_service.dart';
import '../../providers/shop_provider.dart';
import '../../providers/favorite_provider.dart';
import '../../providers/review_provider.dart';
import '../../widgets/review_card.dart';

class ShopDetailScreen extends ConsumerWidget {
  final String shopId;

  const ShopDetailScreen({
    super.key,
    required this.shopId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shopAsync = ref.watch(shopDetailProvider(shopId));
    final photosAsync = ref.watch(shopPhotosProvider(shopId));
    final favoriteIds = ref.watch(favoriteShopIdsProvider);

    return shopAsync.when(
      data: (shop) {
        if (shop == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: Text('꽃집을 찾을 수 없습니다')),
          );
        }

        final isFavorite = favoriteIds.contains(shop.id);

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              // App Bar with images
              SliverAppBar(
                expandedHeight: 250,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: photosAsync.when(
                    data: (photos) {
                      if (photos.isEmpty) {
                        return Container(
                          color: AppColors.primaryLight,
                          child: const Icon(
                            Icons.local_florist,
                            size: 80,
                            color: AppColors.primary,
                          ),
                        );
                      }
                      return CarouselSlider(
                        items: photos.map((photo) {
                          return CachedNetworkImage(
                            imageUrl: photo.url,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          );
                        }).toList(),
                        options: CarouselOptions(
                          height: 300,
                          viewportFraction: 1.0,
                          enableInfiniteScroll: photos.length > 1,
                          autoPlay: photos.length > 1,
                        ),
                      );
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    error: (_, __) => Container(
                      color: AppColors.primaryLight,
                      child: const Icon(Icons.local_florist, size: 80),
                    ),
                  ),
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? AppColors.primary : null,
                    ),
                    onPressed: () {
                      ref
                          .read(favoritesProvider.notifier)
                          .toggleFavorite(shop.id);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () {
                      // Share functionality
                    },
                  ),
                ],
              ),

              // Content
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name and verified badge
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              shop.name,
                              style: AppTextStyles.heading2,
                            ),
                          ),
                          if (shop.isVerified)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.sm,
                                vertical: AppSpacing.xs,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.verified.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.verified,
                                    size: 16,
                                    color: AppColors.verified,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    '인증됨',
                                    style: TextStyle(
                                      color: AppColors.verified,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),

                      // Rating and reviews
                      Row(
                        children: [
                          RatingBarIndicator(
                            rating: shop.averageRating,
                            itemBuilder: (_, __) => const Icon(
                              Icons.star,
                              color: AppColors.star,
                            ),
                            itemCount: 5,
                            itemSize: 20,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Text(
                            shop.averageRating.toStringAsFixed(1),
                            style: AppTextStyles.bodyLarge.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            '(${shop.reviewCount}개 리뷰)',
                            style: AppTextStyles.bodySmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // Distance
                      if (shop.distanceMeters != null)
                        Row(
                          children: [
                            const Icon(
                              Icons.near_me,
                              size: 16,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Text(
                              '${LocationService.formatDistance(shop.distanceMeters)} 거리',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: AppSpacing.lg),

                      // Description
                      if (shop.description != null) ...[
                        Text(
                          shop.description!,
                          style: AppTextStyles.bodyMedium,
                        ),
                        const SizedBox(height: AppSpacing.lg),
                      ],

                      // Contact info
                      _buildInfoSection(context, shop),

                      const Divider(height: AppSpacing.xl),

                      // Opening hours
                      if (shop.openingHours != null &&
                          shop.openingHours!.isNotEmpty) ...[
                        _buildOpeningHours(shop.openingHours!),
                        const Divider(height: AppSpacing.xl),
                      ],

                      // Reviews section
                      _buildReviewsSection(context, ref),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  // Call button
                  if (shop.phone != null)
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _makePhoneCall(shop.phone!),
                        icon: const Icon(Icons.call),
                        label: const Text('전화'),
                      ),
                    ),
                  if (shop.phone != null) const SizedBox(width: AppSpacing.md),
                  // Directions button
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _openMaps(shop.latitude, shop.longitude),
                      icon: const Icon(Icons.directions),
                      label: const Text('길찾기'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48),
              const SizedBox(height: AppSpacing.md),
              Text('오류가 발생했습니다: $e'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context, dynamic shop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('정보', style: AppTextStyles.heading3),
        const SizedBox(height: AppSpacing.md),

        // Address
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.location_on, color: AppColors.primary),
          title: Text(shop.address),
          subtitle:
              shop.addressDetail != null ? Text(shop.addressDetail!) : null,
          trailing: IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () {
              // Copy address
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('주소가 복사되었습니다')),
              );
            },
          ),
        ),

        // Phone
        if (shop.phone != null)
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.phone, color: AppColors.primary),
            title: Text(shop.phone!),
            onTap: () => _makePhoneCall(shop.phone!),
          ),

        // Website
        if (shop.website != null)
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.language, color: AppColors.primary),
            title: Text(shop.website!),
            onTap: () => _openUrl(shop.website!),
          ),

        // Instagram
        if (shop.instagram != null)
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.camera_alt, color: AppColors.primary),
            title: Text('@${shop.instagram}'),
            onTap: () =>
                _openUrl('https://instagram.com/${shop.instagram}'),
          ),
      ],
    );
  }

  Widget _buildOpeningHours(Map<String, String> hours) {
    final dayNames = {
      'mon': '월요일',
      'tue': '화요일',
      'wed': '수요일',
      'thu': '목요일',
      'fri': '금요일',
      'sat': '토요일',
      'sun': '일요일',
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('영업시간', style: AppTextStyles.heading3),
        const SizedBox(height: AppSpacing.md),
        ...dayNames.entries.map((entry) {
          final time = hours[entry.key] ?? '정보 없음';
          final isClosed = time.toLowerCase() == 'closed';
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(entry.value, style: AppTextStyles.bodyMedium),
                Text(
                  isClosed ? '휴무' : time,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: isClosed ? AppColors.error : AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildReviewsSection(BuildContext context, WidgetRef ref) {
    final reviewsAsync = ref.watch(shopReviewsProvider(shopId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('리뷰', style: AppTextStyles.heading3),
            TextButton(
              onPressed: () => context.push('/shop/$shopId/reviews'),
              child: const Text('전체보기'),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),

        // Write review button
        OutlinedButton.icon(
          onPressed: () => context.push('/shop/$shopId/write-review'),
          icon: const Icon(Icons.edit),
          label: const Text('리뷰 작성하기'),
        ),
        const SizedBox(height: AppSpacing.md),

        // Reviews list
        reviewsAsync.when(
          data: (reviews) {
            if (reviews.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(AppSpacing.lg),
                child: Center(
                  child: Text('아직 리뷰가 없습니다. 첫 번째 리뷰를 작성해보세요!'),
                ),
              );
            }
            return Column(
              children: reviews.take(3).map((review) {
                return ReviewCard(review: review);
              }).toList(),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, __) => const Text('리뷰를 불러올 수 없습니다'),
        ),
      ],
    );
  }

  Future<void> _makePhoneCall(String phone) async {
    final uri = Uri.parse('tel:$phone');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url.startsWith('http') ? url : 'https://$url');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _openMaps(double lat, double lng) async {
    final uri = Uri.parse(
      'https://maps.google.com/maps?daddr=$lat,$lng',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
