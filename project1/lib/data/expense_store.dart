import 'dart:collection';

import 'package:flutter/foundation.dart';

import '../models/budget_category.dart';
import '../models/expense_item.dart';

/// Penyimpanan data SEMENTARA di memori (local/mock data) untuk BAB 7.
///
/// - Data disimpan di dalam `List` selama aplikasi berjalan dan akan kembali
///   ke mock data saat aplikasi dimuat ulang (sesuai ketentuan BAB 7).
/// - CRUD untuk dua model: [ExpenseItem] (pengeluaran) dan [BudgetCategory].
/// - Mengextend [ChangeNotifier]: setiap Create/Update/Delete memanggil
///   `notifyListeners()` sehingga semua screen yang memakai
///   `ListenableBuilder` otomatis tampil ulang. Fungsinya mirip `setState`,
///   tetapi bisa dipakai bersama oleh banyak screen.
///
/// SELURUH DATA DI SINI ADALAH DATA SIMULASI, bukan data pribadi nyata.
class ExpenseStore extends ChangeNotifier {
  /// [withMockData] false membuat store kosong (dipakai pada unit test).
  /// [now] dipakai untuk membuat tanggal mock data secara relatif.
  ExpenseStore({bool withMockData = true, DateTime? now}) {
    if (withMockData) _seed(now ?? DateTime.now());
  }

  /// Satu store bersama yang dipakai seluruh aplikasi.
  static final ExpenseStore instance = ExpenseStore();

  final List<ExpenseItem> _expenses = [];
  final List<BudgetCategory> _categories = [];
  int _nextExpenseId = 1;
  int _nextCategoryId = 1;

  // ---------------------------------------------------------------------------
  // READ
  // ---------------------------------------------------------------------------

  /// Seluruh pengeluaran, terbaru di atas.
  List<ExpenseItem> get expenses => UnmodifiableListView(_expenses);

  List<BudgetCategory> get categories => UnmodifiableListView(_categories);

  int get totalSpent => _expenses.fold(0, (sum, e) => sum + e.amount);

  /// [count] pengeluaran terbaru (untuk "Recent Expenses" di Home).
  List<ExpenseItem> recentExpenses([int count = 2]) =>
      _expenses.take(count).toList();

  ExpenseItem? findExpense(int id) {
    for (final e in _expenses) {
      if (e.id == id) return e;
    }
    return null;
  }

  BudgetCategory? findCategory(int id) {
    for (final c in _categories) {
      if (c.id == id) return c;
    }
    return null;
  }

  /// Total pengeluaran pada satu kategori.
  int spentIn(String category) => _expenses
      .where((e) => e.category == category)
      .fold(0, (sum, e) => sum + e.amount);

  /// Jumlah pengeluaran yang memakai kategori tertentu.
  int expenseCountFor(String category) =>
      _expenses.where((e) => e.category == category).length;

  /// Total per kategori (hanya yang > 0). Urutan mengikuti daftar kategori
  /// agar warna di grafik stabil.
  Map<String, int> totalsByCategory() {
    final result = <String, int>{};
    for (final c in _categories) {
      final total = spentIn(c.name);
      if (total > 0) result[c.name] = total;
    }
    return result;
  }

  /// Tanggal (tanpa jam) untuk [days] hari terakhir, urut dari terlama ke
  /// hari ini.
  static List<DateTime> lastDays(int days, {DateTime? today}) {
    final now = today ?? DateTime.now();
    final base = DateTime(now.year, now.month, now.day);
    return [
      for (var i = days - 1; i >= 0; i--)
        DateTime(base.year, base.month, base.day - i),
    ];
  }

  /// Total pengeluaran per hari selama [days] hari terakhir.
  List<int> dailyTotals(int days, {DateTime? today}) {
    return [
      for (final day in lastDays(days, today: today))
        _expenses
            .where(
              (e) =>
                  e.date.year == day.year &&
                  e.date.month == day.month &&
                  e.date.day == day.day,
            )
            .fold(0, (sum, e) => sum + e.amount),
    ];
  }

  // ---------------------------------------------------------------------------
  // CREATE / UPDATE / DELETE - Pengeluaran
  // ---------------------------------------------------------------------------

  /// CREATE: menambah pengeluaran baru lalu memberi tahu listener.
  ExpenseItem addExpense({
    required String title,
    required int amount,
    required String category,
    DateTime? date,
  }) {
    final item = ExpenseItem(
      id: _nextExpenseId++, // tidak direset saat data dihapus (ID tetap unik)
      title: title,
      amount: amount,
      category: category,
      date: date ?? DateTime.now(),
    );
    _expenses.add(item);
    _sortExpenses();
    notifyListeners();
    return item;
  }

  /// UPDATE: mengganti data berdasarkan `id`. Mengembalikan false jika tidak
  /// ditemukan.
  bool updateExpense(ExpenseItem updated) {
    final index = _expenses.indexWhere((e) => e.id == updated.id);
    if (index == -1) return false;
    _expenses[index] = updated;
    _sortExpenses();
    notifyListeners();
    return true;
  }

  /// DELETE: menghapus pengeluaran berdasarkan `id`.
  bool deleteExpense(int id) {
    final before = _expenses.length;
    _expenses.removeWhere((e) => e.id == id);
    final removed = _expenses.length != before;
    if (removed) notifyListeners();
    return removed;
  }

  // ---------------------------------------------------------------------------
  // CREATE / UPDATE / DELETE - Kategori budget
  // ---------------------------------------------------------------------------

  BudgetCategory addCategory({required String name, required int limit}) {
    final category = BudgetCategory(
      id: _nextCategoryId++,
      name: name,
      limit: limit,
    );
    _categories.add(category);
    notifyListeners();
    return category;
  }

  /// UPDATE kategori. Jika nama berubah, pengeluaran yang memakai nama lama
  /// ikut diperbarui agar data tetap konsisten.
  bool updateCategory(BudgetCategory updated) {
    final index = _categories.indexWhere((c) => c.id == updated.id);
    if (index == -1) return false;
    final oldName = _categories[index].name;
    _categories[index] = updated;
    if (oldName != updated.name) {
      for (var i = 0; i < _expenses.length; i++) {
        if (_expenses[i].category == oldName) {
          _expenses[i] = _expenses[i].copyWith(category: updated.name);
        }
      }
    }
    notifyListeners();
    return true;
  }

  /// DELETE kategori. Ditolak (false) jika masih dipakai pengeluaran, supaya
  /// tidak ada pengeluaran dengan kategori yang sudah hilang.
  bool deleteCategory(int id) {
    final category = findCategory(id);
    if (category == null) return false;
    if (expenseCountFor(category.name) > 0) return false;
    _categories.removeWhere((c) => c.id == id);
    notifyListeners();
    return true;
  }

  // ---------------------------------------------------------------------------
  // Internal
  // ---------------------------------------------------------------------------

  void _sortExpenses() {
    _expenses.sort((a, b) {
      final byDate = b.date.compareTo(a.date);
      return byDate != 0 ? byDate : b.id.compareTo(a.id);
    });
  }

  /// Mock data (simulasi). Tidak memuat data pribadi apa pun.
  void _seed(DateTime now) {
    final today = DateTime(now.year, now.month, now.day);
    DateTime daysAgo(int n) => DateTime(today.year, today.month, today.day - n);

    // Kategori + batas anggaran (angka contoh).
    for (final entry in const <(String, int)>[
      ('Food & Dining', 50000),
      ('Rent', 1500000),
      ('Transportation', 55000),
      ('Other', 100000),
    ]) {
      addCategory(name: entry.$1, limit: entry.$2);
    }

    // Pengeluaran contoh (tersebar dalam 7 hari terakhir).
    addExpense(
      title: 'Makan',
      amount: 20000,
      category: 'Food & Dining',
      date: daysAgo(0),
    );
    addExpense(
      title: 'Bensin',
      amount: 50000,
      category: 'Transportation',
      date: daysAgo(1),
    );
    addExpense(
      title: 'Kuota Internet',
      amount: 25000,
      category: 'Other',
      date: daysAgo(2),
    );
    addExpense(
      title: 'Bayar Kos',
      amount: 700000,
      category: 'Rent',
      date: daysAgo(3),
    );
    addExpense(
      title: 'Makan Siang',
      amount: 15000,
      category: 'Food & Dining',
      date: daysAgo(5),
    );
  }
}
