import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/models.dart';
import '../../data/mock/mock_service.dart';

/// 피드 필터 Provider
final feedFilterProvider = StateProvider<FeedFilter>((ref) => FeedFilter.all);

/// 피드 목록 Provider
final feedPostsProvider =
    StateNotifierProvider<FeedNotifier, AsyncValue<List<FeedPostModel>>>((ref) {
  return FeedNotifier(ref);
});

/// 피드 상태 관리 Notifier
class FeedNotifier extends StateNotifier<AsyncValue<List<FeedPostModel>>> {
  FeedNotifier(this.ref) : super(const AsyncValue.loading()) {
    loadInitial();
  }

  final Ref ref;
  int _currentPage = 0;
  bool _hasMore = true;
  final List<FeedPostModel> _allPosts = [];

  /// 초기 로드
  Future<void> loadInitial() async {
    state = const AsyncValue.loading();
    _currentPage = 0;
    _hasMore = true;
    _allPosts.clear();

    try {
      final filter = ref.read(feedFilterProvider);
      final posts = await MockService.getFeedPosts(
        filter: filter,
        page: 0,
        pageSize: 10,
      );
      _allPosts.addAll(posts);
      _hasMore = posts.length >= 10;
      state = AsyncValue.data(List.from(_allPosts));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// 추가 로드 (페이지네이션)
  Future<void> loadMore() async {
    if (!_hasMore || state.isLoading) return;

    try {
      _currentPage++;
      final filter = ref.read(feedFilterProvider);
      final posts = await MockService.getFeedPosts(
        filter: filter,
        page: _currentPage,
        pageSize: 10,
      );
      _allPosts.addAll(posts);
      _hasMore = posts.length >= 10;
      state = AsyncValue.data(List.from(_allPosts));
    } catch (e, st) {
      _currentPage--;
      state = AsyncValue.error(e, st);
    }
  }

  /// 새로고침
  Future<void> refresh() async {
    await loadInitial();
  }

  bool get hasMore => _hasMore;
}

/// 피드 필터 변경 시 자동 새로고침
final feedFilterListenerProvider = Provider<void>((ref) {
  ref.listen<FeedFilter>(feedFilterProvider, (previous, next) {
    if (previous != next) {
      ref.read(feedPostsProvider.notifier).loadInitial();
    }
  });
  return;
});
