import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Ikon dan warna untuk kategori (dipisah dari model agar model tetap
/// pure Dart).
class CategoryStyle {
  CategoryStyle._();

  /// Palet warna: urutan 0-3 sama dengan legenda pada UI Blueprint
  /// (Food, Rent, Transportation, Other). Kategori tambahan memakai warna
  /// berikutnya, lalu berulang.
  static const List<Color> palette = [
    AppColors.teal,
    AppColors.blue,
    AppColors.lightTeal,
    AppColors.error,
    Color(0xFFF2A93B),
    Color(0xFF8E6BBF),
    Color(0xFF4F6D7A),
  ];

  static Color colorAt(int index) => palette[index % palette.length];

  static IconData iconFor(String category) {
    final name = category.toLowerCase();
    if (name.contains('food') || name.contains('makan')) {
      return Icons.restaurant;
    }
    if (name.contains('rent') || name.contains('kos')) {
      return Icons.home_outlined;
    }
    if (name.contains('transport')) {
      return Icons.local_gas_station;
    }
    return Icons.receipt_long_outlined;
  }
}
