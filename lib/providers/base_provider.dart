import 'package:flutter/material.dart';

enum ViewState { idle, loading, error }

class BaseProvider extends ChangeNotifier {
  ViewState _state = ViewState.idle;
  String? _errorMessage;
  dynamic _error;

  ViewState get state => _state;
  String? get errorMessage => _errorMessage;
  dynamic get error => _error;

  void setState(ViewState newState) {
    _state = newState;
    notifyListeners();
  }

  void setError(String message, [dynamic error]) {
    _errorMessage = message;
    _error = error;
    _state = ViewState.error;
    notifyListeners();
  }
}
