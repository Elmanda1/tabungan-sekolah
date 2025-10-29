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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final riwayatProvider = Provider.of<RiwayatProvider>(context, listen: false);
      if (riwayatProvider.transactions.isEmpty) {
        riwayatProvider.refresh();
      }
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        Provider.of<RiwayatProvider>(context, listen: false).fetchMoreTransactions();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
              _dialogService.showError(context, riwayatProvider.errorMessage!, riwayatProvider.error);
            });
            return Center(child: Text(riwayatProvider.errorMessage!));
          }

          if (riwayatProvider.transactions.isEmpty) {
            return const Center(
              child: Text('Tidak ada riwayat transaksi'),
            );
          }

          final groupedTransactions = riwayatProvider.groupedTransactions;
          final dates = groupedTransactions.keys.toList()..sort((a, b) => b.compareTo(a));
          final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);

          return ListView.builder(
            controller: _scrollController,
            itemCount: dates.length + (riwayatProvider.hasMore ? 1 : 0) + 1, // +1 for IncomeExpenseCards
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 45.0, 16.0, 16.0),
                  child: IncomeExpenseCards(
                    colors: colors,
                    income: tabunganProvider.income,
                    expenses: tabunganProvider.expenses,
                  ),
                );
              }
              // Adjust index for the actual transaction data
              final transactionIndex = index - 1;

              if (transactionIndex == dates.length) {
                return const Center(child: CircularProgressIndicator());
              }
              final date = dates[transactionIndex];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
                    child: Text(
                      date,
                      style: TextStyle(
                        color: colors['textSecondary'],
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      children: groupedTransactions[date]!.map((transaction) => _buildTransactionCard(transaction, colors, formatter)).toList(),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              );
            },
          );
        },
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
