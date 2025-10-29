
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/appconfig.dart';
import 'error_service.dart';
import 'snackbar_service.dart';

class DialogService {
  final ErrorService _errorService = ErrorService();
  final SnackbarService _snackbarService = SnackbarService();

  Future<void> showError(BuildContext context, String message, dynamic error) async {
    if (await _errorService.isNetworkError(error)) {
      _snackbarService.showErrorSnackbar(context, 'Tidak ada koneksi internet');
    } else {
      final colors = context.read<AppConfig>().colorPalette;
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: colors['card'],
          title: Text('Error', style: TextStyle(color: colors['text'])),
          content: Text(message, style: TextStyle(color: colors['textSecondary'])),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK', style: TextStyle(color: colors['primary'])),
            ),
          ],
        ),
      );
    }
  }

  Future<void> showInfoDialog(BuildContext context, String title, String message) async {
    final colors = context.read<AppConfig>().colorPalette;
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: colors['card'],
        title: Text(title, style: TextStyle(color: colors['text'])),
        content: Text(message, style: TextStyle(color: colors['textSecondary'])),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK', style: TextStyle(color: colors['primary'])),
          ),
        ],
      ),
    );
  }
}
