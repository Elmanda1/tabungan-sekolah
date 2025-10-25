import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../components/income_expense_cards.dart';

class DashboardTabungan extends StatelessWidget {
  final Map<String, Color> colors;
  final double currentBalance;
  final double income;
  final double expenses;
  
  const DashboardTabungan({
    super.key,
    required this.colors,
    required this.currentBalance,
    required this.income,
    required this.expenses,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Balance Card
        Card(
          color: colors['card'],
          shape: RoundedRectangleBorder(
            side: BorderSide(color: colors['primary']!, width: 1),
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
                    Icon(Icons.wallet, size: 32, color: colors['primaryLight']),
                    const SizedBox(width: 12),
                    Text(
                      'Saldo Saat Ini',
                      style: TextStyle(
                        color: colors['text'],
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                    NumberFormat.currency(
                      locale: 'id_ID',
                      symbol: 'Rp',
                      decimalDigits: 0,
                    ).format(currentBalance),
                    style: TextStyle(
                      color: colors['primary'],
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
          colors: colors,
          income: income,
          expenses: expenses,
        ),
      ],
    );
  }
}
