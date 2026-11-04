/// Model kategori budget (Data Module v0.3 / BAB 7).
///
/// Field:
///  - [id]    : penanda unik
///  - [name]  : nama kategori, mis. "Food & Dining"
///  - [limit] : batas anggaran dalam Rupiah
class BudgetCategory {
  const BudgetCategory({
    required this.id,
    required this.name,
    required this.limit,
  });

  final int id;
  final String name;
  final int limit;

  BudgetCategory copyWith({String? name, int? limit}) {
    return BudgetCategory(
      id: id,
      name: name ?? this.name,
      limit: limit ?? this.limit,
    );
  }
}
