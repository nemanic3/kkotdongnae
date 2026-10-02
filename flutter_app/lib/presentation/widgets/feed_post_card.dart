import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/models.dart';

/// 피드 게시글 카드 위젯
class FeedPostCard extends StatelessWidget {
  const FeedPostCard({
    super.key,
    required this.post,
  });

  final FeedPostModel post;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 가게 정보 헤더
          _buildShopHeader(context),

          // 이미지
          if (post.images.isNotEmpty) _buildImages(),

          // 게시글 내용
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 제목
                Text(
                  post.title,
                  style: AppTextStyles.heading3,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (post.content != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    post.content!,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                const SizedBox(height: AppSpacing.md),
                // 인터랙션 바
                _buildInteractionBar(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShopHeader(BuildContext context) {
    return InkWell(
      onTap: () {
        if (post.shop != null) {
          context.push('/shop/${post.shop!.id}');
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            // 가게 이미지
            CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.primaryLight,
              backgroundImage: post.shop?.primaryPhotoUrl != null
                  ? CachedNetworkImageProvider(post.shop!.primaryPhotoUrl!)
                  : null,
              child: post.shop?.primaryPhotoUrl == null
                  ? const Icon(Icons.local_florist, color: AppColors.primary, size: 20)
                  : null,
            ),
            const SizedBox(width: AppSpacing.sm),
            // 가게 이름 & 시간
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          post.shop?.name ?? '꽃집',
                          style: AppTextStyles.bodyLarge.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (post.shop?.isVerified == true) ...[
                        const SizedBox(width: 4),
                        const Icon(Icons.verified, size: 16, color: AppColors.verified),
                      ],
                    ],
                  ),
                  Text(
                    _formatTime(post.createdAt),
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            ),
            // 게시글 타입 배지
            if (post.postType != 'normal') _buildTypeBadge(),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeBadge() {
    String label;
    Color color;

    switch (post.postType) {
      case 'event':
        label = '이벤트';
        color = AppColors.accent;
        break;
      case 'new_arrival':
        label = '신상품';
        color = AppColors.primary;
        break;
      case 'promotion':
        label = '프로모션';
        color = AppColors.secondary;
        break;
      default:
        return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
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

  Widget _buildImages() {
    if (post.images.length == 1) {
      return AspectRatio(
        aspectRatio: 1,
        child: CachedNetworkImage(
          imageUrl: post.images.first,
          fit: BoxFit.cover,
          placeholder: (_, __) => Container(
            color: AppColors.primaryLight,
            child: const Center(child: CircularProgressIndicator()),
          ),
          errorWidget: (_, __, ___) => Container(
            color: AppColors.primaryLight,
            child: const Icon(Icons.image_not_supported, color: AppColors.textHint),
          ),
        ),
      );
    }

    return AspectRatio(
      aspectRatio: 1.5,
      child: PageView.builder(
        itemCount: post.images.length,
        itemBuilder: (context, index) {
          return CachedNetworkImage(
            imageUrl: post.images[index],
            fit: BoxFit.cover,
            placeholder: (_, __) => Container(
              color: AppColors.primaryLight,
              child: const Center(child: CircularProgressIndicator()),
            ),
            errorWidget: (_, __, ___) => Container(
              color: AppColors.primaryLight,
              child: const Icon(Icons.image_not_supported, color: AppColors.textHint),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInteractionBar() {
    return Row(
      children: [
        // 좋아요
        _InteractionButton(
          icon: post.isLiked ? Icons.favorite : Icons.favorite_border,
          iconColor: post.isLiked ? Colors.red : null,
          count: post.likeCount,
          onTap: () {},
        ),
        const SizedBox(width: AppSpacing.lg),
        // 댓글
        _InteractionButton(
          icon: Icons.chat_bubble_outline,
          count: post.commentCount,
          onTap: () {},
        ),
        const Spacer(),
        // 조회수
        Row(
          children: [
            const Icon(Icons.visibility_outlined, size: 16, color: AppColors.textHint),
            const SizedBox(width: 4),
            Text(
              '${post.viewCount}',
              style: AppTextStyles.caption,
            ),
          ],
        ),
      ],
    );
  }

  String _formatTime(DateTime? time) {
    if (time == null) return '';

    final now = DateTime.now();
    final diff = now.difference(time);

    if (diff.inMinutes < 60) {
      return '${diff.inMinutes}분 전';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}시간 전';
    } else if (diff.inDays < 7) {
      return '${diff.inDays}일 전';
    } else {
      return '${time.month}/${time.day}';
    }
  }
}

class _InteractionButton extends StatelessWidget {
  const _InteractionButton({
    required this.icon,
    this.iconColor,
    required this.count,
    required this.onTap,
  });

  final IconData icon;
  final Color? iconColor;
  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          children: [
            Icon(icon, size: 20, color: iconColor ?? AppColors.textSecondary),
            const SizedBox(width: 4),
            Text(
              '$count',
              style: AppTextStyles.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
