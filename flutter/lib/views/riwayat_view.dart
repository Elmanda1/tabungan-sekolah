import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../models/appconfig.dart';
import '../maintemplates.dart';
import '../services/tabungan_service.dart';
import '../components/income_expense_cards.dart';

class RiwayatView extends StatefulWidget {
  const RiwayatView({super.key});

  @override
  State<RiwayatView> createState() => _RiwayatViewState();
}

class _RiwayatViewState extends State<RiwayatView> {
  final Map<String, List<Map<String, dynamic>>> _groupedTransactions = {};
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    if (!mounted) return;
    
    setState(() {
      _isLoading = true;
      _error = null;
    });
    
    try {
      final transactions = await TabunganService.getTransactionHistory();
      
      if (!mounted) return;
      
      if (transactions.isEmpty) {
        setState(() {
          _groupedTransactions.clear();
          _isLoading = false;
        });
        return;
      }
      
      _groupTransactions(transactions);
      setState(() => _isLoading = false);
      
    } catch (e) {
      if (!mounted) return;
      
      debugPrint('Error loading transactions: $e');
      setState(() {
        _error = 'Gagal memuat riwayat transaksi';
        _isLoading = false;
      });
    }
  }

  // Group transactions by date
  void _groupTransactions(List<Map<String, dynamic>> transactions) {
    _groupedTransactions.clear();
    
    for (var transaction in transactions) {
      try {
        // Safely parse the date, handling potential null or invalid formats
        DateTime? dateTime;
        if (transaction['tanggal'] != null) {
          try {
            dateTime = DateTime.parse(transaction['tanggal'].toString()).toLocal();
          } catch (e) {
            debugPrint('Error parsing date: ${transaction['tanggal']}');
            // Fallback to current date if parsing fails
            dateTime = DateTime.now();
          }
        } else {
          dateTime = DateTime.now();
        }
        
        final date = DateFormat('EEEE, d MMMM y', 'id_ID').format(dateTime);
        
        if (!_groupedTransactions.containsKey(date)) {
          _groupedTransactions[date] = [];
        }
        
        // Safely parse amount and handle null values
        final amount = (transaction['jumlah'] is num) 
            ? (transaction['jumlah'] as num).toDouble() 
            : 0.0;
            
        final jenisTransaksi = transaction['jenis_transaksi']?.toString().toLowerCase() ?? '';
        
        // Add transaction to the group
        _groupedTransactions[date]!.add({
          'id': transaction['id']?.toString() ?? '',
          'title': transaction['keterangan']?.toString() ?? 'Transaksi',
          'amount': jenisTransaksi == 'setor' ? amount : -amount,
          'date': dateTime,
          'jenis_tabungan': transaction['jenis_tabungan']?.toString(),
          'saldo_sesudah': (transaction['saldo_sesudah'] as num?)?.toDouble() ?? 0.0,
        });
      } catch (e) {
        debugPrint('Error processing transaction: $e');
        // Skip invalid transactions
        continue;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.watch<AppConfig>().colorPalette;
    
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_error!),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadTransactions,
              child: const Text('Coba Lagi'),
            ),
          ],
        ),
      );
    }

    if (_groupedTransactions.isEmpty) {
      return const Center(
        child: Text('Tidak ada riwayat transaksi'),
      );
    }

    final dates = _groupedTransactions.keys.toList()..sort((a, b) => b.compareTo(a));
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);

    return MainTemplate(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Income and Expenses Cards
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 45.0, 16.0, 16.0),
              child: IncomeExpenseCards(
                colors: colors,
              ),
            ),
            // Transaction List Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0),
              child: Row(
                children: [
                  Icon(Icons.receipt_long_outlined, color: colors['primary'], size: 25),
                  const SizedBox(width: 8),
                  Text(
                    'Transaksi',
                    style: TextStyle(
                      color: colors['text'],
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),
            // Transaction List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: dates.map((date) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          date,
                          style: TextStyle(
                            color: colors['textSecondary'],
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      ..._groupedTransactions[date]!.map((transaction) => _buildTransactionCard(transaction, colors, formatter)).toList(),
                      const SizedBox(height: 16),
                    ],
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20), // Add some bottom padding
          ],
        ),
      ),
    );
  }

  }

  Widget _buildTransactionCard(
    Map<String, dynamic> transaction,
    Map<String, Color> colors,
    NumberFormat formatter,
  ) {
    final isExpense = transaction['amount'] < 0;
    final amount = transaction['amount'];
    
    return Card(
      color: colors['card'],
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(11),
        side: BorderSide(color: colors['outline']!, width: 0.7),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        dense: true,
        leading: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: isExpense 
                ? (colors['error'] ?? Colors.red).withOpacity(0.1)
                : (colors['success'] ?? Colors.green).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            isExpense ? Icons.trending_down : Icons.trending_up,
            color: isExpense ? colors['error'] : colors['success'],
            size: 20,
          ),
        ),
        title: Text(
          transaction['title'],
          style: TextStyle(
            color: colors['text'],
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          DateFormat('h:mm a').format(transaction['date']),
          style: TextStyle(
            color: colors['textTertiary'],
            fontSize: 11,
          ),
        ),
        trailing: Text(
          formatter.format(amount).replaceAll('-', ''),
          style: TextStyle(
            color: isExpense ? colors['error'] : colors['success'],
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        onTap: () {
          // TODO: Show transaction details
        },
      ),
    );
  }

