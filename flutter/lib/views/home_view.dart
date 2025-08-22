import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../models/appconfig.dart';
import '../maintemplates.dart';
import '../modules/dashboard_tabungan.dart';
import '../modules/profil_sekolah_siswa.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.title});

  final String title;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // Dummy data in IDR
  final double _currentBalance = 9400000.00;

  final List<Map<String, dynamic>> _transactions = [
    {'title': 'Belanja', 'amount': -120000, 'time': 'Hari Ini', 'icon': Icons.shopping_bag},
    {'title': 'Transfer', 'amount': 1000000, 'time': 'Kemarin', 'icon': Icons.swap_horiz},
    {'title': 'Gaji', 'amount': 5000000, 'time': '2 hari lalu', 'icon': Icons.account_balance_wallet},
  ];
    
  @override
  Widget build(BuildContext context) {
    final appConfig = context.watch<AppConfig>();
    final colors = appConfig.colorPalette;

    return MainTemplate(
      backgroundColor: colors['background'],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 25.0, top: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Card with Student Info
              if (appConfig.featureFlags['feature.home.profile_card.enabled'] ?? false)
                Column(
                  children: [
                    ProfileCard(
                      colors: colors,
                      userName: 'John Doe',
                      studentName: 'John Doe',
                      studentClass: 'XI IPA 1',
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              
              // Dashboard Tabungan
              if (appConfig.featureFlags['feature.home.dashboard_tabungan.enabled'] ?? false)
                Column(
                  children: [
                    DashboardTabungan(
                      colors: colors,
                      currentBalance: _currentBalance,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              
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
                          Flexible(
                            child: Row(
                              children: [
                                Icon(Icons.receipt_long_outlined, size: 24, color: colors['primary']),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Text(
                                    'Transaksi',
                                    style: TextStyle(
                                      color: colors['text'],
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/riwayat');
                            },
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.only(left: 8, top: 4, bottom: 4),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              visualDensity: VisualDensity.compact,
                            ),
                            child: Text(
                              'Lihat Semua',
                              style: TextStyle(
                                color: colors['primary'],
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
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
                                'Rp${NumberFormat('#,###', 'id_ID').format(transaction['amount'].abs().toInt())}',
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
