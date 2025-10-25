import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'api_service.dart'; // Import ApiService

class TabunganService {
  final ApiService _apiService; // Use ApiService

  TabunganService(this._apiService); // Inject ApiService

  // Get transaction history
  Future<List<Map<String, dynamic>>> getTransactionHistory({int limit = 10, int page = 1}) async {
    try {
      final response = await _apiService.dio.get(
        '/tabungan/history',
        queryParameters: {'count': limit, 'page': page},
      );
      debugPrint('Response from /tabungan/history: ${response.data}');
      return List<Map<String, dynamic>>.from(response.data);
    } catch (e) {
      if (e is DioException) {
        debugPrint('************************');
        debugPrint('DioException Details (/tabungan/history):');
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
      debugPrint('Error getting transaction history: $e');
      rethrow;
    }
  }

  // Get recent transactions (last 3)
  Future<List<Map<String, dynamic>>> getRecentTransactions() async {
    return getTransactionHistory(limit: 3);
  }

  // Get income and expenses summary
  Future<Map<String, dynamic>> getIncomeExpenses() async {
    try {
      final response = await _apiService.dio.get(
        '/tabungan/income-expenses',
      );
      debugPrint('Response from /tabungan/income-expenses: ${response.data}');
      return response.data;
    } catch (e) {
      if (e is DioException) {
        debugPrint('************************');
        debugPrint('DioException Details (/tabungan/income-expenses):');
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
      debugPrint('Error getting income/expenses: $e');
      rethrow;
    }
  }

  // Get current balance
  Future<Map<String, dynamic>> getBalance() async {
    try {
      final response = await _apiService.dio.get(
        '/tabungan/saldo',
      );
      debugPrint('Response from /tabungan/saldo: ${response.data}');
      return response.data;
    } catch (e) {
      if (e is DioException) {
        debugPrint('************************');
        debugPrint('DioException Details (/tabungan/saldo):');
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
      debugPrint('Error getting balance: $e');
      rethrow;
    }
  }
}
