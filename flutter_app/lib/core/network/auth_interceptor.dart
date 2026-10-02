import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../constants/app_constants.dart';
import 'token_storage.dart';

/// JWT 기반 인증 인터셉터
/// - 매 요청 헤더에 `Authorization: Bearer <access_token>` 주입
/// - 401 응답 수신 시 refresh token으로 자동 재발급 및 원래 요청 재시도
class AuthInterceptor extends QueuedInterceptor {
  final Dio dio;

  AuthInterceptor({required this.dio});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // 이미 Authorization 헤더가 설정되어 있지 않고, 인증 제외 경로가 아닐 때 토큰 주입
    final isAuthEndpoint = options.path.contains('/auth/login') ||
        options.path.contains('/auth/signup') ||
        options.path.contains('/auth/refresh');

    if (!isAuthEndpoint && !options.headers.containsKey('Authorization')) {
      final token = await TokenStorage.getAccessToken();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // 401 Unauthorized 처리 (토큰 만료)
    if (err.response?.statusCode == 401) {
      final requestPath = err.requestOptions.path;
      final isAuthEndpoint = requestPath.contains('/auth/login') ||
          requestPath.contains('/auth/refresh');

      // 로그인이나 리프레시 요청 자체의 401 에러인 경우는 루프 방지를 위해 바로 에러 반환
      if (!isAuthEndpoint) {
        final refreshToken = await TokenStorage.getRefreshToken();

        if (refreshToken != null && refreshToken.isNotEmpty) {
          try {
            // 별도의 기본 Dio로 토큰 갱신 요청 (인터셉터 순환 방지)
            final refreshDio = Dio(
              BaseOptions(
                baseUrl: AppConstants.backendBaseUrl,
                connectTimeout: const Duration(seconds: 10),
                receiveTimeout: const Duration(seconds: 10),
                headers: {'Content-Type': 'application/json'},
              ),
            );

            final response = await refreshDio.post(
              '/api/auth/refresh/',
              data: {'refresh': refreshToken},
            );

            if (response.statusCode == 200) {
              final newAccess = response.data['access'] as String;
              await TokenStorage.saveAccessToken(newAccess);

              // 원래 요청의 헤더를 새 토큰으로 업데이트 후 재시도
              final retryOptions = err.requestOptions;
              retryOptions.headers['Authorization'] = 'Bearer $newAccess';

              final retryResponse = await dio.fetch(retryOptions);
              return handler.resolve(retryResponse);
            }
          } catch (refreshErr) {
            debugPrint('Token refresh failed: $refreshErr');
            // 리프레시 토큰도 만료되었으므로 세션 정리
            await TokenStorage.clearTokens();
          }
        } else {
          // 리프레시 토큰이 없으면 토큰 정리
          await TokenStorage.clearTokens();
        }
      }
    }

    handler.next(err);
  }
}
