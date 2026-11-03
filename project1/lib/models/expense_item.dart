import 'package:flutter/material.dart';

/// Data pengeluaran sederhana untuk tampilan (Navigation v0.1 / Form v0.2).
///
/// Data di bawah ini adalah MOCK DATA (simulasi, bukan data pribadi nyata).
/// Pada BAB 7 (Data Module v0.3) model ini akan dikembangkan menjadi model
/// dengan `id` dan list yang bisa ditambah, diubah, dan dihapus (CRUD).
class ExpenseItem {
  const ExpenseItem({
    required this.title,
    required this.amount,
    required this.category,
    required this.icon,
  });

  final String title;
  final int amount; // dalam Rupiah
  final String category;
  final IconData icon;
}

const List<ExpenseItem> sampleExpenses = [
  ExpenseItem(
    title: 'Makan',
    amount: 20000,
    category: 'Food & Dining',
    icon: Icons.restaurant,
  ),
  ExpenseItem(
    title: 'Bensin',
    amount: 50000,
    category: 'Transportation',
    icon: Icons.local_gas_station,
  ),
  ExpenseItem(
    title: 'Kuota Internet',
    amount: 25000,
    category: 'Other',
    icon: Icons.wifi,
  ),
  ExpenseItem(
    title: 'Bayar Kos',
    amount: 700000,
    category: 'Rent',
    icon: Icons.home_outlined,
  ),
  ExpenseItem(
    title: 'Makan Siang',
    amount: 15000,
    category: 'Food & Dining',
    icon: Icons.restaurant,
  ),
];
