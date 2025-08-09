import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../models/appconfig.dart';
import '../components/nav_bar.dart';

class RiwayatView extends StatefulWidget {
  const RiwayatView({super.key});

  @override
  State<RiwayatView> createState() => _RiwayatViewState();
}

class _RiwayatViewState extends State<RiwayatView> {
  // Sample transaction data
  final List<Map<String, dynamic>> _transactions = [
    {
      'title': 'Grocery Shopping',
      'amount': -125.75,
      'date': DateTime.now().subtract(const Duration(hours: 2)),
      'category': 'Shopping',
      'icon': Icons.shopping_bag,
    },
    {
      'title': 'Salary',
      'amount': 5000.00,
      'date': DateTime.now().subtract(const Duration(days: 1)),
      'category': 'Income',
      'icon': Icons.account_balance_wallet,
    },
    {
      'title': 'Dinner',
      'amount': -45.50,
      'date': DateTime.now().subtract(const Duration(days: 1, hours: 4)),
      'category': 'Food',
      'icon': Icons.restaurant,
    },
    {
      'title': 'Freelance Work',
      'amount': 350.00,
      'date': DateTime.now().subtract(const Duration(days: 2)),
      'category': 'Income',
      'icon': Icons.work,
    },
    {
      'title': 'Electric Bill',
      'amount': -120.00,
      'date': DateTime.now().subtract(const Duration(days: 3)),
      'category': 'Bills',
      'icon': Icons.bolt,
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
    final formatter = NumberFormat.currency(symbol: '\$', decimalDigits: 2);

    return Scaffold(
      backgroundColor: colors['background'],
      bottomNavigationBar: BottomNavBar(
        currentRoute: '/riwayat',
        onItemTapped: (route) {
          if (route != '/riwayat') {
            Navigator.pushReplacementNamed(context, route);
          }
        },
      ),
      appBar: AppBar(
        backgroundColor: colors['background'],
        elevation: 0,
        title: Text(
          'Transaction History',
          style: TextStyle(
            color: colors['text'],
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list, color: colors['text']),
            onPressed: () {
              // TODO: Implement filter
            },
          ),
        ],
      ),
      body: _buildTransactionList(groupedTransactions, colors, formatter),
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

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: groupedTransactions.length,
      itemBuilder: (context, index) {
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
      },
    );
  }

  Widget _buildTransactionCard(
    Map<String, dynamic> transaction,
    Map<String, Color> colors,
    NumberFormat formatter,
  ) {
    final isExpense = transaction['amount'] < 0;
    final amount = transaction['amount'];
    final category = transaction['category'] as String;
    
    return Card(
      color: colors['card'],
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: colors['primary']!.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            transaction['icon'],
            color: colors['primary'],
          ),
        ),
        title: Text(
          transaction['title'],
          style: TextStyle(
            color: colors['text'],
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          category,
          style: TextStyle(
            color: colors['textSecondary'],
            fontSize: 12,
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              formatter.format(amount.abs()),
              style: TextStyle(
                color: isExpense ? colors['error'] : colors['success'],
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              DateFormat('h:mm a').format(transaction['date']),
              style: TextStyle(
                color: colors['textTertiary'],
                fontSize: 12,
              ),
            ),
          ],
        ),
        onTap: () {
          // TODO: Show transaction details
        },
      ),
    );
  }
}
