import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../utils/session.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/screen_header.dart';
import 'login_page.dart';

/// Screen 6: Settings & Akun - akun aktif, menu, identitas pengembang, logout.
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const List<String> _menus = [
    'Categories',
    'Export Data',
    'Notifications',
    'Help & Support',
  ];

  void _showComingSoon(BuildContext context, String menu) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$menu belum tersedia pada versi ini')),
    );
  }

  void _logout(BuildContext context) {
    final messenger = ScaffoldMessenger.of(context);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false,
    );
    messenger.showSnackBar(const SnackBar(content: Text('Anda telah logout')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const ScreenHeader(title: 'Settings'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const Text(
                  'Linked Account',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 16,
                        backgroundColor: AppColors.teal,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(child: Text(UserSession.name)),
                      const Text(
                        'Active',
                        style: TextStyle(
                          color: AppColors.teal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                for (final menu in _menus)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Card(
                      child: ListTile(
                        title: Text(menu),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => _showComingSoon(context, menu),
                      ),
                    ),
                  ),
                const SizedBox(height: 6),
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tentang Aplikasi',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text('Expense Tracker v0.2 - Form & Validation'),
                        Text('Nama: Hotijatul Munauwaroh'),
                        Text('NIM: 2410651041'),
                        Text('Target Pengguna: Mahasiswa'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.error,
                    side: const BorderSide(color: AppColors.error, width: 1.5),
                  ),
                  onPressed: () => _logout(context),
                  child: const Text('Logout'),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNav(
        currentIndex: AppBottomNav.settings,
      ),
    );
  }
}
