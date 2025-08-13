import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../components/income_expense_cards.dart';

class DashboardTabungan extends StatelessWidget {
  final Map<String, Color> colors;
  final double currentBalance;
  const DashboardTabungan({
    Key? key,
    required this.colors,
    required this.currentBalance,
  }) : super(key: key);

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
                  'Rp${NumberFormat('#,###', 'id_ID').format(currentBalance.toInt())}',
                  style: TextStyle(
                    color: colors['primaryLight'],
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        IncomeExpenseCards(
          income: 5000000,
          expenses: 1200000,
          colors: colors,
        ),
      ],
    );
  }
}
