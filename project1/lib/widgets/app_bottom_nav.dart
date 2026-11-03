import 'package:flutter/material.dart';

import '../screens/analytics_page.dart';
import '../screens/budget_page.dart';
import '../screens/expense_form_page.dart';
import '../screens/home_page.dart';
import '../screens/settings_page.dart';
import '../theme/app_theme.dart';

/// Floating Bottom Navigation Bar dengan tombol (+) di tengah.
///
/// Urutan ikon mengikuti wireframe: Home, Folder, (+), Wallet, Profile.
///  - Home    -> HomePage
///  - Folder  -> AnalyticsPage
///  - (+)     -> ExpenseFormPage  (Navigator.push, kembali dengan pop)
///  - Wallet  -> BudgetPage
///  - Profile -> SettingsPage
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key, required this.currentIndex});

  final int currentIndex;

  static const int home = 0;
  static const int analytics = 1;
  static const int add = 2;
  static const int budget = 3;
  static const int settings = 4;

  void _onTap(BuildContext context, int index) {
    if (index == add) {
      // push: form dibuka di atas screen saat ini, lalu bisa kembali (pop).
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ExpenseFormPage()),
      );
      return;
    }
    if (index == currentIndex) return;

    final Widget page;
    switch (index) {
      case home:
        page = const HomePage();
        break;
      case analytics:
        page = const AnalyticsPage();
        break;
      case budget:
        page = const BudgetPage();
        break;
      default:
        page = const SettingsPage();
    }
    // Perpindahan antar tab utama menggantikan screen agar stack tidak menumpuk.
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  Widget _item(
    BuildContext context, {
    required int index,
    required IconData icon,
    required String label,
  }) {
    final selected = index == currentIndex;
    return IconButton(
      tooltip: label,
      onPressed: () => _onTap(context, index),
      icon: Icon(
        icon,
        size: 26,
        color: selected ? Colors.white : Colors.white70,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: Material(
          color: AppColors.teal,
          elevation: 6,
          borderRadius: BorderRadius.circular(32),
          child: SizedBox(
            height: 64,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _item(
                  context,
                  index: home,
                  icon: Icons.home_outlined,
                  label: 'Home',
                ),
                _item(
                  context,
                  index: analytics,
                  icon: Icons.folder_outlined,
                  label: 'Analytics',
                ),
                IconButton(
                  tooltip: 'Tambah pengeluaran',
                  onPressed: () => _onTap(context, add),
                  style: IconButton.styleFrom(
                    side: const BorderSide(color: Colors.white, width: 2),
                    padding: const EdgeInsets.all(8),
                  ),
                  icon: const Icon(Icons.add, color: Colors.white, size: 28),
                ),
                _item(
                  context,
                  index: budget,
                  icon: Icons.account_balance_wallet_outlined,
                  label: 'Budget',
                ),
                _item(
                  context,
                  index: settings,
                  icon: Icons.person_outline,
                  label: 'Settings',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
