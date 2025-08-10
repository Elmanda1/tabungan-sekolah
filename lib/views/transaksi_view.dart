import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/appconfig.dart';
import '../components/nav_bar.dart';

class TransaksiView extends StatefulWidget {
  const TransaksiView({super.key});

  @override
  State<TransaksiView> createState() => _TransaksiViewState();
}

class _TransaksiViewState extends State<TransaksiView> {
  final TextEditingController _jumlahUangController = TextEditingController();
  final TextEditingController _keteranganController = TextEditingController();
  String _selectedTipeTransaksi = 'setor';

  @override
  void dispose() {
    _jumlahUangController.dispose();
    _keteranganController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.watch<AppConfig>().colorPalette;
    
    return Scaffold(
      backgroundColor: colors['background'],
      appBar: AppBar(
        backgroundColor: colors['background'],
        elevation: 0,
        title: const Text('Tambah Transaksi'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Saldo Card
            Container(
              margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: colors['primary'],
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.wallet_outlined,
                        size: 32,
                        color: colors['text'],
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Saldo saat ini',
                        style: TextStyle(
                          color: colors['text'],
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: Text(
                      'Rp 10.000.000',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: colors['text'],
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Transaction Form Card
            Container(
              margin: const EdgeInsets.all(25),
              child: Card(
                color: colors['card'],
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                  side: BorderSide(
                    color: colors['outline']!,
                    width: 0.5,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tipe Transaksi
                      Text(
                        'Tipe Transaksi',
                        style: TextStyle(
                          color: colors['textSecondary'],
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: colors['outline']!,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(11),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: _selectedTipeTransaksi,
                          icon: Icon(Icons.keyboard_arrow_down, color: colors['text']),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(
                            color: colors['text'],
                            fontSize: 16,
                          ),
                          underline: const SizedBox(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedTipeTransaksi = newValue!;
                            });
                          },
                          items: <String>['setor', 'tarik']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value == 'setor' ? 'Setor Tunai' : 'Tarik Tunai',
                                style: TextStyle(
                                  color: colors['text'],
                                  fontSize: 16,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      // Jumlah Uang
                      const SizedBox(height: 20),
                      Text(
                        'Jumlah Uang',
                        style: TextStyle(
                          color: colors['textSecondary'],
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: colors['outline']!,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(11),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _jumlahUangController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Masukkan jumlah uang',
                                  hintStyle: TextStyle(
                                    color: colors['textSecondary'],
                                    fontSize: 16,
                                    height: 1.5,
                                  ),
                                  prefixText: 'Rp ',
                                  prefixStyle: TextStyle(
                                    color: colors['text'],
                                    fontSize: 16,
                                    height: 1.5,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                                  isDense: true,
                                  suffixIcon: _jumlahUangController.text.isNotEmpty
                                      ? Padding(
                                          padding: const EdgeInsets.only(right: 4),
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.clear,
                                              color: colors['textSecondary'],
                                              size: 20,
                                            ),
                                            padding: EdgeInsets.zero,
                                            constraints: const BoxConstraints(),
                                            onPressed: () {
                                              setState(() {
                                                _jumlahUangController.clear();
                                              });
                                            },
                                          ),
                                        )
                                      : null,
                                ),
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  color: colors['text'],
                                  fontSize: 16,
                                  height: 1.5,
                                ),
                                onChanged: (_) => setState(() {}),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Quick Amount Buttons
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildAmountChip(
                              amount: 10000,
                              colors: colors,
                              onTap: () => _updateAmount(10000),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildAmountChip(
                              amount: 20000,
                              colors: colors,
                              onTap: () => _updateAmount(20000),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _buildAmountChip(
                              amount: 50000,
                              colors: colors,
                              onTap: () => _updateAmount(50000),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildAmountChip(
                              amount: 100000,
                              colors: colors,
                              onTap: () => _updateAmount(100000),
                            ),
                          ),
                        ],
                      ),

                      // Keterangan
                      const SizedBox(height: 20),
                      Text(
                        'Keterangan (opsional)',
                        style: TextStyle(
                          color: colors['textSecondary'],
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: colors['outline']!,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: TextField(
                          controller: _keteranganController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(16),
                            border: InputBorder.none,
                            hintText: 'Tulis keterangan transaksi',
                            hintStyle: TextStyle(
                              color: colors['textSecondary'],
                            ),
                          ),
                          style: TextStyle(
                            color: colors['text'],
                            fontSize: 16,
                          ),
                        ),
                      ),

                      // Submit Button
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _submitTransaction,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colors['primary'],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11),
                            ),
                            elevation: 0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.check_circle_outline,
                                color: colors['text'],
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Konfirmasi Transaksi',
                                style: TextStyle(
                                  color: colors['text'],
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentRoute: '/transaksi',
        onItemTapped: (route) {
          if (route != '/transaksi') {
            Navigator.pushReplacementNamed(context, route);
          }
        },
      ),
    );
  }

  void _updateAmount(int amount) {
    final currentValue = int.tryParse(_jumlahUangController.text) ?? 0;
    setState(() {
      _jumlahUangController.text = (currentValue + amount).toString();
    });
  }

  void _submitTransaction() {
    // Handle transaction submission
    // TODO: Implement transaction submission logic
  }

  Widget _buildAmountChip({
    required int amount,
    required Map<String, Color?> colors,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: colors['card'],
          border: Border.all(
            color: colors['outline']!,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(11),
        ),
        child: Text(
          textAlign: TextAlign.center,
          'Rp${amount.toString().replaceAllMapped(
                RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
                (match) => '${match[1]}.',
              )}',
          style: TextStyle(
            color: colors['text'],
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
