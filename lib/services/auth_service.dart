import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'api_service.dart'; // Import ApiService

class AuthService {
  final ApiService _apiService; // Use ApiService
  final _storage = const FlutterSecureStorage();
  String? _token;

  AuthService(this._apiService); // Inject ApiService

  // Getter for the authentication token
  String? get token => _token;

  // Login with NISN and password
  Future<void> login(String username, String password, {String? deviceName}) async {
    try {
      final response = await _apiService.dio.post(
        '/auth/login',
        data: {
          'username': username,
          'password': password,
          if (deviceName != null) 'device_name': deviceName,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        debugPrint('Response Data (200 OK): $data');
        if (data['status'] == 'success') {
          _token = data['access_token'];
          await _storage.write(key: 'auth_token', value: _token);
          return;
        }
      }
      throw Exception(response.data['message'] ?? 'Login failed. Please check your credentials.');
    } catch (e) {
      if (e is DioException) {
        debugPrint('************************');
        debugPrint('DioException Details:');
        debugPrint('Request Method: ${e.requestOptions.method}');
        debugPrint('Request URL: ${e.requestOptions.uri}');
        debugPrint('Request Headers: ${e.requestOptions.headers}');
        debugPrint('Request Data: ${e.requestOptions.data}');
        if (e.response != null) {
          debugPrint('---');
          debugPrint('Response Status: ${e.response?.statusCode}');
          debugPrint('Response Headers: ${e.response?.headers}');
          debugPrint('Response Data: ${e.response?.data}');
        }
        debugPrint('************************');
      }
      debugPrint('Login error: $e');
      rethrow;
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      final token = await _storage.read(key: 'auth_token');
      if (token != null) {
        await _apiService.dio.post( // Use ApiService.dio
          '/auth/logout', // Relative path
        );
      }
    } catch (e) {
      debugPrint('Logout error: $e');
    } finally {
      await _storage.delete(key: 'auth_token');
      _token = null;
    }
  }

  // Get auth token
  Future<String?> getToken() async {
    _token ??= await _storage.read(key: 'auth_token');
    return _token;
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}
