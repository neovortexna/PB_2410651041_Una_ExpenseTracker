import 'package:flutter/material.dart';

import '../data/expense_store.dart';
import '../models/budget_category.dart';
import '../theme/app_theme.dart';
import '../utils/format.dart';
import '../utils/validators.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/budget_progress_card.dart';
import '../widgets/confirm_delete_dialog.dart';
import '../widgets/empty_state.dart';
import '../widgets/labeled_text_form_field.dart';
import '../widgets/screen_header.dart';

/// Screen 4: Create Budget (Track Budget) - CRUD kategori budget (BAB 7).
///
/// - READ   : daftar kategori + progres (pengeluaran / batas anggaran).
/// - CREATE : tombol "+ Add Category" membuka dialog form tervalidasi.
/// - UPDATE : tombol pensil pada kartu membuka dialog berisi data lama.
/// - DELETE : tombol tempat sampah -> konfirmasi -> hapus. Kategori yang
///   masih dipakai pengeluaran tidak boleh dihapus.
class BudgetPage extends StatelessWidget {
  const BudgetPage({super.key});

  void _showCategoryDialog(BuildContext context, {BudgetCategory? category}) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => _CategoryDialog(category: category),
    );
  }

  Future<void> _deleteCategory(
    BuildContext context,
    BudgetCategory category,
  ) async {
    final store = ExpenseStore.instance;
    final messenger = ScaffoldMessenger.of(context);

    final usedBy = store.expenseCountFor(category.name);
    if (usedBy > 0) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            'Kategori "${category.name}" masih dipakai $usedBy pengeluaran. '
            'Ubah atau hapus pengeluaran tersebut terlebih dahulu.',
          ),
        ),
      );
      return;
    }

    final confirmed = await confirmDelete(
      context,
      message: 'Hapus kategori "${category.name}"?',
    );
    if (!confirmed) return;

    store.deleteCategory(category.id);
    messenger.showSnackBar(
      const SnackBar(content: Text('Data berhasil dihapus')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = ExpenseStore.instance;

    return Scaffold(
      body: Column(
        children: [
          const ScreenHeader(title: 'Create Budget'),
          Expanded(
            child: ListenableBuilder(
              listenable: store,
              builder: (context, _) {
                final categories = store.categories;

                return ListView(
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
                    if (categories.isEmpty)
                      const EmptyState(
                        icon: Icons.account_balance_wallet_outlined,
                        message:
                            'Belum ada kategori. Silakan tambahkan data baru.',
                      )
                    else
                      for (var i = 0; i < categories.length; i++)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _buildCard(context, store, categories[i], i),
                        ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () => _showCategoryDialog(context),
                      child: const Text('+ Add Category'),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNav(
        currentIndex: AppBottomNav.budget,
      ),
    );
  }

  Widget _buildCard(
    BuildContext context,
    ExpenseStore store,
    BudgetCategory category,
    int index,
  ) {
    final spent = store.spentIn(category.name);
    final percent = category.limit > 0
        ? (spent * 100 / category.limit).round()
        : 0;
    // >= 90% memakai warna merah sebagai peringatan mendekati/melewati limit.
    final color = percent >= 90
        ? AppColors.error
        : (index.isEven ? AppColors.teal : AppColors.blue);

    return BudgetProgressCard(
      label: category.name,
      percent: percent,
      color: color,
      detail:
          'Rp ${formatRupiah(spent)} dari Rp ${formatRupiah(category.limit)}',
      onEdit: () => _showCategoryDialog(context, category: category),
      onDelete: () => _deleteCategory(context, category),
    );
  }
}

/// Dialog form tambah/ubah kategori (2 input tervalidasi, BAB 6 + BAB 7).
class _CategoryDialog extends StatefulWidget {
  const _CategoryDialog({this.category});

  final BudgetCategory? category;

  @override
  State<_CategoryDialog> createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<_CategoryDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _limitController;

  bool get _isEdit => widget.category != null;

  @override
  void initState() {
    super.initState();
    final category = widget.category;
    _nameController = TextEditingController(text: category?.name ?? '');
    _limitController = TextEditingController(
      text: category == null ? '' : category.limit.toString(),
    );
  }

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
    final limit = int.parse(_limitController.text.trim());
    final store = ExpenseStore.instance;
    final existing = widget.category;

    final String feedback;
    if (existing != null) {
      store.updateCategory(existing.copyWith(name: name, limit: limit));
      feedback = 'Data berhasil diperbarui';
    } else {
      store.addCategory(name: name, limit: limit);
      feedback = 'Data berhasil ditambahkan';
    }

    // Ambil messenger sebelum dialog ditutup agar SnackBar tetap bisa tampil.
    final messenger = ScaffoldMessenger.of(context);
    Navigator.pop(context);
    messenger.showSnackBar(SnackBar(content: Text(feedback)));
  }

  @override
  Widget build(BuildContext context) {
    // Nama yang sudah dipakai kategori LAIN (nama sendiri boleh tetap sama).
    final otherNames = ExpenseStore.instance.categories
        .where((c) => c.id != widget.category?.id)
        .map((c) => c.name);

    return AlertDialog(
      title: Text(_isEdit ? 'Ubah Kategori' : 'Tambah Kategori'),
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
                  Validators.uniqueName(value, existing: otherNames),
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
