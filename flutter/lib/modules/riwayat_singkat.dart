import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/tabungan_service.dart';

class RiwayatSingkat extends StatefulWidget {
  final Map<String, Color> colors;
  final VoidCallback onViewAll;

  const RiwayatSingkat({
    Key? key,
    required this.colors,
    required this.onViewAll,
  }) : super(key: key);

  @override
  State<RiwayatSingkat> createState() => _RiwayatSingkatState();
}

class _RiwayatSingkatState extends State<RiwayatSingkat> {
  late Future<List<Map<String, dynamic>>> _transactionsFuture;

  @override
  void initState() {
    super.initState();
    _transactionsFuture = TabunganService.getRecentTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.colors['card'],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(
          color: widget.colors['outline']!,
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
                      Icon(Icons.receipt_long_outlined, size: 24, color: widget.colors['primary']),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          'Transaksi',
                          style: TextStyle(
                            color: widget.colors['text'],
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
                  onPressed: widget.onViewAll,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.only(left: 8, top: 4, bottom: 4),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                  child: Text(
                    'Lihat Semua',
                    style: TextStyle(
                      color: widget.colors['primary'],
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Transaction List
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _transactionsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Gagal memuat transaksi',
                      style: TextStyle(color: widget.colors['error']),
                    ),
                  );
                }

                final transactions = snapshot.data ?? [];
                
                if (transactions.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        'Tidak ada transaksi terbaru',
                        style: TextStyle(
                          color: widget.colors['textTertiary'],
                          fontSize: 13,
                        ),
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  itemCount: transactions.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final transaction = transactions[index];
                    final isExpense = transaction['jenis_transaksi'] == 'tarik';
                    final amount = double.tryParse(transaction['jumlah']?.toString() ?? '0') ?? 0;
                    final date = DateTime.parse(transaction['tanggal_transaksi'] ?? DateTime.now().toString());
                    // Format date without time component
                    final formattedDate = DateFormat('dd MMM yyyy', 'id_ID').format(
                      DateTime(date.year, date.month, date.day)
                    );
                    
                    return Container(
                      decoration: BoxDecoration(
                        color: widget.colors['surface'],
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
                              ? widget.colors['error']!.withOpacity(0.1)
                              : widget.colors['success']!.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            isExpense ? Icons.trending_down : Icons.trending_up,
                            color: isExpense ? widget.colors['error'] : widget.colors['success'],
                            size: 18,
                          ),
                        ),
                        title: Text(
                          isExpense ? 'Penarikan' : 'Setoran',
                          style: TextStyle(
                            color: widget.colors['text'],
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            height: 1.2,
                          ),
                        ),
                        subtitle: Text(
                          formattedDate,
                          style: TextStyle(
                            color: widget.colors['textTertiary'],
                            fontSize: 11,
                            height: 1.2,
                          ),
                        ),
                        trailing: Text(
                          '${isExpense ? '-' : '+'}Rp${NumberFormat('#,###', 'id_ID').format(amount.abs().toInt())}',
                          style: TextStyle(
                            color: isExpense ? widget.colors['error'] : widget.colors['success'],
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
