import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/models.dart';
import '../../services/supabase_service.dart';

// Shop reviews provider
final shopReviewsProvider = StateNotifierProvider.family<ShopReviewsNotifier,
    AsyncValue<List<ReviewModel>>, String>((ref, shopId) {
  return ShopReviewsNotifier(shopId);
});

class ShopReviewsNotifier extends StateNotifier<AsyncValue<List<ReviewModel>>> {
  final String shopId;
  int _currentPage = 0;
  bool _hasMore = true;
  List<ReviewModel> _allReviews = [];

  ShopReviewsNotifier(this.shopId) : super(const AsyncValue.loading()) {
    _loadReviews();
  }

  Future<void> _loadReviews() async {
    try {
      _currentPage = 0;
      _hasMore = true;
      _allReviews = [];

      final reviews = await ReviewService.getShopReviews(
        shopId,
        pageSize: 10,
        offset: 0,
      );

      _allReviews = reviews;
      _hasMore = reviews.length >= 10;
      state = AsyncValue.data(reviews);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    await _loadReviews();
  }

  Future<void> loadMore() async {
    if (!_hasMore) return;

    try {
      _currentPage++;
      final reviews = await ReviewService.getShopReviews(
        shopId,
        pageSize: 10,
        offset: _currentPage * 10,
      );

      _hasMore = reviews.length >= 10;
      _allReviews = [..._allReviews, ...reviews];
      state = AsyncValue.data(_allReviews);
    } catch (e) {
      _currentPage--;
    }
  }

  bool get hasMore => _hasMore;
}

// User's own reviews
final userReviewsProvider =
    FutureProvider<List<ReviewModel>>((ref) async {
  return await ReviewService.getUserReviews();
});

// Create review state
class CreateReviewState {
  final bool isLoading;
  final String? error;
  final ReviewModel? result;

  const CreateReviewState({
    this.isLoading = false,
    this.error,
    this.result,
  });

  CreateReviewState copyWith({
    bool? isLoading,
    String? error,
    ReviewModel? result,
  }) {
    return CreateReviewState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      result: result ?? this.result,
    );
  }
}

final createReviewProvider =
    StateNotifierProvider<CreateReviewNotifier, CreateReviewState>((ref) {
  return CreateReviewNotifier(ref);
});

class CreateReviewNotifier extends StateNotifier<CreateReviewState> {
  final Ref ref;

  CreateReviewNotifier(this.ref) : super(const CreateReviewState());

  Future<bool> createReview(CreateReviewRequest request) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final review = await ReviewService.createReview(request);
      state = state.copyWith(isLoading: false, result: review);

      // Refresh the shop's reviews
      ref.invalidate(shopReviewsProvider(request.shopId));

      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  void reset() {
    state = const CreateReviewState();
  }
}
