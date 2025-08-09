import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../components/nav_bar.dart';
import '../models/appconfig.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.title});

  final String title;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // Sample data - in a real app, this would come from a data provider
  final double _currentBalance = 9400.00;
  final double _income = 5000.00;
  final double _expenses = 1200.00;
  
  final List<Map<String, dynamic>> _transactions = [
    {'title': 'Shopping', 'amount': -120.00, 'time': 'Today', 'icon': Icons.shopping_bag},
    {'title': 'Transfer', 'amount': 1000.00, 'time': 'Yesterday', 'icon': Icons.swap_horiz},
    {'title': 'Salary', 'amount': 5000.00, 'time': '2 days ago', 'icon': Icons.account_balance_wallet},
  ];
  
  // Helper method to build info cards for income/expense
  Widget _buildInfoCard(String title, double amount, IconData icon, bool isIncome) {
    final formatter = NumberFormat.currency(symbol: '\$', decimalDigits: 2);
    final colors = context.read<AppConfig>().colorPalette;
    final iconColor = isIncome ? colors['success'] : colors['error'];
    final bgColor = isIncome 
        ? colors['success']!.withOpacity(0.1) 
        : colors['error']!.withOpacity(0.1);
    
    return Expanded(
      child: Card(
        color: colors['surface'],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(icon, size: 16, color: iconColor),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: TextStyle(
                      color: colors['textSecondary'],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                formatter.format(amount),
                style: TextStyle(
                  color: colors['text'],
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
    
  @override
  Widget build(BuildContext context) {
    final appConfig = context.watch<AppConfig>();
    final colors = appConfig.colorPalette;

    return Scaffold(
      backgroundColor: colors['background'],
      bottomNavigationBar: BottomNavBar(
        currentRoute: '/home',
        onItemTapped: (route) {
          if (route != '/home') {
            Navigator.pushReplacementNamed(context, route);
          }
        },
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0), // Makes the app bar as small as possible
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0, bottom: 25.0, top: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: colors['primary'],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current Balance',
                        style: TextStyle(
                          color: colors['text'],
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '\$$_currentBalance',
                        style: TextStyle(
                          color: colors['text'],
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildInfoCard('Income', _income, Icons.arrow_upward, true),
                          _buildInfoCard('Expenses', _expenses, Icons.arrow_downward, false),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Recent Transactions
              Text(
                'Recent Transactions',
                style: TextStyle(
                  color: colors['textSecondary'],
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Transaction List
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _transactions.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final transaction = _transactions[index];
                  final isExpense = transaction['amount'] < 0;
                  
                  return Card(
                    color: colors['card'],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: colors['primary']!.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          transaction['icon'] as IconData,
                          color: colors['primary'],
                        ),
                      ),
                      title: Text(
                        transaction['title'] as String,
                        style: TextStyle(color: colors['text']),
                      ),
                      subtitle: Text(
                        transaction['time'] as String,
                        style: TextStyle(color: colors['textTertiary']),
                      ),
                      trailing: Text(
                        '\$${transaction['amount'].abs().toStringAsFixed(2)}',
                        style: TextStyle(
                          color: isExpense ? colors['error'] : colors['success'],
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
