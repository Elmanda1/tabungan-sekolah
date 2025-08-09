import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../models/appconfig.dart';
import '../components/nav_bar.dart';

class TransaksiView extends StatefulWidget {
  const TransaksiView({super.key});

  @override
  State<TransaksiView> createState() => _TransaksiViewState();
}

class _TransaksiViewState extends State<TransaksiView> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  
  String _selectedType = 'expense';
  String _selectedCategory = 'Food';
  DateTime _selectedDate = DateTime.now();
  bool _isLoading = false;

  final List<String> _expenseCategories = [
    'Food',
    'Shopping',
    'Transportation',
    'Bills',
    'Entertainment',
    'Other'
  ];

  final List<String> _incomeCategories = [
    'Salary',
    'Freelance',
    'Gift',
    'Investment',
    'Other Income'
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
              onPrimary: Colors.white,
              surface: Colors.grey[800]!,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      // Simulate API call
      Future.delayed(const Duration(seconds: 1), () {
        setState(() => _isLoading = false);
        
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Transaction added successfully!'),
            backgroundColor: Theme.of(context).primaryColor,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
        
        // Clear form
        _titleController.clear();
        _amountController.clear();
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.watch<AppConfig>().colorPalette;
    
    return Scaffold(
      backgroundColor: colors['background'],
      bottomNavigationBar: BottomNavBar(
        currentRoute: '/transaksi',
        onItemTapped: (route) {
          if (route != '/transaksi') {
            Navigator.pushReplacementNamed(context, route);
          }
        },
      ),
      appBar: AppBar(
        backgroundColor: colors['background'],
        elevation: 0,
        title: Text(
          'Add Transaction',
          style: TextStyle(
            color: colors['text'],
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
          color: colors['text'],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Transaction Type Toggle
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                decoration: BoxDecoration(
                  color: colors['surface'],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: ChoiceChip(
                        label: const Text('Expense'),
                        selected: _selectedType == 'expense',
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              _selectedType = 'expense';
                              _selectedCategory = _expenseCategories.first;
                            });
                          }
                        },
                        backgroundColor: colors['surface'],
                        selectedColor: colors['error']!.withOpacity(0.2),
                        labelStyle: TextStyle(
                          color: _selectedType == 'expense' 
                              ? colors['error'] 
                              : colors['textSecondary'],
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ChoiceChip(
                        label: const Text('Income'),
                        selected: _selectedType == 'income',
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              _selectedType = 'income';
                              _selectedCategory = _incomeCategories.first;
                            });
                          }
                        },
                        backgroundColor: colors['surface'],
                        selectedColor: colors['success']!.withOpacity(0.2),
                        labelStyle: TextStyle(
                          color: _selectedType == 'income' 
                              ? colors['success'] 
                              : colors['textSecondary'],
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Amount Input
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: colors['text'],
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  labelText: 'Amount',
                  labelStyle: TextStyle(
                    color: colors['textSecondary'],
                    fontSize: 16,
                  ),
                  prefixText: '\$ ',
                  prefixStyle: TextStyle(
                    color: colors['text'],
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: colors['divider']!,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: colors['primary']!,
                      width: 2,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 24),
              
              // Title Input
              TextFormField(
                controller: _titleController,
                style: TextStyle(color: colors['text']),
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(color: colors['textSecondary']),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colors['divider']!), 
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colors['divider']!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colors['primary']!),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              // Category Dropdown
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                items: (_selectedType == 'expense' 
                        ? _expenseCategories 
                        : _incomeCategories)
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(
                            category,
                            style: TextStyle(color: colors['text']),
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
                dropdownColor: colors['surface'],
                decoration: InputDecoration(
                  labelText: 'Category',
                  labelStyle: TextStyle(color: colors['textSecondary']),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colors['divider']!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colors['divider']!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colors['primary']!),
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Date Picker
              TextFormField(
                readOnly: true,
                controller: TextEditingController(
                  text: DateFormat('EEEE, MMM d, y').format(_selectedDate),
                ),
                style: TextStyle(color: colors['text']),
                decoration: InputDecoration(
                  labelText: 'Date',
                  labelStyle: TextStyle(color: colors['textSecondary']),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colors['divider']!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colors['divider']!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colors['primary']!),
                  ),
                  suffixIcon: Icon(
                    Icons.calendar_today,
                    color: colors['textSecondary'],
                  ),
                ),
                onTap: () => _selectDate(context),
              ),
              
              const SizedBox(height: 32),
              
              // Submit Button
              SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors['primary'],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(
                          'ADD TRANSACTION',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
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
