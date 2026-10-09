import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/user_model.dart';
import '../../services/supabase_service.dart';

final currentUserProvider = Provider<UserModel?>((ref) {
  return ref.watch(authNotifierProvider).valueOrNull;
});
final userProfileProvider = FutureProvider<UserModel?>((ref) async {
  if (ref.watch(currentUserProvider) == null) return null;
  return UserService.getCurrentUserProfile();
});
class AuthNotifier extends StateNotifier<AsyncValue<UserModel?>> {
  AuthNotifier() : super(AsyncValue.data(SupabaseService.currentUser));
  Future<void> signIn({required String email, required String password}) async {
    state = const AsyncValue.loading();
    try {
      state = AsyncValue.data(await SupabaseService.signIn(email: email, password: password));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
  Future<void> signUp({required String email, required String password, String? displayName}) async {
    state = const AsyncValue.loading();
    try {
      state = AsyncValue.data(await SupabaseService.signUp(email: email, password: password, displayName: displayName));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
  Future<void> signOut() async {
    await SupabaseService.signOut();
    state = const AsyncValue.data(null);
  }
  Future<void> resetPassword(String email) => SupabaseService.resetPassword(email);
}
final authNotifierProvider = StateNotifierProvider<AuthNotifier, AsyncValue<UserModel?>>((ref) => AuthNotifier());
