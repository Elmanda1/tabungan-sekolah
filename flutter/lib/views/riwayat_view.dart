import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../models/appconfig.dart';
import '../maintemplates.dart';
import '../providers/riwayat_provider.dart';
import '../providers/tabungan_provider.dart'; // Import TabunganProvider
import '../providers/base_provider.dart';
import '../widgets/riwayat_list_skeleton.dart';
import '../components/income_expense_cards.dart';
import '../services/dialog_service.dart';

class RiwayatView extends StatefulWidget {
  const RiwayatView({super.key});

  @override
  State<RiwayatView> createState() => _RiwayatViewState();
}

class _RiwayatViewState extends State<RiwayatView> {
  final DialogService _dialogService = DialogService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RiwayatProvider>(context, listen: false).fetchTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.watch<AppConfig>().colorPalette;
    final tabunganProvider = Provider.of<TabunganProvider>(context); // Get TabunganProvider instance

    return MainTemplate(
      body: Consumer<RiwayatProvider>(
        builder: (context, riwayatProvider, child) {
          if (riwayatProvider.state == ViewState.loading) {
            return const RiwayatListSkeleton();
          }

          if (riwayatProvider.state == ViewState.error) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _dialogService.showErrorDialog(context, riwayatProvider.errorMessage!);
            });
            return Center(child: Text(riwayatProvider.errorMessage!));
          }

          if (riwayatProvider.transactions.isEmpty) {
            return const Center(
              child: Text('Tidak ada riwayat transaksi'),
            );
          }

          final groupedTransactions = _groupTransactions(riwayatProvider.transactions);
          final dates = groupedTransactions.keys.toList()..sort((a, b) => b.compareTo(a));
          final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Income and Expenses Cards
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 45.0, 16.0, 16.0),
                  child: IncomeExpenseCards(
                    colors: colors,
                    income: tabunganProvider.income, // Use income from TabunganProvider
                    expenses: tabunganProvider.expenses, // Use expenses from TabunganProvider
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    children: dates.map((date) {
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
                          ...groupedTransactions[date]!.map((transaction) => _buildTransactionCard(transaction, colors, formatter)).toList(),
                          const SizedBox(height: 16),
                        ],
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 20), // Add some bottom padding
              ],
            ),
          );
        },
      ),
    );
  }

  Map<String, List<Map<String, dynamic>>> _groupTransactions(List<Map<String, dynamic>> transactions) {
    final Map<String, List<Map<String, dynamic>>> groupedTransactions = {};
    for (var transaction in transactions) {
      try {
        DateTime? dateTime;
        final dateString = transaction['tanggal']?.toString() ?? 
                          transaction['tanggal_transaksi']?.toString() ??
                          transaction['created_at']?.toString();
        
        if (dateString != null) {
          try {
            if (dateString.contains('T')) {
              dateTime = DateTime.parse(dateString).toLocal();
            } else if (dateString.contains('-')) {
              dateTime = DateFormat('yyyy-MM-dd').parse(dateString).toLocal();
            } else if (dateString.contains('/')) {
              dateTime = DateFormat('dd/MM/yyyy').parse(dateString).toLocal();
            }
          } catch (e) {
            debugPrint('Error parsing date "$dateString": $e');
          }
        }
        dateTime ??= DateTime.now();
        
        final date = DateFormat('EEEE, d MMMM y', 'id_ID').format(DateTime(
          dateTime.year,
          dateTime.month,
          dateTime.day,
        ));
        
        if (!groupedTransactions.containsKey(date)) {
          groupedTransactions[date] = [];
        }
        
        final amount = (transaction['jumlah'] is num) 
            ? (transaction['jumlah'] as num).toDouble() 
            : 0.0;
            
        final jenisTransaksi = transaction['jenis_transaksi']?.toString().toLowerCase() ?? '';
        final isSetor = jenisTransaksi == 'setor';
        
        groupedTransactions[date]!.add({
          'id': transaction['id']?.toString() ?? '',
          'title': transaction['keterangan']?.toString() ?? 'Transaksi',
          'amount': isSetor ? amount.abs() : -amount.abs(),
          'date': dateTime,
          'jenis_tabungan': transaction['jenis_tabungan']?.toString(),
          'saldo_sesudah': (transaction['saldo_sesudah'] as num?)?.toDouble() ?? 0.0,
          'is_setor': isSetor,
        });
      } catch (e) {
        debugPrint('Error processing transaction: $e');
        continue;
      }
    }
    return groupedTransactions;
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
          DateFormat('dd MMM yyyy', 'id_ID').format(DateTime(
            transaction['date'].year,
            transaction['date'].month,
            transaction['date'].day,
          )),
          style: TextStyle(
            color: colors['textTertiary'],
            fontSize: 11,
          ),
        ),
        trailing: Text(
          formatter.format(amount).replaceAll('-', ''),
          style: TextStyle(
            color: isExpense ? colors['error'] : colors['success'],
            fontWeight: FontWeight.w500,
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
