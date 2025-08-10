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
  // Dummy data
  final double _currentBalance = 9400.00;
  final double _income = 5000.00;
  final double _expenses = 1200.00;
  
  final List<Map<String, dynamic>> _transactions = [
    {'title': 'Shopping', 'amount': -120.00, 'time': 'Today', 'icon': Icons.shopping_bag},
    {'title': 'Transfer', 'amount': 1000.00, 'time': 'Yesterday', 'icon': Icons.swap_horiz},
    {'title': 'Salary', 'amount': 5000.00, 'time': '2 days ago', 'icon': Icons.account_balance_wallet},
  ];
  
  // Helper method to build info cards
  Widget _buildInfoCard({
    required String title,
    required double amount,
    bool titleOnly = false,
    String customTitle = '',
  }) {
    final formatter = NumberFormat.currency(symbol: '\$', decimalDigits: 2);
    final colors = context.read<AppConfig>().colorPalette;
  
    return Expanded(
      child: Card(
        color: colors['surface'],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: colors['textSecondary'],
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                titleOnly ? customTitle : formatter.format(amount),
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
              // Profile Card
              Card(
                color: colors['primary'],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Row with Profile Info
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 12.0),
                      child: Row(
                        children: [
                          // Profile Avatar
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: colors['surface'],
                              borderRadius: BorderRadius.circular(100),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.person_outline,
                              size: 30,
                              color: colors['text'],
                            ),
                          ),
                          const SizedBox(width: 16),
                          // User Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Selamat Siang,',
                                  style: TextStyle(
                                    color: colors['text'],
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'John Doe',
                                  style: TextStyle(
                                    color: colors['text'],
                                    fontSize: 21,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Student Info Row
                    Container(
                      padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildInfoCard(
                              title: 'Nama',
                              amount: 0,
                              titleOnly: true,
                              customTitle: 'John Doe',
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildInfoCard(
                              title: 'Kelas',
                              amount: 0,
                              titleOnly: true,
                              customTitle: 'XI IPA 1',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
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
                        '\$$_currentBalance',
                        style: TextStyle(
                          color: colors['primaryLight'],
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Setor Uang Button
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/transaksi', arguments: 'deposit');
                                },
                                icon: const Icon(Icons.add_circle_outline, size: 18),
                                label: const FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text('Setor Uang', style: TextStyle(fontSize: 13)),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: colors['success'],
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(11),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Tarik Uang Button
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/transaksi', arguments: 'withdraw');
                                },
                                icon: Icon(Icons.remove_circle_outline, size: 18, color: colors['error']),
                                label: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text('Tarik Uang', 
                                    style: TextStyle(
                                      color: colors['error'],
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: colors['card'],
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                  side: BorderSide(color: colors['error']!),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(11),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Income and Expenses Cards
              const SizedBox(height: 16),
              Row(
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
                                  '\$$_income',
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
                                  '\$$_expenses',
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
              const SizedBox(height: 20),
              // Recent Transactions Card
              Card(
                color: colors['card'],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                  side: BorderSide(
                    color: colors['outline']!,
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.receipt_long_outlined, size: 30, color: colors['primary']),
                              const SizedBox(width: 8),
                              Text(
                                'Transaksi Terakhir',
                                style: TextStyle(
                                  color: colors['text'],
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/riwayat');
                            },
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Lihat Semua',
                                  style: TextStyle(
                                    color: colors['primary'],
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.arrow_forward,
                                  size: 12,
                                  color: colors['primary'],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Transaction List
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                        itemCount: _transactions.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final transaction = _transactions[index];
                          final isExpense = transaction['amount'] < 0;
                          
                          return Container(
                            decoration: BoxDecoration(
                              color: colors['surface'],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                              minVerticalPadding: 0,
                              dense: true,
                              leading: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: isExpense 
                                    ? colors['error']!.withOpacity(0.1)
                                    : colors['success']!.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  isExpense ? Icons.trending_down : Icons.trending_up,
                                  color: isExpense ? colors['error'] : colors['success'],
                                  size: 18,
                                ),
                              ),
                              title: Text(
                                transaction['title'] as String,
                                style: TextStyle(
                                  color: colors['text'],
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  height: 1.2,
                                ),
                              ),
                              subtitle: Text(
                                transaction['time'] as String,
                                style: TextStyle(
                                  color: colors['textTertiary'],
                                  fontSize: 11,
                                  height: 1.2,
                                ),
                              ),
                              trailing: Text(
                                '\$${transaction['amount'].abs().toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: isExpense ? colors['error'] : colors['success'],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
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
            ],
          ),
        ),
      ),
    );
  }
}
