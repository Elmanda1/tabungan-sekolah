import 'package:flutter/material.dart';

class SnackbarService {
  void showErrorSnackbar(BuildContext context, String message) {
    final snackbar = SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
