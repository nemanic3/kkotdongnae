import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/review_model.dart';

class ReviewCard extends ConsumerWidget {
  final ReviewModel review;
  final bool showShopName;

  const ReviewCard({
    super.key,
    required this.review,
    this.showShopName = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User info and rating
            Row(
              children: [
                // Avatar
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.primaryLight,
                  backgroundImage: review.user?.avatarUrl != null
                      ? CachedNetworkImageProvider(review.user!.avatarUrl!)
                      : null,
                  child: review.user?.avatarUrl == null
                      ? Text(
                          review.user?.displayName?.substring(0, 1) ?? 'U',
                          style: const TextStyle(color: AppColors.primary),
                        )
                      : null,
                ),
                const SizedBox(width: AppSpacing.sm),

                // Name and date
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.user?.displayName ?? '익명',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        _formatDate(review.createdAt),
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                ),

                // Rating
                RatingBarIndicator(
                  rating: review.rating.toDouble(),
                  itemBuilder: (_, __) => const Icon(
                    Icons.star,
                    color: AppColors.star,
                  ),
                  itemCount: 5,
                  itemSize: 16,
                ),
              ],
            ),

            // Review content
            if (review.content != null && review.content!.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.md),
              Text(
                review.content!,
                style: AppTextStyles.bodyMedium,
              ),
            ],

            // Photos
            if (review.photos.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.md),
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: review.photos.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: AppSpacing.sm),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: review.photos[index],
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],

            // Helpful button
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                TextButton.icon(
                  onPressed: () {
                    // Mark as helpful
                  },
                  icon: const Icon(Icons.thumb_up_outlined, size: 16),
                  label: Text(
                    '도움이 됐어요 (${review.helpfulCount})',
                    style: AppTextStyles.bodySmall,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('yyyy.MM.dd').format(date);
  }
}
