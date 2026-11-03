import 'package:flutter/material.dart';

import '../models/expense_item.dart';
import '../theme/app_theme.dart';
import '../widgets/expense_tile.dart';

/// Screen "See All": daftar seluruh pengeluaran (mock data statis pada v0.2).
class ExpenseListPage extends StatelessWidget {
  const ExpenseListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Semua Pengeluaran')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Riwayat Pengeluaran',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 12),
            for (final item in sampleExpenses)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: ExpenseTile(item: item, showCategory: true),
              ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // kembali ke Home
              },
              child: const Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}
