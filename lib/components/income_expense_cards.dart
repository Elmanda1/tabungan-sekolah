import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IncomeExpenseCards extends StatelessWidget {
  final Map<String, Color> colors;
  final double income;
  final double expenses;
  
  const IncomeExpenseCards({
    super.key,
    required this.colors,
    required this.income,
    required this.expenses,
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
            side: BorderSide(color: colors['success'] ?? Colors.green, width: 0.7),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: (colors['success'] ?? Colors.green).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Icon(Icons.trending_up, color: colors['success'] ?? Colors.green),
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
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colors['success'],
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
            side: BorderSide(color: colors['error'] ?? Colors.red, width: 0.7),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: (colors['error'] ?? Colors.red).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Icon(Icons.trending_down, color: colors['error'] ?? Colors.red),
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
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colors['error'],
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
