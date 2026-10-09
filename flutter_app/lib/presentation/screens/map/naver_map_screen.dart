import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/models.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../providers/shop_provider.dart';
import '../../providers/location_provider.dart';
import '../../providers/cart_provider.dart';
import '../../widgets/shop_card.dart';

/// 네이버 지도 화면
/// TODO: flutter_naver_map 패키지 설정 후 실제 지도 구현
class NaverMapScreen extends ConsumerStatefulWidget {
  const NaverMapScreen({super.key});

  @override
  ConsumerState<NaverMapScreen> createState() => _NaverMapScreenState();
}

class _NaverMapScreenState extends ConsumerState<NaverMapScreen> {
  FlowerShopModel? _selectedShop;
  List<FlowerShopModel> _shops = [];

  @override
  Widget build(BuildContext context) {
    final cartCount = ref.watch(cartItemCountProvider);
    _shops = ref.watch(nearbyShopsProvider).valueOrNull ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('내 주변'),
        actions: [
          IconButton(tooltip: '꽃집 검색', icon: const Icon(Icons.search), onPressed: () => context.push('/search')),
          // 장바구니 버튼
          Badge(
            isLabelVisible: cartCount > 0,
            label: Text('$cartCount'),
            child: IconButton(
              icon: const Icon(Icons.shopping_bag_outlined),
              onPressed: () => context.push('/cart'),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // 지도 영역 (플레이스홀더)
          _buildMapPlaceholder(),

          // 필터 칩
          Positioned(
            top: AppSpacing.md,
            left: 0,
            right: 0,
            child: _buildFilterChips(),
          ),

          // 내 위치 버튼
          Positioned(
            right: AppSpacing.md,
            bottom: _selectedShop != null ? 200 : AppSpacing.lg,
            child: FloatingActionButton.small(
              heroTag: 'myLocation',
              onPressed: _goToMyLocation,
              backgroundColor: AppColors.surface,
              child: const Icon(Icons.my_location, color: AppColors.primary),
            ),
          ),

          // 선택된 가게 카드
          if (_selectedShop != null)
            Positioned(
              left: AppSpacing.md,
              right: AppSpacing.md,
              bottom: AppSpacing.lg,
              child: _buildSelectedShopCard(),
            ),
        ],
      ),
    );
  }

  Widget _buildMapPlaceholder() {
    return Container(
      color: AppColors.background,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.map_outlined,
              size: 80,
              color: AppColors.textHint,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              '네이버 지도',
              style: AppTextStyles.heading3.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              ref.watch(nearbyShopsProvider).hasError ? '꽃집 정보를 불러올 수 없습니다. 잠시 후 다시 시도해주세요.' : _shops.isEmpty ? '서울 기본 위치입니다. 검색 반경을 넓히거나 내 위치 버튼을 눌러보세요.' : '꽃집을 선택해 지도에서 위치를 확인하세요',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textHint,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            // 임시: 가게 목록 버튼
            Wrap(
              spacing: AppSpacing.sm,
              children: _shops.take(4).map((shop) {
                return ActionChip(
                  avatar: const Icon(Icons.location_on, size: 18),
                  label: Text(shop.name),
                  onPressed: () {
                    _selectShop(shop);
                    launchUrl(Uri.https('map.naver.com', '/v5/search/${shop.name} ${shop.address}'), mode: LaunchMode.externalApplication);
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _DistanceChip(label: '500m', isSelected: ref.watch(searchFiltersProvider).radiusMeters == 500, onTap: () => ref.read(searchFiltersProvider.notifier).updateRadius(500)),
          const SizedBox(width: AppSpacing.sm),
          _DistanceChip(label: '1km', isSelected: ref.watch(searchFiltersProvider).radiusMeters == 1000, onTap: () => ref.read(searchFiltersProvider.notifier).updateRadius(1000)),
          const SizedBox(width: AppSpacing.sm),
          _DistanceChip(label: '3km', isSelected: ref.watch(searchFiltersProvider).radiusMeters == 3000, onTap: () => ref.read(searchFiltersProvider.notifier).updateRadius(3000)),
          const SizedBox(width: AppSpacing.sm),
          _DistanceChip(label: '5km', isSelected: ref.watch(searchFiltersProvider).radiusMeters == 5000, onTap: () => ref.read(searchFiltersProvider.notifier).updateRadius(5000)),
          const SizedBox(width: AppSpacing.sm),
          _DistanceChip(label: '50km', isSelected: ref.watch(searchFiltersProvider).radiusMeters == 50000, onTap: () => ref.read(searchFiltersProvider.notifier).updateRadius(50000)),
        ],
      ),
    );
  }

  Widget _buildSelectedShopCard() {
    return GestureDetector(
      onTap: () => context.push('/shop/${_selectedShop!.id}'),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              // 가게 이미지
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 80,
                  height: 80,
                  color: AppColors.primaryLight,
                  child: _selectedShop!.primaryPhotoUrl != null
                      ? Image.network(
                          _selectedShop!.primaryPhotoUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.local_florist,
                            color: AppColors.primary,
                          ),
                        )
                      : const Icon(
                          Icons.local_florist,
                          color: AppColors.primary,
                        ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              // 가게 정보
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _selectedShop!.name,
                            style: AppTextStyles.heading3,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (_selectedShop!.isVerified)
                          const Icon(
                            Icons.verified,
                            size: 18,
                            color: AppColors.verified,
                          ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 16, color: AppColors.star),
                        const SizedBox(width: 2),
                        Text(
                          _selectedShop!.averageRating.toStringAsFixed(1),
                          style: AppTextStyles.bodyMedium,
                        ),
                        Text(
                          ' (${_selectedShop!.reviewCount})',
                          style: AppTextStyles.bodySmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      _selectedShop!.address,
                      style: AppTextStyles.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              // 닫기 버튼
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => setState(() => _selectedShop = null),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectShop(FlowerShopModel shop) {
    setState(() => _selectedShop = shop);
  }

  void _goToMyLocation() {
    ref.read(currentLocationProvider.notifier).refreshLocation();
  }
}

class _DistanceChip extends StatelessWidget {
  const _DistanceChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onTap(),
      selectedColor: AppColors.primaryLight,
      backgroundColor: AppColors.surface,
    );
  }
}
