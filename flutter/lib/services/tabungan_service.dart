import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'auth_service.dart';

class TabunganService {
  static const String _baseUrl = 'http://10.0.2.2:8000/api';

  // Get transaction history
  static Future<List<Map<String, dynamic>>> getTransactionHistory() async {
    try {
      final headers = await AuthService.getAuthHeaders();
      final response = await http.get(
        Uri.parse('$_baseUrl/tabungan/history'),
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
  static Future<List<Map<String, dynamic>>> getRecentTransactions() async {
    try {
      final headers = await AuthService.getAuthHeaders();
      final response = await http.get(
        Uri.parse('$_baseUrl/tabungan/history3'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final result = List<Map<String, dynamic>>.from(data);
        return result;
      }
      throw Exception('Failed to get recent transactions');
    } catch (e) {
      debugPrint('Error getting recent transactions: $e');
      rethrow;
    }
  }

  // Get income and expenses summary
  static Future<Map<String, dynamic>> getIncomeExpenses() async {
    try {
      final headers = await AuthService.getAuthHeaders();
      final response = await http.get(
        Uri.parse('$_baseUrl/tabungan/income-expenses'),
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
  static Future<Map<String, dynamic>> getBalance() async {
    try {
      final headers = await AuthService.getAuthHeaders();
      final response = await http.get(
        Uri.parse('$_baseUrl/tabungan/saldo'),
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
