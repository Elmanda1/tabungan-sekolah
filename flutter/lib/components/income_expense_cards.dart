import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/tabungan_service.dart';

class IncomeExpenseCards extends StatefulWidget {
  final Map<String, Color> colors;
  
  const IncomeExpenseCards({
    super.key,
    required this.colors,
  });
  
  @override
  State<IncomeExpenseCards> createState() => _IncomeExpenseCardsState();
}

class _IncomeExpenseCardsState extends State<IncomeExpenseCards> {
  bool _isLoading = true;
  double _income = 0;
  double _expenses = 0;
  String _error = '';
  
  @override
  void initState() {
    super.initState();
    _fetchIncomeExpenses();
  }
  
  Future<void> _fetchIncomeExpenses() async {
    try {
      final data = await TabunganService.getIncomeExpenses();
      if (mounted) {
        setState(() {
          _income = (data['total_income'] ?? 0).toDouble();
          _expenses = (data['total_expenses'] ?? 0).toDouble();
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'Gagal memuat data pemasukan/pengeluaran';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
    
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    
    if (_error.isNotEmpty) {
      return Center(
        child: Text(
          _error,
          style: TextStyle(color: widget.colors['error']),
        ),
      );
    }

    return Column(
      children: [
        // Income Card
        Card(
          color: widget.colors['card'],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: widget.colors['success']!, width: 0.7),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: widget.colors['success']!.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Icon(Icons.trending_up, color: widget.colors['success']),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pemasukan',
                      style: TextStyle(
                        color: widget.colors['textSecondary'],
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      formatter.format(_income),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: widget.colors['success'],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),
        // Expense Card
        Card(
          color: widget.colors['card'],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: widget.colors['error']!, width: 0.7),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: widget.colors['error']!.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Icon(Icons.trending_down, color: widget.colors['error']),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pengeluaran',
                      style: TextStyle(
                        color: widget.colors['textSecondary'],
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      formatter.format(_expenses),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: widget.colors['error'],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
