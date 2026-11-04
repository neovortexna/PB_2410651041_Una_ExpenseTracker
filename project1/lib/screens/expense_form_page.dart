import 'package:flutter/material.dart';

import '../data/expense_store.dart';
import '../models/expense_item.dart';
import '../theme/app_theme.dart';
import '../utils/validators.dart';
import '../widgets/labeled_text_form_field.dart';

/// Screen "Tambah / Ubah Pengeluaran".
///
/// - Form & Validation v0.2 (BAB 6): Form, GlobalKey<FormState>,
///   TextFormField + validator, pesan error, SnackBar, setState.
/// - Data Module v0.3 (BAB 7): input yang VALID kini disimpan ke
///   [ExpenseStore] (Create) atau memperbarui data lama (Update).
///
/// Mode ditentukan oleh [expense]:
///  - null     -> Create (tombol (+) di bottom nav / tombol tambah di daftar)
///  - ada isi  -> Update (tombol ubah pada daftar pengeluaran)
class ExpenseFormPage extends StatefulWidget {
  const ExpenseFormPage({super.key, this.expense});

  final ExpenseItem? expense;

  @override
  State<ExpenseFormPage> createState() => _ExpenseFormPageState();
}

class _ExpenseFormPageState extends State<ExpenseFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _amountController;

  String? _selectedCategory;
  String _statusMessage = 'Belum ada data yang diproses';

  bool get _isEdit => widget.expense != null;

  @override
  void initState() {
    super.initState();
    final expense = widget.expense;
    _titleController = TextEditingController(text: expense?.title ?? '');
    _amountController = TextEditingController(
      text: expense == null ? '' : expense.amount.toString(),
    );
    _selectedCategory = expense?.category;
  }

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
    final category = _selectedCategory!;
    final store = ExpenseStore.instance;

    final String feedback;
    final existing = widget.expense;
    if (existing != null) {
      // UPDATE: ganti data lama (id sama) dengan nilai baru dari form.
      store.updateExpense(
        existing.copyWith(title: title, amount: amount, category: category),
      );
      feedback = 'Data berhasil diperbarui';
    } else {
      // CREATE: tambah data baru ke list di ExpenseStore.
      store.addExpense(title: title, amount: amount, category: category);
      feedback = 'Data berhasil ditambahkan';
    }

    // Ambil messenger sebelum screen ditutup agar SnackBar tetap tampil di
    // screen sebelumnya.
    final messenger = ScaffoldMessenger.of(context);
    Navigator.pop(context);
    messenger.showSnackBar(SnackBar(content: Text(feedback)));
  }

  @override
  Widget build(BuildContext context) {
    final names = ExpenseStore.instance.categories.map((c) => c.name).toList();
    // Jaga-jaga: kategori yang sedang dipilih harus ada di daftar dropdown.
    if (_selectedCategory != null && !names.contains(_selectedCategory)) {
      names.add(_selectedCategory!);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? 'Ubah Pengeluaran' : 'Tambah Pengeluaran'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Text(
                  _isEdit ? 'Ubah Data Pengeluaran' : 'Form Pengeluaran',
                  style: const TextStyle(
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
                  items: names
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
                if (names.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: Text(
                      'Belum ada kategori. Tambahkan dulu di menu Budget.',
                      style: TextStyle(color: AppColors.textMuted),
                    ),
                  ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text(_isEdit ? 'Simpan Perubahan' : 'Simpan'),
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
