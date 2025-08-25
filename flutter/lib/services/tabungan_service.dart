import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'auth_service.dart';

class TabunganService {
  static const String _baseUrl = 'https://5e58e553e35c.ngrok-free.app/api';

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
        return List<Map<String, dynamic>>.from(data);
      }
      return [];
    } catch (e) {
      debugPrint('Error getting transaction history: $e');
      return [];
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
        return List<Map<String, dynamic>>.from(data);
      }
      return [];
    } catch (e) {
      debugPrint('Error getting recent transactions: $e');
      return [];
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
        return jsonDecode(response.body);
      }
      return {'total_income': 0, 'total_expenses': 0};
    } catch (e) {
      debugPrint('Error getting income/expenses: $e');
      return {'total_income': 0, 'total_expenses': 0};
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
        return jsonDecode(response.body);
      }
      return {'saldo': 0};
    } catch (e) {
      debugPrint('Error getting balance: $e');
      return {'saldo': 0};
    }
  }

  // Get user profile
  static Future<Map<String, dynamic>> getUserProfile() async {
    try {
      final headers = await AuthService.getAuthHeaders();
      final response = await http.get(
        Uri.parse('$_baseUrl/profile'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      return {
        'nama_sekolah': 'N/A',
        'nama_siswa': 'N/A',
        'kelas': 'N/A',
      };
    } catch (e) {
      debugPrint('Error getting user profile: $e');
      return {
        'nama_sekolah': 'N/A',
        'nama_siswa': 'N/A',
        'kelas': 'N/A',
      };
    }
  }
}
