import 'package:flutter/material.dart';

import '../data/expense_store.dart';
import '../theme/app_theme.dart';
import '../utils/category_style.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/charts.dart';
import '../widgets/empty_state.dart';
import '../widgets/screen_header.dart';

/// Screen 5: Analytics - Weekly Spending dan Expense Categories.
///
/// Grafik dihitung dari data di [ExpenseStore] (7 hari terakhir dan total per
/// kategori), bukan lagi angka statis.
class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  static const TextStyle _sectionStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );

  /// Inisial hari: Senin = M, Selasa = T, dst. (index = weekday - 1).
  static const List<String> _weekdayLabels = [
    'M', 'T', 'W', 'T', 'F', 'S', 'S', //
  ];

  @override
  Widget build(BuildContext context) {
    final store = ExpenseStore.instance;

    return Scaffold(
      body: Column(
        children: [
          const ScreenHeader(title: 'Analytics'),
          Expanded(
            child: ListenableBuilder(
              listenable: store,
              builder: (context, _) {
                if (store.expenses.isEmpty) {
                  return const EmptyState(
                    icon: Icons.bar_chart_outlined,
                    message:
                        'Belum ada data untuk dianalisis. Tambahkan '
                        'pengeluaran terlebih dahulu.',
                  );
                }
                return _buildContent(store);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNav(
        currentIndex: AppBottomNav.analytics,
      ),
    );
  }

  Widget _buildContent(ExpenseStore store) {
    // Weekly Spending: total per hari selama 7 hari terakhir.
    final days = ExpenseStore.lastDays(7);
    final totals = store.dailyTotals(7);
    final values = totals.map((v) => v.toDouble()).toList();
    final labels = days.map((d) => _weekdayLabels[d.weekday - 1]).toList();
    var highlight = 0;
    for (var i = 1; i < totals.length; i++) {
      if (totals[i] > totals[highlight]) highlight = i;
    }

    // Expense Categories: total per kategori + persentase.
    final categoryNames = store.categories.map((c) => c.name).toList();
    final byCategory = store.totalsByCategory();
    final grandTotal = byCategory.values.fold(0, (sum, v) => sum + v);

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text('Weekly Spending', style: _sectionStyle),
        const SizedBox(height: 16),
        WeeklyBarChart(
          values: values,
          labels: labels,
          highlightIndex: totals[highlight] > 0 ? highlight : null,
        ),
        const SizedBox(height: 28),
        const Text('Expense Categories', style: _sectionStyle),
        const SizedBox(height: 16),
        Row(
          children: [
            DonutChart(
              segments: [
                for (final entry in byCategory.entries)
                  DonutSegment(
                    value: entry.value.toDouble(),
                    color: CategoryStyle.colorAt(
                      categoryNames.indexOf(entry.key),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final entry in byCategory.entries)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: CategoryStyle.colorAt(
                                categoryNames.indexOf(entry.key),
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              entry.key,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                          Text(
                            '${(entry.value * 100 / grandTotal).round()}%',
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
