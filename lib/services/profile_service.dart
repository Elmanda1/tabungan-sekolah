import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'api_service.dart'; // Import ApiService
import 'package:dio/dio.dart';

class ProfileService {
  final ApiService _apiService; // Use ApiService

  ProfileService(this._apiService); // Inject ApiService

  // Get user profile (read-only)
  Future<Map<String, dynamic>> getProfile() async {
    try {
      final response = await _apiService.dio.get(
        '/profile',
      );
      log('Response from /profile: ${response.data}');
      return response.data;
    } catch (e, stackTrace) {
      if (e is DioException) {
        log('************************');
        log('DioException Details (/profile):');
        log('Request Method: ${e.requestOptions.method}');
        log('Request URL: ${e.requestOptions.uri}');
        log('Request Headers: ${e.requestOptions.headers}');
        if (e.response != null) {
          log('---');
          log('Response Status: ${e.response?.statusCode}');
          log('Response Headers: ${e.response?.headers}');
          log('Response Data: ${e.response?.data}');
        }
        log('************************');
      }
      log('Profile fetch error: $e');
      log('Stack trace: $stackTrace');
      rethrow;
    }
  }
}
