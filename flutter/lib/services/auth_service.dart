import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  static const String _baseUrl = 'http://127.0.0.1:8000/api';
  static const _storage = FlutterSecureStorage();
  static String? _token;

  // Getter for the authentication token
  static String? get token => _token;

  // Login with NISN and password
  static Future<Map<String, dynamic>> login(String nisn, String password, {String? deviceName}) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nisn': nisn,
          'password': password,
          if (deviceName != null) 'device_name': deviceName,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          _token = data['access_token'];
          await _storage.write(key: 'auth_token', value: _token);
          return {'success': true};
        }
      }
      return {'success': false, 'message': 'Login failed. Please check your credentials.'};
    } catch (e) {
      debugPrint('Login error: $e');
      return {'success': false, 'message': 'Connection error. Please try again.'};
    }
  }

  // Logout
  static Future<void> logout() async {
    try {
      final token = await _storage.read(key: 'auth_token');
      if (token != null) {
        await http.post(
          Uri.parse('$_baseUrl/auth/logout'),
          headers: _authHeader(token),
        );
      }
    } catch (e) {
      debugPrint('Logout error: $e');
    } finally {
      await _storage.delete(key: 'auth_token');
      _token = null;
    }
  }

  // Get auth headers
  static Map<String, String> _authHeader(String token) => {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Get auth token
  static Future<String?> getToken() async {
    _token ??= await _storage.read(key: 'auth_token');
    return _token;
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // Get auth headers for API calls
  static Future<Map<String, String>> getAuthHeaders() async {
    final token = await getToken();
    return _authHeader(token ?? '');
  }
}
