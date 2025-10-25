import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'auth_service.dart';
import '../models/appconfig.dart';

class AkunService {
  final AppConfig appConfig;
  final AuthService authService;

  AkunService(this.appConfig, this.authService);

  // Get user account information
  Future<Map<String, dynamic>> getAkunInfo() async {
    try {
      final headers = await authService.getAuthHeaders();
      final response = await http.get(
        Uri.parse('${appConfig.baseUrl}/akun'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        return result;
      }
      throw Exception('Failed to get account information');
    } catch (e) {
      debugPrint('Error getting account information: $e');
      rethrow;
    }
  }

  // Change user password
  Future<void> changePassword(String oldPassword, String newPassword) async {
    try {
      final headers = await authService.getAuthHeaders();
      final response = await http.post(
        Uri.parse('${appConfig.baseUrl}/gantipw'),
        headers: headers,
        body: jsonEncode({
          'current_password': oldPassword,
          'new_password': newPassword,
          'new_password_confirmation': newPassword,
        }),
      );

      if (response.statusCode != 200) {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['message'] ?? 'Failed to change password');
      }
    } catch (e) {
      debugPrint('Error changing password: $e');
      rethrow;
    }
  }
}
