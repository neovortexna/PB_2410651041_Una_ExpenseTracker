import 'package:flutter_test/flutter_test.dart';
import 'package:project1/data/expense_store.dart';

/// Pengujian CRUD pada ExpenseStore (bukti uji Data Module v0.3 / BAB 7).
void main() {
  // Hari tetap agar hasil uji tidak bergantung pada tanggal menjalankan test.
  final fixedNow = DateTime(2026, 11, 4, 10, 30);

  group('Mock data', () {
    test('store berisi mock data awal (READ)', () {
      final store = ExpenseStore(now: fixedNow);
      expect(store.expenses, hasLength(5));
      expect(store.categories, hasLength(4));
      expect(store.totalSpent, 810000);
    });

    test('pengeluaran diurutkan dari yang terbaru', () {
      final store = ExpenseStore(now: fixedNow);
      expect(store.expenses.first.title, 'Makan');
      expect(store.recentExpenses(2).map((e) => e.title).toList(), [
        'Makan',
        'Bensin',
      ]);
    });
  });

  group('CREATE', () {
    test('addExpense menambah data, id unik, dan memberi tahu listener', () {
      final store = ExpenseStore(withMockData: false);
      var notified = 0;
      store.addListener(() => notified++);

      final a = store.addExpense(
        title: 'Es teh',
        amount: 5000,
        category: 'Food & Dining',
      );
      final b = store.addExpense(
        title: 'Parkir',
        amount: 2000,
        category: 'Transportation',
      );

      expect(store.expenses, hasLength(2));
      expect(a.id == b.id, isFalse);
      expect(store.totalSpent, 7000);
      expect(notified, 2);
    });

    test('id tidak dipakai ulang setelah data dihapus', () {
      final store = ExpenseStore(withMockData: false);
      final a = store.addExpense(title: 'A', amount: 1, category: 'X');
      store.deleteExpense(a.id);
      final b = store.addExpense(title: 'B', amount: 1, category: 'X');
      expect(b.id == a.id, isFalse);
    });

    test('addCategory menambah kategori', () {
      final store = ExpenseStore(withMockData: false);
      final c = store.addCategory(name: 'Hiburan', limit: 200000);
      expect(store.categories, hasLength(1));
      expect(store.findCategory(c.id)!.name, 'Hiburan');
    });
  });

  group('UPDATE', () {
    test('updateExpense mengubah data berdasarkan id', () {
      final store = ExpenseStore(now: fixedNow);
      final target = store.expenses.firstWhere((e) => e.title == 'Bensin');

      final ok = store.updateExpense(
        target.copyWith(title: 'Bensin Motor', amount: 60000),
      );

      expect(ok, isTrue);
      final after = store.findExpense(target.id)!;
      expect(after.title, 'Bensin Motor');
      expect(after.amount, 60000);
      expect(after.category, 'Transportation'); // field lain tetap
      expect(store.expenses, hasLength(5)); // jumlah data tidak berubah
      expect(store.totalSpent, 820000);
    });

    test('updateExpense pada id yang tidak ada -> false', () {
      final store = ExpenseStore(now: fixedNow);
      final ghost = store.expenses.first.copyWith();
      store.deleteExpense(ghost.id);
      expect(store.updateExpense(ghost), isFalse);
    });

    test('mengganti nama kategori ikut memperbarui pengeluaran', () {
      final store = ExpenseStore(now: fixedNow);
      final food = store.categories.firstWhere(
        (c) => c.name == 'Food & Dining',
      );

      store.updateCategory(food.copyWith(name: 'Makanan'));

      expect(store.expenseCountFor('Food & Dining'), 0);
      expect(store.expenseCountFor('Makanan'), 2);
      expect(store.spentIn('Makanan'), 35000);
    });
  });

  group('DELETE dan empty state', () {
    test('deleteExpense menghapus data', () {
      final store = ExpenseStore(now: fixedNow);
      final target = store.expenses.first;

      expect(store.deleteExpense(target.id), isTrue);
      expect(store.findExpense(target.id), isNull);
      expect(store.expenses, hasLength(4));
      expect(store.deleteExpense(target.id), isFalse); // sudah tidak ada
    });

    test('menghapus semua data -> daftar kosong (empty state)', () {
      final store = ExpenseStore(now: fixedNow);
      for (final e in List.of(store.expenses)) {
        store.deleteExpense(e.id);
      }
      expect(store.expenses, isEmpty);
      expect(store.totalSpent, 0);
      expect(store.recentExpenses(), isEmpty);
    });

    test('kategori yang masih dipakai tidak boleh dihapus', () {
      final store = ExpenseStore(now: fixedNow);
      final rent = store.categories.firstWhere((c) => c.name == 'Rent');

      expect(store.deleteCategory(rent.id), isFalse);
      expect(store.categories, hasLength(4));
    });

    test('kategori yang tidak dipakai bisa dihapus', () {
      final store = ExpenseStore(now: fixedNow);
      final extra = store.addCategory(name: 'Hiburan', limit: 100000);

      expect(store.deleteCategory(extra.id), isTrue);
      expect(store.categories, hasLength(4));
    });
  });

  group('Data turunan untuk Home, Budget, dan Analytics', () {
    test('totalsByCategory dan spentIn', () {
      final store = ExpenseStore(now: fixedNow);
      final totals = store.totalsByCategory();
      expect(totals['Food & Dining'], 35000);
      expect(totals['Rent'], 700000);
      expect(totals['Transportation'], 50000);
      expect(totals['Other'], 25000);
    });

    test('dailyTotals 7 hari terakhir (terlama -> hari ini)', () {
      final store = ExpenseStore(now: fixedNow);
      final totals = store.dailyTotals(7, today: fixedNow);
      expect(totals, hasLength(7));
      expect(totals.last, 20000); // hari ini: Makan
      expect(totals[5], 50000); // kemarin: Bensin
      expect(totals[1], 15000); // 5 hari lalu: Makan Siang
    });
  });
}
