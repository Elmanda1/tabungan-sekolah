import 'package:flutter/foundation.dart';
import '../services/tabungan_service.dart';
import 'base_provider.dart';
import '../services/error_service.dart';

class RiwayatProvider extends BaseProvider {
  List<Map<String, dynamic>> _transactions = [];

  List<Map<String, dynamic>> get transactions => _transactions;

  final ErrorService _errorService = ErrorService();

  Future<void> fetchTransactions() async {
    setState(ViewState.loading);
    try {
      _transactions = await TabunganService.getTransactionHistory();
      setState(ViewState.idle);
    } catch (e) {
      setError(await _errorService.getFriendlyErrorMessage(e));
    }
  }
}
