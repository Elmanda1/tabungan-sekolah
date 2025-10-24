import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import '../services/tabungan_service.dart';
import 'base_provider.dart';
import '../services/error_service.dart';

class RiwayatProvider extends BaseProvider {
  List<Map<String, dynamic>> _transactions = [];
  int _currentPage = 1;
  bool _hasMore = true;

  List<Map<String, dynamic>> get transactions => _transactions;
  bool get hasMore => _hasMore;

  Map<String, List<Map<String, dynamic>>> get groupedTransactions {
    final Map<String, List<Map<String, dynamic>>> groupedTransactions = {};
    for (var transaction in _transactions) {
      try {
        DateTime? dateTime;
        final dateString = transaction['tanggal']?.toString() ?? 
                          transaction['tanggal_transaksi']?.toString() ??
                          transaction['created_at']?.toString();
        
        if (dateString != null) {
          try {
            if (dateString.contains('T')) {
              dateTime = DateTime.parse(dateString).toLocal();
            } else if (dateString.contains('-')) {
              dateTime = DateFormat('yyyy-MM-dd').parse(dateString).toLocal();
            } else if (dateString.contains('/')) {
              dateTime = DateFormat('dd/MM/yyyy').parse(dateString).toLocal();
            }
          } catch (e) {
            debugPrint('Error parsing date "$dateString": $e');
          }
        }
        dateTime ??= DateTime.now();
        
        final date = DateFormat('EEEE, d MMMM y', 'id_ID').format(DateTime(
          dateTime.year,
          dateTime.month,
          dateTime.day,
        ));
        
        if (!groupedTransactions.containsKey(date)) {
          groupedTransactions[date] = [];
        }
        
        final amount = (transaction['jumlah'] is num) 
            ? (transaction['jumlah'] as num).toDouble() 
            : 0.0;
            
        final jenisTransaksi = transaction['jenis_transaksi']?.toString().toLowerCase() ?? '';
        final isSetor = jenisTransaksi == 'setor';
        
        groupedTransactions[date]!.add({
          'id': transaction['id']?.toString() ?? '',
          'title': transaction['keterangan']?.toString() ?? 'Transaksi',
          'amount': isSetor ? amount.abs() : -amount.abs(),
          'date': dateTime,
          'jenis_tabungan': transaction['jenis_tabungan']?.toString(),
          'saldo_sesudah': (transaction['saldo_sesudah'] as num?)?.toDouble() ?? 0.0,
          'is_setor': isSetor,
        });
      } catch (e) {
        debugPrint('Error processing transaction: $e');
        continue;
      }
    }
    return groupedTransactions;
  }

  final ErrorService _errorService = ErrorService();

  Future<void> fetchMoreTransactions() async {
    if (state == ViewState.loading || !_hasMore) return;

    setState(ViewState.loading);
    try {
      final newTransactions = await TabunganService.getTransactionHistory(page: _currentPage);
      if (newTransactions.isEmpty) {
        _hasMore = false;
      } else {
        _transactions.addAll(newTransactions);
        _currentPage++;
      }
      setState(ViewState.idle);
    } catch (e) {
      setError(await _errorService.getFriendlyErrorMessage(e));
    }
  }

  Future<void> refresh() async {
    _transactions = [];
    _currentPage = 1;
    _hasMore = true;
    await fetchMoreTransactions();
  }
}
