import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Banner hijau di bagian atas screen (Create Budget, Analytics, Settings).
class ScreenHeader extends StatelessWidget {
  const ScreenHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      header: true,
      child: Container(
        width: double.infinity,
        color: AppColors.teal,
        padding: EdgeInsets.fromLTRB(
          16,
          MediaQuery.of(context).padding.top + 20,
          16,
          20,
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
