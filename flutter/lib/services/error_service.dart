import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'connectivity_service.dart';

class ErrorService {
  final ConnectivityService _connectivityService = ConnectivityService();

  Future<String> getFriendlyErrorMessage(dynamic error) async {
    if (error is SocketException) {
      debugPrint('SocketException: ${error.message}');
      if (error.message.contains('Connection refused')) {
        return 'Poor internet connection.';
      }
      if (!(await _connectivityService.isConnected())) {
        return 'No internet connection. Please check your network settings.';
      } else {
        return 'Could not connect to the server. Please try again later.';
      }
    } else if (error is HttpException) {
      debugPrint('HttpException: ${error.message}');
      if (!(await _connectivityService.isConnected())) {
        return 'No internet connection. Please check your network settings.';
      } else {
        return 'Could not connect to the server. Please try again later.';
      }
    } else if (error is TimeoutException) {
      debugPrint('TimeoutException: ${error.message}');
      return 'The server took too long to respond. Please try again.';
    } else if (error is String) {
      return error;
    } else if (error is Exception) {
      debugPrint('Unhandled Exception: $error');
      return 'Poor connection, please try again.';
    } else {
      debugPrint('Unknown error type: $error');
      return 'Poor connection, please try again.';
    }
  }
}
