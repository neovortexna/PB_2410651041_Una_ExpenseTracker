/// Mengubah angka menjadi format ribuan Indonesia, mis. 2000000 -> "2.000.000".
String formatRupiah(int value) {
  final digits = value.abs().toString();
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) {
      buffer.write('.');
    }
    buffer.write(digits[i]);
  }
  return buffer.toString();
}

const List<String> _monthNames = [
  'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
  'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des', //
];

/// Mengubah tanggal menjadi teks singkat, mis. "04 Nov 2026".
String formatDate(DateTime date) {
  final day = date.day.toString().padLeft(2, '0');
  return '$day ${_monthNames[date.month - 1]} ${date.year}';
}
