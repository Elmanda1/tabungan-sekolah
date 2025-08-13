import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IncomeExpenseCards extends StatelessWidget {
  final double income;
  final double expenses;
  final Map<String, Color> colors;

  const IncomeExpenseCards({
    super.key,
    required this.income,
    required this.expenses,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);

    return Column(
      children: [
        // Income Card
        Card(
          color: colors['card'],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: colors['success']!, width: 0.7),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colors['success']!.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Icon(Icons.trending_up, color: colors['success']),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pemasukan',
                      style: TextStyle(
                        color: colors['textSecondary'],
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      formatter.format(income),
                      style: TextStyle(
                        color: colors['success'],
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
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
          color: colors['card'],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: colors['error']!, width: 0.7),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colors['error']!.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Icon(Icons.trending_down, color: colors['error']),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pengeluaran',
                      style: TextStyle(
                        color: colors['textSecondary'],
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      formatter.format(expenses),
                      style: TextStyle(
                        color: colors['error'],
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
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
