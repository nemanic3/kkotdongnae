import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';
import '../../presentation/screens/onboarding/onboarding_screen.dart';
import '../../presentation/screens/auth/login_screen.dart';
import '../../presentation/screens/auth/signup_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/shop/shop_detail_screen.dart';
import '../../presentation/screens/search/search_screen.dart';
import '../../presentation/screens/review/write_review_screen.dart';
import '../../presentation/screens/cart/cart_screen.dart';
import '../../presentation/screens/chat/chat_detail_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    redirect: (context, state) async {
      final prefs = await SharedPreferences.getInstance();
      final hasCompletedOnboarding =
          prefs.getBool(StorageKeys.onboardingCompleted) ?? false;

      // If going to root, redirect based on onboarding status
      if (state.matchedLocation == '/') {
        return hasCompletedOnboarding ? '/home' : '/onboarding';
      }

      return null;
    },
    routes: [
      // Onboarding
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),

      // Auth routes
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) => const SignupScreen(),
      ),

      // Main app with bottom navigation
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),

      // Shop detail
      GoRoute(
        path: '/shop/:shopId',
        name: 'shopDetail',
        builder: (context, state) {
          final shopId = state.pathParameters['shopId']!;
          return ShopDetailScreen(shopId: shopId);
        },
        routes: [
          // Write review for shop
          GoRoute(
            path: 'write-review',
            name: 'writeReview',
            builder: (context, state) {
              final shopId = state.pathParameters['shopId']!;
              return WriteReviewScreen(shopId: shopId);
            },
          ),
        ],
      ),

      // Search
      GoRoute(
        path: '/search',
        name: 'search',
        builder: (context, state) => const SearchScreen(),
      ),

      // Cart (장바구니)
      GoRoute(
        path: '/cart',
        name: 'cart',
        builder: (context, state) => const CartScreen(),
      ),

      // Chat detail (채팅 상세)
      GoRoute(
        path: '/chat/:roomId',
        name: 'chatDetail',
        builder: (context, state) {
          final roomId = state.pathParameters['roomId']!;
          return ChatDetailScreen(roomId: roomId);
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64),
            const SizedBox(height: 16),
            Text('Page not found: ${state.matchedLocation}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/home'),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
});
