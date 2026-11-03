import 'package:flutter/material.dart';

import '../models/expense_item.dart';
import '../theme/app_theme.dart';
import '../utils/session.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/charts.dart';
import '../widgets/expense_tile.dart';
import 'expense_list_page.dart';

/// Screen 3: Home Dashboard - ringkasan Total Spent dan Recent Expenses.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final recent = sampleExpenses.take(2).toList();

    return Scaffold(
      body: SafeArea(
        child: ListView(
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
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Spent',
                      style: TextStyle(color: AppColors.textMuted),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Rp 2.000.000',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    SizedBox(height: 16),
                    SpendingLineChart(values: [20, 45, 35, 70, 55, 90]),
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
            for (final item in recent)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: ExpenseTile(item: item),
              ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: AppBottomNav.home),
    );
  }
}
