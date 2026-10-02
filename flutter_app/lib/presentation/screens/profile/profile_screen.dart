import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/theme/app_theme.dart';
import '../../providers/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final profileAsync = ref.watch(userProfileProvider);

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('프로필')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.person_outline,
                size: 64,
                color: AppColors.textSecondary,
              ),
              const SizedBox(height: AppSpacing.md),
              Text('로그인이 필요합니다', style: AppTextStyles.bodyLarge),
              const SizedBox(height: AppSpacing.lg),
              ElevatedButton(
                onPressed: () => context.push('/login'),
                child: const Text('로그인'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('프로필'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: profileAsync.when(
        data: (profile) => SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            children: [
              // Profile header
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.primaryLight,
                      backgroundImage: profile?.avatarUrl != null
                          ? CachedNetworkImageProvider(profile!.avatarUrl!)
                          : null,
                      child: profile?.avatarUrl == null
                          ? const Icon(
                              Icons.person,
                              size: 50,
                              color: AppColors.primary,
                            )
                          : null,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      profile?.displayName ?? user.email ?? '사용자',
                      style: AppTextStyles.heading3,
                    ),
                    Text(
                      user.email ?? '',
                      style: AppTextStyles.bodySmall,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    OutlinedButton(
                      onPressed: () => context.push('/edit-profile'),
                      child: const Text('프로필 수정'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Menu items
              _buildMenuItem(
                icon: Icons.rate_review,
                title: '내 리뷰',
                onTap: () => context.push('/my-reviews'),
              ),
              _buildMenuItem(
                icon: Icons.favorite,
                title: '즐겨찾기',
                onTap: () {
                  // Switch to favorites tab
                },
              ),
              _buildMenuItem(
                icon: Icons.history,
                title: '최근 본 꽃집',
                onTap: () => context.push('/recent'),
              ),
              const Divider(height: AppSpacing.xl),
              _buildMenuItem(
                icon: Icons.notifications,
                title: '알림 설정',
                onTap: () => context.push('/notification-settings'),
              ),
              _buildMenuItem(
                icon: Icons.help,
                title: '도움말',
                onTap: () => context.push('/help'),
              ),
              _buildMenuItem(
                icon: Icons.info,
                title: '앱 정보',
                onTap: () => context.push('/about'),
              ),
              const Divider(height: AppSpacing.xl),
              _buildMenuItem(
                icon: Icons.logout,
                title: '로그아웃',
                color: AppColors.error,
                onTap: () => _showLogoutDialog(context, ref),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('오류: $e')),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Icon(icon, color: color ?? AppColors.textPrimary),
      title: Text(
        title,
        style: TextStyle(color: color ?? AppColors.textPrimary),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('로그아웃'),
        content: const Text('정말 로그아웃하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await ref.read(authNotifierProvider.notifier).signOut();
              if (context.mounted) {
                context.go('/login');
              }
            },
            child: const Text(
              '로그아웃',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
