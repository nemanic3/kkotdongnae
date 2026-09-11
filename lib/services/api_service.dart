import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://13.239.85.58:8000/api';
  static String? _accessToken;

  static void setToken(String token) {
    _accessToken = token;
  }

  // 데모 로그인 (JWT 발급)
  static Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        _accessToken = data['access'] ?? data['token'];
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // 꽃집 목록 조회
  static Future<List<Map<String, dynamic>>> getShops() async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        if (_accessToken != null) 'Authorization': 'Bearer $_accessToken',
      };

      final response = await http.get(
        Uri.parse('$baseUrl/shops/'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
        return data.cast<Map<String, dynamic>>();
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}