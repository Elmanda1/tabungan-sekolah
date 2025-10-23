import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';
import 'auth_service.dart';

class ProfileService {
  static const String _baseUrl = 'http://10.0.2.2:8000/api';
  // Get user profile (read-only)
  static Future<Map<String, dynamic>> getProfile() async {
    try {
      debugPrint('Getting profile from: $_baseUrl/profile');
      
      if (AuthService.token == null) {
        debugPrint('No auth token found in AuthService');
        final tokenFromStorage = await const FlutterSecureStorage().read(key: 'auth_token');
        debugPrint('Token from storage: ${tokenFromStorage != null ? 'found' : 'not found'}');
        throw Exception('No authentication token found');
      }

      debugPrint('Using token: ${AuthService.token}');
      
      final url = '$_baseUrl/profile';
      debugPrint('Making GET request to: $url');
      
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AuthService.token}',
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
