import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Dialog konfirmasi sebelum menghapus data (BAB 7, E.11).
///
/// Mengembalikan `true` jika pengguna menekan "Hapus", dan `false` jika
/// menekan "Batal" atau menutup dialog.
Future<bool> confirmDelete(
  BuildContext context, {
  required String message,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Batal'),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Hapus'),
          ),
        ],
      );
    },
  );
  return result ?? false;
}
