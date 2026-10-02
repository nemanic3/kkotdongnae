import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/app_constants.dart';

/// JWT 토큰을 안전하게 보관 및 관리하는 스토리지 서비스
class TokenStorage {
  TokenStorage._();

  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );

  // 메모리 캐시 (빠른 동기 접근 및 웹/테스트 환경 대비)
  static String? _cachedAccessToken;
  static String? _cachedRefreshToken;

  static bool get _canUsePlatformStorage {
    try {
      WidgetsBinding.instance;
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Access Token 조회
  static Future<String?> getAccessToken() async {
    if (_cachedAccessToken != null) return _cachedAccessToken;
    if (!_canUsePlatformStorage) return null;
    try {
      _cachedAccessToken = await _storage.read(key: StorageKeys.accessToken);
      return _cachedAccessToken;
    } catch (e) {
      debugPrint('TokenStorage getAccessToken error: $e');
      return _cachedAccessToken;
    }
  }

  /// Refresh Token 조회
  static Future<String?> getRefreshToken() async {
    if (_cachedRefreshToken != null) return _cachedRefreshToken;
    if (!_canUsePlatformStorage) return null;
    try {
      _cachedRefreshToken = await _storage.read(key: StorageKeys.refreshToken);
      return _cachedRefreshToken;
    } catch (e) {
      debugPrint('TokenStorage getRefreshToken error: $e');
      return _cachedRefreshToken;
    }
  }

  /// Access/Refresh 토큰 동시 저장
  static Future<void> saveTokens({
    required String access,
    String? refresh,
  }) async {
    _cachedAccessToken = access;
    if (refresh != null) {
      _cachedRefreshToken = refresh;
    }
    if (!_canUsePlatformStorage) return;
    try {
      await _storage.write(key: StorageKeys.accessToken, value: access);
      if (refresh != null) {
        await _storage.write(key: StorageKeys.refreshToken, value: refresh);
      }
    } catch (e) {
      debugPrint('TokenStorage saveTokens error: $e');
    }
  }

  /// Access Token만 단독 갱신 저장
  static Future<void> saveAccessToken(String access) async {
    _cachedAccessToken = access;
    if (!_canUsePlatformStorage) return;
    try {
      await _storage.write(key: StorageKeys.accessToken, value: access);
    } catch (e) {
      debugPrint('TokenStorage saveAccessToken error: $e');
    }
  }

  /// 모든 인증 토큰 삭제 (로그아웃 시 호출)
  static Future<void> clearTokens() async {
    _cachedAccessToken = null;
    _cachedRefreshToken = null;
    if (!_canUsePlatformStorage) return;
    try {
      await _storage.delete(key: StorageKeys.accessToken);
      await _storage.delete(key: StorageKeys.refreshToken);
    } catch (e) {
      debugPrint('TokenStorage clearTokens error: $e');
    }
  }

  /// 현재 로그인(토큰 보유) 상태 확인
  static Future<bool> hasValidToken() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }
}
