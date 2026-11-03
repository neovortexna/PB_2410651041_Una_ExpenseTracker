import 'package:flutter/material.dart';

import '../models/expense_item.dart';
import '../theme/app_theme.dart';
import '../utils/format.dart';

/// Satu baris pengeluaran: ikon hijau, nama, dan nominal merah (-20.000).
class ExpenseTile extends StatelessWidget {
  const ExpenseTile({super.key, required this.item, this.showCategory = false});

  final ExpenseItem item;
  final bool showCategory;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 15,
            backgroundColor: AppColors.teal,
            child: Icon(item.icon, color: Colors.white, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.textDark,
                  ),
                ),
                if (showCategory)
                  Text(
                    item.category,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                  ),
              ],
            ),
          ),
          Text(
            '-${formatRupiah(item.amount)}',
            style: const TextStyle(
              color: AppColors.error,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
