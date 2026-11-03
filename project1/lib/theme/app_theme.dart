import 'package:flutter/material.dart';

/// Warna mengikuti Style Guide pada DAMA_Business_UI.svg / docs/style-guide.md.
class AppColors {
  AppColors._();

  static const Color teal = Color(0xFF00817A); // warna utama
  static const Color blue = Color(0xFF0F4C81); // warna sekunder
  static const Color lightTeal = Color(0xFF7CC4BE);
  static const Color error = Color(0xFFD72B30); // pengeluaran / peringatan
  static const Color background = Color(0xFFF4F7F6); // abu terang (kotak/tile)
  static const Color textDark = Color(0xFF1B2B2B);
  static const Color textMuted = Color(0xFF6B7B7B);
  static const Color border = Color(0xFFD5DDDD);
}

class AppTheme {
  AppTheme._();

  static const RoundedRectangleBorder _buttonShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
  );

  static OutlineInputBorder _inputBorder(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: AppColors.teal,
        onPrimary: Colors.white,
        secondary: AppColors.blue,
        onSecondary: Colors.white,
        error: AppColors.error,
        onError: Colors.white,
        surface: Colors.white,
        onSurface: AppColors.textDark,
      ),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarThemeData(
        backgroundColor: AppColors.teal,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.border),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.teal,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(52),
          shape: _buttonShape,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.teal,
          minimumSize: const Size.fromHeight(52),
          side: const BorderSide(color: AppColors.teal, width: 1.5),
          shape: _buttonShape,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.teal,
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      inputDecorationTheme: InputDecorationThemeData(
        hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: _inputBorder(AppColors.border),
        enabledBorder: _inputBorder(AppColors.border),
        focusedBorder: _inputBorder(AppColors.teal, width: 2),
        errorBorder: _inputBorder(AppColors.error),
        focusedErrorBorder: _inputBorder(AppColors.error, width: 2),
        errorStyle: const TextStyle(color: AppColors.error),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.textDark,
        contentTextStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}
