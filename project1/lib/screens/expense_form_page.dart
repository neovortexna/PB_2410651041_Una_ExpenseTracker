import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../utils/format.dart';
import '../utils/validators.dart';
import '../widgets/labeled_text_form_field.dart';

/// Screen "Tambah Pengeluaran" - Form & Validation v0.2 (BAB 6).
///
/// Dibuka dari tombol (+) pada bottom navigation. Input yang valid ditampilkan
/// sebagai status + SnackBar. Penyimpanan ke list (CRUD) baru dikerjakan di
/// BAB 7 (Data Module v0.3).
class ExpenseFormPage extends StatefulWidget {
  const ExpenseFormPage({super.key});

  @override
  State<ExpenseFormPage> createState() => _ExpenseFormPageState();
}

class _ExpenseFormPageState extends State<ExpenseFormPage> {
  static const List<String> _categories = [
    'Food & Dining',
    'Rent',
    'Transportation',
    'Other',
  ];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  String? _selectedCategory;
  String _statusMessage = 'Belum ada data yang diproses';

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      setState(() {
        _statusMessage = 'Periksa kembali input yang belum valid';
      });
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Input belum valid')));
      }
      return;
    }

    final title = _titleController.text.trim();
    final amount = int.parse(_amountController.text.trim());

    setState(() {
      _statusMessage =
          'Data valid: $title (Rp ${formatRupiah(amount)}) - $_selectedCategory';
    });
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Data berhasil diproses')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Pengeluaran')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const Text(
                  'Form Pengeluaran',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 16),
                LabeledTextFormField(
                  label: 'Nama pengeluaran',
                  hintText: 'Contoh: Makan siang',
                  controller: _titleController,
                  textInputAction: TextInputAction.next,
                  validator: (value) =>
                      Validators.name(value, label: 'Nama pengeluaran'),
                ),
                const SizedBox(height: 16),
                LabeledTextFormField(
                  label: 'Nominal (Rp)',
                  hintText: 'Contoh: 20000',
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  validator: Validators.amount,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Kategori',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  initialValue: _selectedCategory,
                  isExpanded: true,
                  hint: const Text('Pilih kategori'),
                  items: _categories
                      .map(
                        (category) => DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                  validator: Validators.category,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Simpan'),
                ),
                const SizedBox(height: 12),
                Text(
                  _statusMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.textMuted),
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context); // kembali ke screen sebelumnya
                  },
                  child: const Text('Kembali'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
