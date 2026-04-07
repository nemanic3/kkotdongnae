import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/models.dart';

/// 채팅방 타일 위젯
class ChatRoomTile extends StatelessWidget {
  const ChatRoomTile({
    super.key,
    required this.room,
    required this.onTap,
  });

  final ChatRoomModel room;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      leading: _buildAvatar(),
      title: _buildTitle(),
      subtitle: _buildSubtitle(),
      trailing: _buildTrailing(),
    );
  }

  Widget _buildAvatar() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: AppColors.primaryLight,
          backgroundImage: room.shop?.primaryPhotoUrl != null
              ? CachedNetworkImageProvider(room.shop!.primaryPhotoUrl!)
              : null,
          child: room.shop?.primaryPhotoUrl == null
              ? const Icon(Icons.local_florist, color: AppColors.primary)
              : null,
        ),
        // 영업중 표시
        if (room.shop?.isOpenNow == true)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTitle() {
    return Row(
      children: [
        Flexible(
          child: Text(
            room.shop?.name ?? '꽃집',
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: room.unreadCount > 0 ? FontWeight.bold : FontWeight.normal,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (room.shop?.isVerified == true) ...[
          const SizedBox(width: 4),
          const Icon(Icons.verified, size: 16, color: AppColors.verified),
        ],
      ],
    );
  }

  Widget _buildSubtitle() {
    return Text(
      room.lastMessage ?? '',
      style: AppTextStyles.bodyMedium.copyWith(
        color: room.unreadCount > 0
            ? AppColors.textPrimary
            : AppColors.textSecondary,
        fontWeight: room.unreadCount > 0 ? FontWeight.w500 : FontWeight.normal,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildTrailing() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // 시간
        Text(
          _formatTime(room.lastMessageAt),
          style: AppTextStyles.caption.copyWith(
            color: room.unreadCount > 0 ? AppColors.primary : AppColors.textHint,
          ),
        ),
        const SizedBox(height: 4),
        // 읽지 않은 메시지 수
        if (room.unreadCount > 0)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              room.unreadCount > 99 ? '99+' : '${room.unreadCount}',
              style: AppTextStyles.caption.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
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
