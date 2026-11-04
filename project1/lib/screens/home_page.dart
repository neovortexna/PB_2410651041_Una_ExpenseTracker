import 'package:flutter/material.dart';

import '../data/expense_store.dart';
import '../theme/app_theme.dart';
import '../utils/format.dart';
import '../utils/session.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/charts.dart';
import '../widgets/empty_state.dart';
import '../widgets/expense_tile.dart';
import 'expense_form_page.dart';
import 'expense_list_page.dart';

/// Screen 3: Home Dashboard - ringkasan Total Spent dan Recent Expenses.
///
/// Pada v0.3 seluruh angka dan daftar dihitung dari [ExpenseStore], sehingga
/// otomatis berubah setelah pengguna menambah, mengubah, atau menghapus data.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = ExpenseStore.instance;

    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          listenable: store,
          builder: (context, _) {
            final recent = store.recentExpenses(2);
            final trend = store
                .dailyTotals(7)
                .map((value) => value.toDouble())
                .toList();

            return ListView(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
              children: [
                Text(
                  'Welcome, ${UserSession.name}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 24),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total Spent',
                          style: TextStyle(color: AppColors.textMuted),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Rp ${formatRupiah(store.totalSpent)}',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (store.expenses.isEmpty)
                          const Text(
                            'Belum ada pengeluaran yang dicatat.',
                            style: TextStyle(color: AppColors.textMuted),
                          )
                        else
                          SpendingLineChart(values: trend),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Recent Expenses',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ExpenseListPage(),
                          ),
                        );
                      },
                      child: const Text('See All'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (recent.isEmpty)
                  EmptyState(
                    icon: Icons.receipt_long_outlined,
                    message: 'Belum ada data. Silakan tambahkan data baru.',
                    actionLabel: 'Tambah Pengeluaran',
                    onAction: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ExpenseFormPage(),
                        ),
                      );
                    },
                  )
                else
                  for (final item in recent)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: ExpenseTile(item: item),
                    ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: AppBottomNav.home),
    );
  }
}
