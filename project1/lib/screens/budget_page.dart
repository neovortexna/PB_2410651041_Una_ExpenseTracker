import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../utils/validators.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/budget_progress_card.dart';
import '../widgets/labeled_text_form_field.dart';
import '../widgets/screen_header.dart';

/// Screen 4: Create Budget (Track Budget) dengan tombol + Add Category.
class BudgetPage extends StatelessWidget {
  const BudgetPage({super.key});

  void _showAddCategoryDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => const _AddCategoryDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const ScreenHeader(title: 'Create Budget'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const Text(
                  'Track Budget',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 12),
                const Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: BudgetProgressCard(
                    label: 'Food & Dining',
                    percent: 70,
                    color: AppColors.teal,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: BudgetProgressCard(
                    label: 'Rent',
                    percent: 45,
                    color: AppColors.blue,
                  ),
                ),
                // 90% memakai warna merah sebagai peringatan mendekati limit.
                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: BudgetProgressCard(
                    label: 'Transportation',
                    percent: 90,
                    color: AppColors.error,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _showAddCategoryDialog(context),
                  child: const Text('+ Add Category'),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNav(
        currentIndex: AppBottomNav.budget,
      ),
    );
  }
}

/// Dialog form tambah kategori (2 input tervalidasi).
class _AddCategoryDialog extends StatefulWidget {
  const _AddCategoryDialog();

  @override
  State<_AddCategoryDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<_AddCategoryDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _limitController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _limitController.dispose();
    super.dispose();
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return; // pesan error tampil di bawah masing-masing input

    final name = _nameController.text.trim();
    // Ambil messenger sebelum dialog ditutup agar SnackBar tetap bisa tampil.
    final messenger = ScaffoldMessenger.of(context);
    Navigator.pop(context);
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          'Kategori "$name" valid. Penyimpanan data tersedia pada v0.3',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Tambah Kategori'),
      scrollable: true,
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LabeledTextFormField(
              label: 'Nama kategori',
              hintText: 'Contoh: Hiburan',
              controller: _nameController,
              textInputAction: TextInputAction.next,
              validator: (value) =>
                  Validators.name(value, label: 'Nama kategori'),
            ),
            const SizedBox(height: 16),
            LabeledTextFormField(
              label: 'Batas anggaran (Rp)',
              hintText: 'Contoh: 500000',
              controller: _limitController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              validator: Validators.amount,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        TextButton(onPressed: _submit, child: const Text('Simpan')),
      ],
    );
  }
}
