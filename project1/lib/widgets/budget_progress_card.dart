import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Kartu progres budget per kategori (Food & Dining 70%, Rent 45%, dst.).
///
/// [onEdit] / [onDelete] bersifat opsional: bila diisi, tombol ubah dan hapus
/// kategori ditampilkan (CRUD kategori pada BAB 7).
class BudgetProgressCard extends StatelessWidget {
  const BudgetProgressCard({
    super.key,
    required this.label,
    required this.percent,
    required this.color,
    this.detail,
    this.onEdit,
    this.onDelete,
  });

  final String label;
  final int percent; // boleh > 100 jika pengeluaran melebihi batas
  final Color color;
  final String? detail; // mis. "Rp 35.000 dari Rp 50.000"
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$label, $percent persen dari budget terpakai',
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 8, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      label,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                  ),
                  Text(
                    '$percent%',
                    style: TextStyle(fontWeight: FontWeight.bold, color: color),
                  ),
                  if (onEdit != null)
                    IconButton(
                      tooltip: 'Ubah kategori $label',
                      visualDensity: VisualDensity.compact,
                      onPressed: onEdit,
                      icon: const Icon(Icons.edit_outlined, size: 20),
                      color: AppColors.blue,
                    ),
                  if (onDelete != null)
                    IconButton(
                      tooltip: 'Hapus kategori $label',
                      visualDensity: VisualDensity.compact,
                      onPressed: onDelete,
                      icon: const Icon(Icons.delete_outline, size: 20),
                      color: AppColors.error,
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8, top: 2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: (percent / 100).clamp(0.0, 1.0).toDouble(),
                    minHeight: 10,
                    color: color,
                    backgroundColor: AppColors.background,
                  ),
                ),
              ),
              if (detail != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8, right: 8),
                  child: Text(
                    detail!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
