/// Kumpulan fungsi validator untuk TextFormField (BAB 6).
///
/// Aturan: validator mengembalikan String (pesan error) jika input TIDAK valid
/// dan mengembalikan null jika input valid.
class Validators {
  Validators._();

  static final RegExp _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  /// Wajib diisi + panjang minimal [minLength] karakter.
  static String? name(
    String? value, {
    String label = 'Nama',
    int minLength = 3,
  }) {
    if (value == null || value.trim().isEmpty) {
      return '$label tidak boleh kosong';
    }
    if (value.trim().length < minLength) {
      return '$label minimal $minLength karakter';
    }
    return null;
  }

  /// Wajib diisi + format email dasar (ada "@" dan domain).
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email tidak boleh kosong';
    }
    if (!_emailPattern.hasMatch(value.trim())) {
      return 'Format email belum sesuai';
    }
    return null;
  }

  /// Wajib diisi + minimal 6 karakter.
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    if (value.length < 6) {
      return 'Password minimal 6 karakter';
    }
    return null;
  }

  /// Wajib diisi + harus sama dengan [original].
  static String? confirmPassword(String? value, String original) {
    if (value == null || value.isEmpty) {
      return 'Konfirmasi password tidak boleh kosong';
    }
    if (value != original) {
      return 'Konfirmasi password tidak sama';
    }
    return null;
  }

  /// Wajib diisi + harus angka bulat lebih dari 0 (tanpa titik/koma).
  static String? amount(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nominal tidak boleh kosong';
    }
    final number = int.tryParse(value.trim());
    if (number == null) {
      return 'Nominal harus berupa angka (tanpa titik atau koma)';
    }
    if (number <= 0) {
      return 'Nominal harus lebih dari 0';
    }
    return null;
  }

  /// Dropdown kategori wajib dipilih.
  static String? category(String? value) {
    if (value == null || value.isEmpty) {
      return 'Kategori wajib dipilih';
    }
    return null;
  }
}
