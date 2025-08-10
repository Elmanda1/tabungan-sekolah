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
    },
    {
      'title': 'Salary',
      'amount': 5000.00,
      'date': DateTime.now().subtract(const Duration(days: 1)),
    },
    {
      'title': 'Dinner',
      'amount': -45.50,
      'date': DateTime.now().subtract(const Duration(days: 1, hours: 4)),
    },
    {
      'title': 'Freelance Work',
      'amount': 350.00,
      'date': DateTime.now().subtract(const Duration(days: 2)),
    },
    {
      'title': 'Electric Bill',
      'amount': -120.00,
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
      body: Column(
        children: [
          // Income and Expenses Cards
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 45.0, 16.0, 16.0),
            child: Row(
              children: [
                // Income Card
                Expanded(
                  child: Card(
                    color: colors['card'],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: colors['success']!, width: 0.7),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: colors['success']!.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Icon(Icons.trending_up, color: colors['success'], size: 24),
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
                              const SizedBox(height: 4),
                              Text(
                                formatter.format(_transactions.where((t) => t['amount'] > 0).fold(0.0, (sum, t) => sum + (t['amount'] as num).toDouble())),
                                style: TextStyle(
                                  color: colors['text'],
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Expenses Card
                Expanded(
                  child: Card(
                    color: colors['card'],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: colors['error']!, width: 0.7),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: colors['error']!.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Icon(Icons.trending_down, color: colors['error'], size: 24),
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
                              const SizedBox(height: 4),
                              Text(
                                formatter.format(_transactions.where((t) => t['amount'] < 0).fold(0.0, (sum, t) => sum + (t['amount'] as num).toDouble()).abs()),
                                style: TextStyle(
                                  color: colors['text'],
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Transaction List Header
          Padding(
            padding: const EdgeInsets.fromLTRB(35, 8, 5, 0),
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
          Expanded(
            child: _buildTransactionList(groupedTransactions, colors, formatter),
          ),
        ],
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

    return ListView.builder(
      padding: const EdgeInsets.all(25),
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
