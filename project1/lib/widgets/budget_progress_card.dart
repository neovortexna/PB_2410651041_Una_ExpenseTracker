import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Kartu progres budget per kategori (Food & Dining 70%, Rent 45%, dst.).
class BudgetProgressCard extends StatelessWidget {
  const BudgetProgressCard({
    super.key,
    required this.label,
    required this.percent,
    required this.color,
  });

  final String label;
  final int percent; // 0-100
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$label, $percent persen dari budget terpakai',
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  Text(
                    '$percent%',
                    style: TextStyle(fontWeight: FontWeight.bold, color: color),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: percent / 100,
                  minHeight: 10,
                  color: color,
                  backgroundColor: AppColors.background,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
