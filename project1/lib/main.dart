import 'package:flutter/material.dart';

import 'screens/login_page.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      // Screen awal mengikuti alur UI Blueprint: Welcome (Sign In).
      home: const LoginPage(),
    );
  }
}
