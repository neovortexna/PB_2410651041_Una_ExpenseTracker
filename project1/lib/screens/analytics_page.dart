import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/charts.dart';
import '../widgets/screen_header.dart';

/// Screen 5: Analytics - Weekly Spending dan Expense Categories.
class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  static const TextStyle _sectionStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );

  static const List<_LegendItem> _legend = [
    _LegendItem('Food & Dining', AppColors.teal, 40),
    _LegendItem('Rent', AppColors.blue, 30),
    _LegendItem('Transportation', AppColors.lightTeal, 18),
    _LegendItem('Other', AppColors.error, 12),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const ScreenHeader(title: 'Analytics'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const Text('Weekly Spending', style: _sectionStyle),
                const SizedBox(height: 16),
                const WeeklyBarChart(
                  values: [40, 70, 55, 100, 65, 45, 85],
                  labels: ['M', 'T', 'W', 'T', 'F', 'S', 'S'],
                  highlightIndex: 3,
                ),
                const SizedBox(height: 28),
                const Text('Expense Categories', style: _sectionStyle),
                const SizedBox(height: 16),
                Row(
                  children: [
                    DonutChart(
                      segments: [
                        for (final item in _legend)
                          DonutSegment(value: item.value, color: item.color),
                      ],
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (final item in _legend)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: item.color,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      item.label,
                                      style: const TextStyle(fontSize: 13),
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
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNav(
        currentIndex: AppBottomNav.analytics,
      ),
    );
  }
}

class _LegendItem {
  const _LegendItem(this.label, this.color, this.value);

  final String label;
  final Color color;
  final double value;
}
