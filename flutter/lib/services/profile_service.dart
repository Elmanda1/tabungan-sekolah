import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'auth_service.dart';
import '../models/appconfig.dart';

class ProfileService {
  final AppConfig appConfig;
  final AuthService authService;

  ProfileService(this.appConfig, this.authService);

  // Get user profile (read-only)
  Future<Map<String, dynamic>> getProfile() async {
    try {
      debugPrint('Getting profile from: ${appConfig.baseUrl}/profile');
      
      final token = await authService.getToken();
      if (token == null) {
        debugPrint('No auth token found in AuthService');
        throw Exception('No authentication token found');
      }

      debugPrint('Using token: $token');
      
      final url = '${appConfig.baseUrl}/profile';
      debugPrint('Making GET request to: $url');
      
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        log('Successfully parsed profile data');
        return responseData;
      } else {
        log('Failed to fetch profile. Status code: ${response.statusCode}');
        throw Exception('Failed to fetch profile');
      }
    } catch (e, stackTrace) {
      log('Profile fetch error: $e');
      log('Stack trace: $stackTrace');
      rethrow;
    }
  }
}
