import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../components/income_expense_cards.dart';
import '../services/tabungan_service.dart';

class DashboardTabungan extends StatefulWidget {
  final Map<String, Color> colors;
  final double currentBalance;
  
  const DashboardTabungan({
    Key? key,
    required this.colors,
    required this.currentBalance,
  }) : super(key: key);

  @override
  _DashboardTabunganState createState() => _DashboardTabunganState();
}                                                                                                                                                                                                                                       

class _DashboardTabunganState extends State<DashboardTabungan> {
  bool _isLoading = true;
  double _balance = 0;

  @override
  void initState() {
    super.initState();
    _fetchBalance();
  }

  Future<void> _fetchBalance() async {
    try {
      final balanceData = await TabunganService.getBalance();
      setState(() {
        _balance = (balanceData['saldo'] ?? 0).toDouble();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Optionally show an error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memuat saldo: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Balance Card
        Card(
          color: widget.colors['card'],
          shape: RoundedRectangleBorder(
            side: BorderSide(color: widget.colors['primary']!, width: 1),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.wallet, size: 32, color: widget.colors['primaryLight']),
                    const SizedBox(width: 12),
                    Text(
                      'Saldo Saat Ini',
                      style: TextStyle(
                        color: widget.colors['text'],
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _isLoading
                  ? CircularProgressIndicator(color: widget.colors['primary'])
                  : Text(
                      NumberFormat.currency(
                        locale: 'id_ID',
                        symbol: 'Rp',
                        decimalDigits: 0,
                      ).format(_balance),
                      style: TextStyle(
                        color: widget.colors['primary'],
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        IncomeExpenseCards(
          colors: widget.colors,
        ),
      ],
    );
  }
}
