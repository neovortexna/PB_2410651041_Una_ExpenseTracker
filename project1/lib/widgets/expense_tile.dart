import 'package:flutter/material.dart';

import '../models/expense_item.dart';
import '../theme/app_theme.dart';
import '../utils/category_style.dart';
import '../utils/format.dart';

/// Satu baris pengeluaran: ikon hijau, nama, dan nominal merah (-20.000).
///
/// Jika [onEdit] / [onDelete] diisi, tombol ubah dan hapus ikut ditampilkan
/// (dipakai pada halaman Semua Pengeluaran untuk Update dan Delete).
class ExpenseTile extends StatelessWidget {
  const ExpenseTile({
    super.key,
    required this.item,
    this.showCategory = false,
    this.onEdit,
    this.onDelete,
  });

  final ExpenseItem item;
  final bool showCategory;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        12,
        12,
        (onEdit != null || onDelete != null) ? 4 : 12,
        12,
      ),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 15,
            backgroundColor: AppColors.teal,
            child: Icon(
              CategoryStyle.iconFor(item.category),
              color: Colors.white,
              size: 16,
            ),
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
                    '${item.category} • ${formatDate(item.date)}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '-${formatRupiah(item.amount)}',
            style: const TextStyle(
              color: AppColors.error,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (onEdit != null)
            IconButton(
              tooltip: 'Ubah ${item.title}',
              visualDensity: VisualDensity.compact,
              onPressed: onEdit,
              icon: const Icon(Icons.edit_outlined, size: 20),
              color: AppColors.blue,
            ),
          if (onDelete != null)
            IconButton(
              tooltip: 'Hapus ${item.title}',
              visualDensity: VisualDensity.compact,
              onPressed: onDelete,
              icon: const Icon(Icons.delete_outline, size: 20),
              color: AppColors.error,
            ),
        ],
      ),
    );
  }
}
