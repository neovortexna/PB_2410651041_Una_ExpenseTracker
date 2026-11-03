
## Expense Tracker 
aplikasi prototype untuk membantu mahasiswa mencatat dan memantau pengeluaran harian, memantau batas anggaran per kategori, dan melihat analisis pengeluaran dalam bentuk grafik.

## Identitas
Nama: Hotijatul Munauwaroh
NIM: 2410651041
Target Pengguna: Mahasiswa, pekerja muda, dan masyarakat umum.

## Milestone Saat Ini
Form & Validation v0.2

## Versi
v0.2 - Form & Validation

## Daftar Screen
Welcome (Sign In): lib/screens/login_page.dart (Form login tervalidasi)
Create Account: lib/screens/register_page.dart (Form registrasi tervalidasi)
Home Dashboard: lib/screens/home_page.dart (Total Spent, grafik, Recent Expenses)
Semua Pengeluaran (See All): lib/screens/expense_list_page.dart (Daftar pengeluaran)
Tambah Pengeluaran: lib/screens/expense_form_page.dart (Form tervalidasi, dibuka dari tombol (+))
Create Budget: lib/screens/budget_page.dart (Progress bar budget + dialog Add Category)
Analytics: lib/screens/analytics_page.dart (Weekly Spending dan Expense Categories)
Settings: lib/screens/settings_page.dart (Linked Account, menu, identitas, Logout)

## Struktur Folder
lib/main.dart
lib/theme/app_theme.dart
lib/models/expense_item.dart
lib/utils/validators.dart
lib/utils/format.dart
lib/utils/session.dart
lib/widgets/
lib/screens/
test/validators_test.dart

## Alur Navigasi
Welcome (Sign In) dan Create Account saling terhubung dengan push/pop.
Login atau Registrasi mengarah ke Home Dashboard.
Home Dahboard terhubung ke See All dan Tambah Pengeluaran.
Bottom Navigation Bar menyediakan akses ke Home, Analytics, Tambah Pengeluaran (+), Budget, dan Settings.
Logout dari Settings mengembalikan pengguna ke halaman Sign In.

## Fitur Utama
Navigasi antar screen menggunakan Navigator.push, Navigator.pop, MaterialPageRoute, dan Bottom Navigation Bar.
Validasi form menggunakan Form, GlobalKey<FormState>, TextFormField, dan fungsi validator khusus.
Uji otomatis aturan validasi menggunakan flutter test.
Visualisasi data pengeluaran dan anggaran dengan komponen UI kustom.

## Cara Menjalankan
flutter pub get
flutter run -d chrome
Catatan Keamanan
Seluruh data dalam aplikasi adalah data simulasi dan tidak menyimpan informasi kredensial atau data pribadi nyata.