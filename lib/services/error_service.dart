import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'connectivity_service.dart';

class ErrorService {
  final ConnectivityService _connectivityService = ConnectivityService();

  Future<String> getFriendlyErrorMessage(dynamic error) async {
    if (error is DioException) {
      if (error.response != null && error.response?.data != null) {
        final data = error.response?.data;
        if (data is Map<String, dynamic> && data.containsKey('message')) {
          return data['message'];
        }
      }
    }
    if (error is SocketException) {
      debugPrint('SocketException: ${error.message}');
      if (error.message.contains('Connection refused')) {
        return 'Server sedang tidak tersedia. Silakan coba lagi nanti.';
      }
      if (!(await _connectivityService.isConnected())) {
        return 'Tidak ada koneksi internet. Silakan periksa pengaturan jaringan Anda.';
      } else {
        return 'Tidak dapat terhubung ke server. Silakan coba lagi nanti.';
      }
    } else if (error is HttpException) {
      debugPrint('HttpException: ${error.message}');
      if (!(await _connectivityService.isConnected())) {
        return 'Tidak ada koneksi internet. Silakan periksa pengaturan jaringan Anda.';
      } else {
        return 'Tidak dapat terhubung ke server. Silakan coba lagi nanti.';
      }
    } else if (error is TimeoutException) {
      debugPrint('TimeoutException: ${error.message}');
      return 'Server terlalu lama merespons. Silakan coba lagi.';
    } else if (error is String) {
      return error;
    } else if (error is Exception) {
      debugPrint('Unhandled Exception: $error');
      return 'Terjadi kesalahan. Silakan coba lagi.';
    } else {
      debugPrint('Unknown error type: $error');
      return 'Terjadi kesalahan. Silakan coba lagi.';
    }
  }
}
