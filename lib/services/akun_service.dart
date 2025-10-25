import 'package:flutter/foundation.dart';
import 'api_service.dart'; // Import ApiService
import 'package:dio/dio.dart';

class AkunService {
  final ApiService _apiService; // Use ApiService

  AkunService(this._apiService); // Inject ApiService

  // Get user account information
  Future<Map<String, dynamic>> getAkunInfo() async {
    try {
      final response = await _apiService.dio.get(
        '/akun',
      );

      debugPrint('Response from /akun: ${response.data}');
      return response.data;
    } catch (e) {
      if (e is DioException) {
        debugPrint('************************');
        debugPrint('DioException Details (/akun):');
        debugPrint('Request Method: ${e.requestOptions.method}');
        debugPrint('Request URL: ${e.requestOptions.uri}');
        debugPrint('Request Headers: ${e.requestOptions.headers}');
        if (e.response != null) {
          debugPrint('---');
          debugPrint('Response Status: ${e.response?.statusCode}');
          debugPrint('Response Headers: ${e.response?.headers}');
          debugPrint('Response Data: ${e.response?.data}');
        }
        debugPrint('************************');
      }
      debugPrint('Error getting account information: $e');
      rethrow;
    }
  }

  // Change user password
  Future<void> changePassword(String oldPassword, String newPassword) async {
    try {
      final response = await _apiService.dio.post( // Use ApiService.dio
        '/gantipw',
        data: {
          'current_password': oldPassword,
          'new_password': newPassword,
          'new_password_confirmation': newPassword,
        },
      );

      if (response.data['success'] != true && response.data['message'] != 'password berhasil diubah') {
        debugPrint('API Response (Error but message is success): ${response.data}');
        throw Exception(response.data['message'] ?? 'Gagal mengubah kata sandi.');
      }
    } catch (e) {
      debugPrint('Error changing password: $e');
      rethrow;
    }
  }
}
