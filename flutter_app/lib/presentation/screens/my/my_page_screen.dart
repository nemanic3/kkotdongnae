import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/mock/mock_data.dart';
import '../../../services/api_service.dart';
import '../../providers/cart_provider.dart';

/// 마이페이지 화면
class MyPageScreen extends ConsumerWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartCount = ref.watch(cartItemCountProvider);
    final user = MockData.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('마이'),
        actions: [
          // 장바구니 버튼
          Badge(
            isLabelVisible: cartCount > 0,
            label: Text('$cartCount'),
            child: IconButton(
              icon: const Icon(Icons.shopping_bag_outlined),
              onPressed: () => context.push('/cart'),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              // TODO: 설정 화면
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('설정 기능은 준비중입니다')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 프로필 섹션
            _buildProfileSection(context, user),

            const Divider(height: 1),

            // 메뉴 목록
            _buildMenuSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context, dynamic user) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Row(
        children: [
          // 프로필 이미지
          CircleAvatar(
            radius: 40,
            backgroundColor: AppColors.primaryLight,
            backgroundImage: user.avatarUrl != null
                ? NetworkImage(user.avatarUrl!)
                : null,
            child: user.avatarUrl == null
                ? const Icon(Icons.person, size: 40, color: AppColors.primary)
                : null,
          ),
          const SizedBox(width: AppSpacing.lg),
          // 사용자 정보
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.displayName ?? '사용자',
                  style: AppTextStyles.heading3,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  user.email ?? '',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          // 프로필 편집
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
              // TODO: 프로필 편집
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('프로필 편집 기능은 준비중입니다')),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    return Column(
      children: [
        _MenuItem(
          icon: Icons.receipt_long_outlined,
          title: '주문 내역',
          onTap: () {
            // 주문 내역은 찜 & 주문 탭에서 확인
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('찜 & 주문 탭에서 확인할 수 있습니다')),
            );
          },
        ),
        _MenuItem(
          icon: Icons.star_outline,
          title: '내 리뷰',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('내 리뷰 기능은 준비중입니다')),
            );
          },
        ),
        _MenuItem(
          icon: Icons.notifications_outlined,
          title: '알림 설정',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('알림 설정 기능은 준비중입니다')),
            );
          },
        ),
        const Divider(height: 1),
        _MenuItem(
          icon: Icons.cloud_sync_outlined,
          title: '백엔드 서버 연결 테스트',
          subtitle: 'GET /api/shops/ (HTTP 200 확인)',
          onTap: () => _showBackendTestDialog(context),
        ),
        const Divider(height: 1),
        _MenuItem(
          icon: Icons.help_outline,
          title: '고객센터',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('고객센터 기능은 준비중입니다')),
            );
          },
        ),
        _MenuItem(
          icon: Icons.info_outline,
          title: '앱 정보',
          subtitle: '버전 1.0.0',
          onTap: () {
            showAboutDialog(
              context: context,
              applicationName: '꽃동네',
              applicationVersion: '1.0.0',
              applicationIcon: const Icon(
                Icons.local_florist,
                size: 48,
                color: AppColors.primary,
              ),
            );
          },
        ),
        _MenuItem(
          icon: Icons.description_outlined,
          title: '이용약관',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('이용약관 페이지는 준비중입니다')),
            );
          },
        ),
        _MenuItem(
          icon: Icons.privacy_tip_outlined,
          title: '개인정보처리방침',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('개인정보처리방침 페이지는 준비중입니다')),
            );
          },
        ),
        const Divider(height: 1),
        _MenuItem(
          icon: Icons.logout,
          title: '로그아웃',
          textColor: AppColors.error,
          onTap: () {
            _showLogoutDialog(context);
          },
        ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('로그아웃'),
        content: const Text('로그아웃 하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: 로그아웃 처리
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('로그아웃되었습니다')),
              );
            },
            child: Text('로그아웃', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }

  void _showBackendTestDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogCtx) {
        ConnectionTestResult? result;
        bool isLoading = true;

        return StatefulBuilder(
          builder: (context, setDialogState) {
            void runTest() async {
              setDialogState(() => isLoading = true);
              final res = await ApiService.testShopsConnection();
              if (dialogCtx.mounted) {
                setDialogState(() {
                  result = res;
                  isLoading = false;
                });
              }
            }

            // 첫 다이얼로그 표시 시 자동 실행
            if (isLoading && result == null) {
              WidgetsBinding.instance.addPostFrameCallback((_) => runTest());
            }

            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: const Row(
                children: [
                  Icon(Icons.dns_rounded, color: AppColors.primary),
                  SizedBox(width: 8),
                  Text('백엔드 연결 테스트', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Base URL', style: TextStyle(fontSize: 11, color: Colors.grey)),
                          Text(AppConstants.backendBaseUrl, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                          SizedBox(height: 6),
                          Text('Target Endpoint', style: TextStyle(fontSize: 11, color: Colors.grey)),
                          Text('/api/shops/', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (isLoading)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 24),
                          child: Column(
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: 12),
                              Text('서버로 GET 요청 전송 중...', style: TextStyle(fontSize: 13, color: Colors.grey)),
                            ],
                          ),
                        ),
                      )
                    else if (result != null) ...[
                      Row(
                        children: [
                          Icon(
                            result!.success ? Icons.check_circle : Icons.error,
                            color: result!.success ? Colors.green : Colors.red,
                            size: 28,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  result!.success ? 'HTTP 200 OK - 성공!' : '요청 실패 (${result!.statusCode})',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: result!.success ? Colors.green.shade700 : Colors.red.shade700,
                                  ),
                                ),
                                Text(
                                  '응답 속도: ${result!.latency.inMilliseconds}ms | 데이터: ${result!.shopCount}개',
                                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        width: double.infinity,
                        constraints: const BoxConstraints(maxHeight: 120),
                        child: SingleChildScrollView(
                          child: Text(
                            'Response Data:\n${result!.rawData?.toString() ?? "없음"}',
                            style: const TextStyle(fontSize: 11, fontFamily: 'monospace'),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              actions: [
                if (!isLoading)
                  TextButton.icon(
                    onPressed: runTest,
                    icon: const Icon(Icons.refresh, size: 18),
                    label: const Text('다시 테스트'),
                  ),
                FilledButton(
                  onPressed: () => Navigator.pop(dialogCtx),
                  child: const Text('닫기'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.icon,
    required this.title,
    this.subtitle,
    this.textColor,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Color? textColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: textColor ?? AppColors.textPrimary),
      title: Text(
        title,
        style: AppTextStyles.bodyLarge.copyWith(
          color: textColor,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: AppTextStyles.bodySmall,
            )
          : null,
      trailing: const Icon(Icons.chevron_right, color: AppColors.textHint),
      onTap: onTap,
    );
  }
}
