import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:kkotdongnae/core/constants/app_constants.dart';
import 'package:kkotdongnae/core/network/api_client.dart';
import 'package:kkotdongnae/services/api_service.dart';

class _AllowAllHttpOverrides extends HttpOverrides {}

void main() {
  HttpOverrides.global = _AllowAllHttpOverrides();

  group('Django Backend API Connection Tests', () {
    test('Base URL should match the designated backend server', () {
      expect(AppConstants.backendBaseUrl, equals('http://3.25.235.50:8000'));
      expect(AppConstants.apiBaseUrl, equals('http://3.25.235.50:8000/api'));
      expect(ApiClient.instance.dio.options.baseUrl, equals('http://3.25.235.50:8000'));
    });

    test('GET /api/shops/ should return HTTP 200 OK', () async {
      final result = await ApiService.testShopsConnection();

      // ignore: avoid_print
      print('Status Code: ${result.statusCode}');
      // ignore: avoid_print
      print('Latency: ${result.latency.inMilliseconds}ms');
      // ignore: avoid_print
      print('Shops Count: ${result.shopCount}');
      // ignore: avoid_print
      print('Raw Data: ${result.rawData}');

      expect(result.success, isTrue, reason: 'Failed with message: ${result.message}');
      expect(result.statusCode, equals(200));
      expect(result.rawData, isA<List>());
    });
  });
}
