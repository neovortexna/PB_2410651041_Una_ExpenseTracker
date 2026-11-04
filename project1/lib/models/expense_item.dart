/// Model data pengeluaran (Data Module v0.3 / BAB 7).
///
/// Field:
///  - [id]       : penanda unik (auto-increment sederhana dari ExpenseStore)
///  - [title]    : nama pengeluaran, mis. "Makan siang"
///  - [amount]   : nominal dalam Rupiah (bilangan bulat)
///  - [category] : nama kategori, mis. "Food & Dining"
///  - [date]     : tanggal pengeluaran dicatat
///
/// Model sengaja dibuat pure Dart (tanpa import Flutter) supaya mudah diuji.
/// Ikon dan warna kategori ada di utils/category_style.dart.
class ExpenseItem {
  const ExpenseItem({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
  });

  final int id;
  final String title;
  final int amount; // dalam Rupiah
  final String category;
  final DateTime date;

  /// Membuat salinan dengan sebagian field diganti (dipakai untuk Update).
  ExpenseItem copyWith({
    String? title,
    int? amount,
    String? category,
    DateTime? date,
  }) {
    return ExpenseItem(
      id: id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      date: date ?? this.date,
    );
  }
}
