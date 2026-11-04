import 'package:flutter/material.dart';

import '../data/expense_store.dart';
import '../models/expense_item.dart';
import '../theme/app_theme.dart';
import '../utils/format.dart';
import '../widgets/confirm_delete_dialog.dart';
import '../widgets/empty_state.dart';
import '../widgets/expense_tile.dart';
import 'expense_form_page.dart';

/// Screen "See All": daftar seluruh pengeluaran (Data Module v0.3 / BAB 7).
///
/// - READ   : daftar dari ExpenseStore ditampilkan dengan ListView.builder.
/// - CREATE : tombol (+) membuka ExpenseFormPage.
/// - UPDATE : tombol pensil membuka ExpenseFormPage berisi data lama.
/// - DELETE : tombol tempat sampah -> dialog konfirmasi -> hapus.
/// - Empty state tampil jika data kosong.
class ExpenseListPage extends StatelessWidget {
  const ExpenseListPage({super.key});

  void _openForm(BuildContext context, {ExpenseItem? expense}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExpenseFormPage(expense: expense),
      ),
    );
  }

  Future<void> _delete(BuildContext context, ExpenseItem item) async {
    final confirmed = await confirmDelete(
      context,
      message: 'Hapus pengeluaran "${item.title}"?',
    );
    if (!confirmed || !context.mounted) return;

    ExpenseStore.instance.deleteExpense(item.id);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Data berhasil dihapus')));
  }

  @override
  Widget build(BuildContext context) {
    final store = ExpenseStore.instance;

    return Scaffold(
      appBar: AppBar(title: const Text('Semua Pengeluaran')),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: store,
          builder: (context, _) {
            final items = store.expenses;

            if (items.isEmpty) {
              return EmptyState(
                icon: Icons.receipt_long_outlined,
                message: 'Belum ada data. Silakan tambahkan data baru.',
                actionLabel: 'Tambah Pengeluaran',
                onAction: () => _openForm(context),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 96),
              // +2: header di atas dan tombol "Kembali" di bawah daftar.
              itemCount: items.length + 2,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Riwayat Pengeluaran',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${items.length} data • Total Rp '
                          '${formatRupiah(store.totalSpent)}',
                          style: const TextStyle(color: AppColors.textMuted),
                        ),
                      ],
                    ),
                  );
                }
                if (index == items.length + 1) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // kembali ke Home
                      },
                      child: const Text('Kembali'),
                    ),
                  );
                }
                final item = items[index - 1];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: ExpenseTile(
                    item: item,
                    showCategory: true,
                    onEdit: () => _openForm(context, expense: item),
                    onDelete: () => _delete(context, item),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Tambah pengeluaran',
        backgroundColor: AppColors.teal,
        foregroundColor: Colors.white,
        onPressed: () => _openForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
