// App-wide constants for KkotDongnae

class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = '꽃동네';
  static const String appNameEn = 'KkotDongnae';

  // Backend API Configuration
  static const String backendBaseUrl = String.fromEnvironment(
    'API_ORIGIN', defaultValue: 'https://kkotdongnae.nemanic.dev');
  static const String apiBaseUrl = '$backendBaseUrl/api';

  // Supabase Configuration
  // Replace with your actual Supabase credentials
  // lib/core/constants/app_constants.dart

  // Location Settings
  static const double defaultLatitude = 37.5665; // Seoul
  static const double defaultLongitude = 126.9780;
  static const int defaultSearchRadius = 5000; // 5km in meters
  static const int maxSearchRadius = 50000; // 50km
  static const int minSearchRadius = 500; // 500m

  // Pagination
  static const int defaultPageSize = 20;
  static const int reviewPageSize = 10;

  // Map Settings
  static const double defaultMapZoom = 14.0;
  static const double minMapZoom = 10.0;
  static const double maxMapZoom = 18.0;

  // Cache Settings
  static const Duration cacheExpiration = Duration(hours: 1);
  static const Duration locationRefreshInterval = Duration(minutes: 5);

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 350);
  static const Duration longAnimation = Duration(milliseconds: 500);

  // Image Settings
  static const int maxImageSize = 1024;
  static const int thumbnailSize = 200;
  static const int maxPhotosPerReview = 5;

  // Validation
  static const int minReviewLength = 10;
  static const int maxReviewLength = 1000;
  static const int minPasswordLength = 8;
}

class HiveBoxes {
  HiveBoxes._();

  static const String settings = 'settings';
  static const String searchHistory = 'search_history';
  static const String cachedShops = 'cached_shops';
}

class StorageKeys {
  StorageKeys._();

  static const String accessToken = 'jwt_access_token';
  static const String refreshToken = 'jwt_refresh_token';
  static const String onboardingCompleted = 'onboarding_completed';
  static const String lastLocation = 'last_location';
  static const String searchRadius = 'search_radius';
  static const String sortPreference = 'sort_preference';
}
