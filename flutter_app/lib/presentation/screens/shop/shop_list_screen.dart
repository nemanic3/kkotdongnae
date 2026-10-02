import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/location_model.dart';
import '../../providers/location_provider.dart';
import '../../providers/shop_provider.dart';
import '../../widgets/shop_card.dart';

class ShopListScreen extends ConsumerStatefulWidget {
  const ShopListScreen({super.key});

  @override
  ConsumerState<ShopListScreen> createState() => _ShopListScreenState();
}

class _ShopListScreenState extends ConsumerState<ShopListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(nearbyShopsProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final shopsAsync = ref.watch(nearbyShopsProvider);
    final filters = ref.watch(searchFiltersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('주변 꽃집'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.push('/search'),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterSheet(context),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(currentLocationProvider.notifier).refreshLocation();
          await ref.read(nearbyShopsProvider.notifier).refresh();
        },
        child: shopsAsync.when(
          data: (shops) {
            if (shops.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.local_florist_outlined,
                      size: 64,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      '주변에 꽃집이 없습니다',
                      style: AppTextStyles.bodyLarge,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      '검색 반경을 늘려보세요',
                      style: AppTextStyles.bodySmall,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    OutlinedButton(
                      onPressed: () {
                        ref
                            .read(searchFiltersProvider.notifier)
                            .updateRadius(10000);
                      },
                      child: const Text('반경 10km로 검색'),
                    ),
                  ],
                ),
              );
            }

            return ListView.separated(
              controller: _scrollController,
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: shops.length + 1,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: AppSpacing.md),
              itemBuilder: (context, index) {
                if (index == shops.length) {
                  return ref.read(nearbyShopsProvider.notifier).hasMore
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(AppSpacing.md),
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : const SizedBox.shrink();
                }

                final shop = shops[index];
                return ShopCard(
                  shop: shop,
                  onTap: () => context.push('/shop/${shop.id}'),
                );
              },
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, _) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: AppColors.error,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  '데이터를 불러올 수 없습니다',
                  style: AppTextStyles.bodyLarge,
                ),
                const SizedBox(height: AppSpacing.md),
                ElevatedButton(
                  onPressed: () {
                    ref.read(nearbyShopsProvider.notifier).refresh();
                  },
                  child: const Text('다시 시도'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const _FilterBottomSheet(),
    );
  }
}

class _FilterBottomSheet extends ConsumerWidget {
  const _FilterBottomSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(searchFiltersProvider);
    final categoriesAsync = ref.watch(categoriesProvider);

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) => SingleChildScrollView(
        controller: scrollController,
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.divider,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('필터', style: AppTextStyles.heading3),
                TextButton(
                  onPressed: () {
                    ref.read(searchFiltersProvider.notifier).reset();
                  },
                  child: const Text('초기화'),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),

            // Distance
            Text('검색 반경', style: AppTextStyles.bodyLarge),
            const SizedBox(height: AppSpacing.sm),
            Slider(
              value: filters.radiusMeters.toDouble(),
              min: 500,
              max: 20000,
              divisions: 39,
              label: _formatRadius(filters.radiusMeters),
              onChanged: (value) {
                ref
                    .read(searchFiltersProvider.notifier)
                    .updateRadius(value.toInt());
              },
            ),
            Center(
              child: Text(
                _formatRadius(filters.radiusMeters),
                style: AppTextStyles.bodyMedium,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Sort by
            Text('정렬', style: AppTextStyles.bodyLarge),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              children: SortOption.values.map((option) {
                return ChoiceChip(
                  label: Text(_getSortLabel(option)),
                  selected: filters.sortBy == option,
                  onSelected: (_) {
                    ref
                        .read(searchFiltersProvider.notifier)
                        .updateSortBy(option);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Categories
            Text('카테고리', style: AppTextStyles.bodyLarge),
            const SizedBox(height: AppSpacing.sm),
            categoriesAsync.maybeWhen(
              data: (categories) => Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: categories.map((category) {
                  return FilterChip(
                    label: Text(category.nameKo),
                    selected: filters.categoryId == category.id,
                    onSelected: (_) {
                      ref.read(searchFiltersProvider.notifier).updateCategory(
                            filters.categoryId == category.id
                                ? null
                                : category.id,
                          );
                    },
                  );
                }).toList(),
              ),
              orElse: () => const CircularProgressIndicator(),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Minimum rating
            Text('최소 평점', style: AppTextStyles.bodyLarge),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: List.generate(5, (index) {
                final rating = index + 1;
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      ref
                          .read(searchFiltersProvider.notifier)
                          .updateMinRating(rating);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: filters.minRating >= rating
                            ? AppColors.star.withOpacity(0.2)
                            : null,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            filters.minRating >= rating
                                ? Icons.star
                                : Icons.star_border,
                            color: AppColors.star,
                          ),
                          Text('$rating'),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Apply button
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('적용'),
            ),
          ],
        ),
      ),
    );
  }

  String _formatRadius(int meters) {
    if (meters < 1000) return '${meters}m';
    return '${(meters / 1000).toStringAsFixed(1)}km';
  }

  String _getSortLabel(SortOption option) {
    switch (option) {
      case SortOption.distance:
        return '거리순';
      case SortOption.rating:
        return '평점순';
      case SortOption.reviewCount:
        return '리뷰 많은순';
      case SortOption.newest:
        return '최신순';
    }
  }
}
