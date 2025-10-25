import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'auth_service.dart';
import '../models/appconfig.dart';

class TabunganService {
  final AppConfig appConfig;
  final AuthService authService;

  TabunganService(this.appConfig, this.authService);

  // Get transaction history
  Future<List<Map<String, dynamic>>> getTransactionHistory({int limit = 10, int page = 1}) async {
    try {
      final headers = await authService.getAuthHeaders();
      final response = await http.get(
        Uri.parse('${appConfig.baseUrl}/tabungan/history?count=$limit&page=$page'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final result = List<Map<String, dynamic>>.from(data);
        return result;
      }
      throw Exception('Failed to get transaction history');
    } catch (e) {
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
      final headers = await authService.getAuthHeaders();
      final response = await http.get(
        Uri.parse('${appConfig.baseUrl}/tabungan/income-expenses'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        return result;
      }
      throw Exception('Failed to get income and expenses');
    } catch (e) {
      debugPrint('Error getting income/expenses: $e');
      rethrow;
    }
  }

  // Get current balance
  Future<Map<String, dynamic>> getBalance() async {
    try {
      final headers = await authService.getAuthHeaders();
      final response = await http.get(
        Uri.parse('${appConfig.baseUrl}/tabungan/saldo'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        return result;
      }
      throw Exception('Failed to get balance');
    } catch (e) {
      debugPrint('Error getting balance: $e');
      rethrow;
    }
  }
}
