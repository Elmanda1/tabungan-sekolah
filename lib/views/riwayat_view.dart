import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../models/appconfig.dart';
import '../maintemplates.dart';
import '../components/income_expense_cards.dart';

class RiwayatView extends StatefulWidget {
  const RiwayatView({super.key});

  @override
  State<RiwayatView> createState() => _RiwayatViewState();
}

class _RiwayatViewState extends State<RiwayatView> {
  // Sample transaction data in IDR
  final List<Map<String, dynamic>> _transactions = [
    {
      'title': 'Belanja Bulanan',
      'amount': -1257500,
      'date': DateTime.now().subtract(const Duration(hours: 2)),
    },
    {
      'title': 'Gaji',
      'amount': 5000000,
      'date': DateTime.now().subtract(const Duration(days: 1)),
    },
    {
      'title': 'Makan Malam',
      'amount': -455000,
      'date': DateTime.now().subtract(const Duration(days: 1, hours: 4)),
    },
    {
      'title': 'Freelance',
      'amount': 3500000,
      'date': DateTime.now().subtract(const Duration(days: 2)),
    },
    {
      'title': 'Tagihan Listrik',
      'amount': -1200000,
      'date': DateTime.now().subtract(const Duration(days: 3)),
    },
  ];

  // Group transactions by date
  Map<String, List<Map<String, dynamic>>> _groupTransactionsByDate() {
    final Map<String, List<Map<String, dynamic>>> grouped = {};
    
    for (var transaction in _transactions) {
      final date = DateFormat('EEEE, MMM d, y').format(transaction['date']);
      if (!grouped.containsKey(date)) {
        grouped[date] = [];
      }
      grouped[date]!.add(transaction);
    }
    
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.watch<AppConfig>().colorPalette;
    final groupedTransactions = _groupTransactionsByDate();
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
                income: _transactions
                    .where((t) => t['amount'] > 0)
                    .fold(0.0, (sum, t) => sum + (t['amount'] as num).toDouble()),
                expenses: _transactions
                    .where((t) => t['amount'] < 0)
                    .fold(0.0, (sum, t) => sum + (t['amount'] as num).abs().toDouble()),
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
            _buildTransactionList(groupedTransactions, colors, formatter),
            const SizedBox(height: 20), // Add some bottom padding
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionList(
    Map<String, List<Map<String, dynamic>>> groupedTransactions,
    Map<String, Color> colors,
    NumberFormat formatter,
  ) {
    if (groupedTransactions.isEmpty) {
      return Center(
        child: Text(
          'No transactions yet',
          style: TextStyle(
            color: colors['textSecondary'],
            fontSize: 16,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: List.generate(groupedTransactions.length, (index) {
        final date = groupedTransactions.keys.elementAt(index);
        final transactions = groupedTransactions[date]!;
        
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
            ...transactions.map((transaction) => _buildTransactionCard(transaction, colors, formatter)).toList(),
            const SizedBox(height: 16),
          ],
        );
        }),
      ),
    );
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
}
