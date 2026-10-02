import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../core/constants/app_constants.dart';
import '../core/network/api_client.dart';
import '../core/network/token_storage.dart';

/// 서버 연결 테스트 결과 모델
class ConnectionTestResult {
  final bool success;
  final int statusCode;
  final String message;
  final Duration latency;
  final int shopCount;
  final dynamic rawData;

  const ConnectionTestResult({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.latency,
    required this.shopCount,
    this.rawData,
  });
}

class ApiService {
  ApiService._();

  static ApiClient get _client => ApiClient.instance;

  static const String baseUrl = AppConstants.apiBaseUrl;

  /// 수동 토큰 설정 (레거시 호환용)
  static void setToken(String token) {
    TokenStorage.saveAccessToken(token);
  }

  /// 데모 / 실제 로그인 (JWT 발급 및 SecureStorage 저장)
  static Future<bool> login(String email, String password) async {
    try {
      final response = await _client.post(
        '/api/auth/login/',
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;
        final access = data['access'] as String?;
        final refresh = data['refresh'] as String?;

        if (access != null) {
          await TokenStorage.saveTokens(access: access, refresh: refresh);
          return true;
        }
      }
      return false;
    } catch (e) {
      debugPrint('ApiService.login error: $e');
      return false;
    }
  }

  /// 로그아웃 (토큰 정리)
  static Future<void> logout() async {
    try {
      final refreshToken = await TokenStorage.getRefreshToken();
      if (refreshToken != null) {
        await _client.post(
          '/api/auth/logout/',
          data: {'refresh': refreshToken},
        );
      }
    } catch (e) {
      debugPrint('ApiService.logout server error: $e');
    } finally {
      await TokenStorage.clearTokens();
    }
  }

  /// 꽃집 목록 조회 (/api/shops/)
  static Future<List<Map<String, dynamic>>> getShops() async {
    try {
      final response = await _client.get('/api/shops/');

      if (response.statusCode == 200 && response.data is List) {
        final List<dynamic> list = response.data;
        return list.map((item) => Map<String, dynamic>.from(item as Map)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('ApiService.getShops error: $e');
      return [];
    }
  }

  /// 백엔드 연결 상태 테스트 (/api/shops/ GET 요청)
  static Future<ConnectionTestResult> testShopsConnection() async {
    final stopwatch = Stopwatch()..start();
    try {
      final response = await _client.get('/api/shops/');
      stopwatch.stop();

      final statusCode = response.statusCode ?? 0;
      final isSuccess = statusCode == 200;
      int count = 0;

      if (response.data is List) {
        count = (response.data as List).length;
      }

      return ConnectionTestResult(
        success: isSuccess,
        statusCode: statusCode,
        message: isSuccess ? '연결 성공 (HTTP 200 OK)' : '응답 코드: $statusCode',
        latency: stopwatch.elapsed,
        shopCount: count,
        rawData: response.data,
      );
    } on DioException catch (dioErr) {
      stopwatch.stop();
      final statusCode = dioErr.response?.statusCode ?? 0;
      return ConnectionTestResult(
        success: false,
        statusCode: statusCode,
        message: 'DioException: ${dioErr.message}',
        latency: stopwatch.elapsed,
        shopCount: 0,
        rawData: dioErr.response?.data,
      );
    } catch (e) {
      stopwatch.stop();
      return ConnectionTestResult(
        success: false,
        statusCode: 0,
        message: '예외 발생: $e',
        latency: stopwatch.elapsed,
        shopCount: 0,
      );
    }
  }
}