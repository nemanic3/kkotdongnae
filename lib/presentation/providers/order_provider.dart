import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/models.dart';
import '../../data/mock/mock_service.dart';

/// 주문 목록 Provider
final ordersProvider =
    StateNotifierProvider<OrdersNotifier, AsyncValue<List<OrderModel>>>((ref) {
  return OrdersNotifier();
});

/// 주문 상세 Provider
final orderDetailProvider =
    FutureProvider.family<OrderModel?, String>((ref, orderId) async {
  return MockService.getOrderById(orderId);
});

/// 주문 목록 상태 관리 Notifier
class OrdersNotifier extends StateNotifier<AsyncValue<List<OrderModel>>> {
  OrdersNotifier() : super(const AsyncValue.loading()) {
    loadInitial();
  }

  int _currentPage = 0;
  bool _hasMore = true;
  final List<OrderModel> _allOrders = [];

  /// 초기 로드
  Future<void> loadInitial() async {
    state = const AsyncValue.loading();
    _currentPage = 0;
    _hasMore = true;
    _allOrders.clear();

    try {
      final orders = await MockService.getOrders(
        page: 0,
        pageSize: 10,
      );
      _allOrders.addAll(orders);
      _hasMore = orders.length >= 10;
      state = AsyncValue.data(List.from(_allOrders));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// 추가 로드 (페이지네이션)
  Future<void> loadMore() async {
    if (!_hasMore || state.isLoading) return;

    try {
      _currentPage++;
      final orders = await MockService.getOrders(
        page: _currentPage,
        pageSize: 10,
      );
      _allOrders.addAll(orders);
      _hasMore = orders.length >= 10;
      state = AsyncValue.data(List.from(_allOrders));
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
