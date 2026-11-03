/// Penyimpanan nama pengguna sementara selama aplikasi berjalan.
///
/// Ini hanya simulasi sederhana (belum ada autentikasi sungguhan dan tidak
/// ada password yang disimpan). Digunakan untuk menampilkan "Welcome, [User]".
class UserSession {
  UserSession._();

  static String name = 'User';

  /// Mengambil nama dari bagian depan email, mis. "una@mail.com" -> "Una".
  static String nameFromEmail(String email) {
    final local = email.split('@').first.trim();
    if (local.isEmpty) return 'User';
    return local[0].toUpperCase() + local.substring(1);
  }
}
