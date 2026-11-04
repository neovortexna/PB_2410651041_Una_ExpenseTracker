## Expense Tracker
Aplikasi prototype untuk membantu mahasiswa mencatat dan memantau pengeluaran harian, memantau batas anggaran per kategori, dan melihat analisis pengeluaran dalam bentuk grafik.

## Identitas
Nama: Hotijatul Munauwaroh
NIM: 2410651041
Target Pengguna: Mahasiswa, pekerja muda, dan masyarakat umum.

## Milestone Saat Ini
Data Module v0.3

## Versi
v0.3 - Data Module

## Daftar Screen
- Welcome (Sign In): lib/screens/login_page.dart (form login tervalidasi)
- Create Account: lib/screens/register_page.dart (form registrasi tervalidasi)
- Home Dashboard: lib/screens/home_page.dart (Total Spent, grafik tren, Recent Expenses, empty state)
- Semua Pengeluaran (See All): lib/screens/expense_list_page.dart (READ, UPDATE, DELETE pengeluaran + tombol tambah)
- Tambah / Ubah Pengeluaran: lib/screens/expense_form_page.dart (CREATE dan UPDATE lewat form tervalidasi)
- Create Budget: lib/screens/budget_page.dart (CRUD kategori budget + progres budget)
- Analytics: lib/screens/analytics_page.dart (Weekly Spending dan Expense Categories dari data)
- Settings: lib/screens/settings_page.dart (Linked Account, menu, identitas, Logout)

## Model Data
ExpenseItem (lib/models/expense_item.dart):
- id (int) : penanda unik
- title (String) : nama pengeluaran
- amount (int) : nominal dalam Rupiah
- category (String) : nama kategori
- date (DateTime) : tanggal pencatatan

BudgetCategory (lib/models/budget_category.dart):
- id (int) : penanda unik
- name (String) : nama kategori
- limit (int) : batas anggaran dalam Rupiah

## Sumber Data
Data sementara di memori aplikasi menggunakan List (local/mock data) pada ExpenseStore (lib/data/expense_store.dart).
Data akan kembali ke mock data awal ketika aplikasi dimuat ulang (sesuai ketentuan BAB 7; penyimpanan permanen belum digunakan).
ExpenseStore memakai ChangeNotifier: setiap tambah/ubah/hapus memanggil notifyListeners(), lalu screen yang memakai ListenableBuilder tampil ulang otomatis (Home, Semua Pengeluaran, Budget, Analytics selalu sinkron).

## Operasi CRUD
| Operasi | Pengeluaran | Kategori Budget |
|---|---|---|
| Create | Tombol (+) di bottom nav / tombol (+) di Semua Pengeluaran -> form tervalidasi | + Add Category -> dialog tervalidasi |
| Read | Semua Pengeluaran (ListView.builder), Recent Expenses di Home | Kartu progres di Budget |
| Update | Ikon pensil -> form berisi data lama | Ikon pensil -> dialog berisi data lama |
| Delete | Ikon tempat sampah -> dialog konfirmasi | Ikon tempat sampah -> dialog konfirmasi |

Aturan tambahan:
- Mengubah nama kategori ikut memperbarui pengeluaran yang memakai kategori tersebut.
- Kategori yang masih dipakai pengeluaran tidak dapat dihapus (muncul SnackBar penjelasan).

## Empty State dan User Feedback
- Empty state: pesan "Belum ada data. Silakan tambahkan data baru." (Home, Semua Pengeluaran, Budget) dan pesan khusus pada Analytics.
- SnackBar: "Data berhasil ditambahkan", "Data berhasil diperbarui", "Data berhasil dihapus", serta "Input belum valid" pada form.

## Aturan Validasi
- Nama pengeluaran: wajib diisi, minimal 3 karakter.
- Nominal / batas anggaran: wajib diisi, angka bulat, lebih dari 0.
- Kategori pengeluaran: wajib dipilih.
- Nama kategori budget: wajib diisi, minimal 3 karakter, tidak boleh sama dengan kategori lain.
- Email: wajib diisi dan berformat email dasar. Password: wajib diisi, minimal 6 karakter. Konfirmasi password harus sama.

## Struktur Folder
lib/main.dart
lib/theme/app_theme.dart
lib/models/ (expense_item.dart, budget_category.dart)
lib/data/expense_store.dart
lib/utils/ (validators.dart, format.dart, session.dart, category_style.dart)
lib/widgets/
lib/screens/
test/ (validators_test.dart, expense_store_test.dart)
docs/

## Alur Navigasi
Welcome (Sign In) dan Create Account saling terhubung dengan push/pop.
Login atau Registrasi mengarah ke Home Dashboard.
Home Dashboard terhubung ke See All (Semua Pengeluaran) dan Tambah Pengeluaran.
Semua Pengeluaran terhubung ke form Tambah/Ubah Pengeluaran.
Bottom Navigation Bar menyediakan akses ke Home, Analytics, Tambah Pengeluaran (+), Budget, dan Settings.
Settings > Categories membuka screen Budget. Logout mengembalikan pengguna ke halaman Sign In.

## Skenario Uji
| No | Skenario | Aksi | Hasil yang diharapkan |
|---|---|---|---|
| 1 | Read data awal | Buka Home lalu See All | 5 data mock tampil, Total Spent Rp 810.000 |
| 2 | Create | (+) -> isi form valid -> Simpan | Kembali ke screen sebelumnya, data baru muncul di atas, SnackBar "Data berhasil ditambahkan" |
| 3 | Create tidak valid | (+) -> form kosong / nominal "20.000" -> Simpan | Pesan error di bawah input, SnackBar "Input belum valid", data tidak bertambah |
| 4 | Update | See All -> ikon pensil -> ubah nominal -> Simpan Perubahan | Data berubah, total ikut berubah, SnackBar "Data berhasil diperbarui" |
| 5 | Delete | See All -> ikon tempat sampah -> Hapus | Data hilang, SnackBar "Data berhasil dihapus" |
| 6 | Batal hapus | Ikon tempat sampah -> Batal | Data tetap ada |
| 7 | Empty state | Hapus seluruh pengeluaran | Muncul pesan data kosong, Home menampilkan Rp 0 |
| 8 | CRUD kategori | Budget -> + Add Category -> isi -> Simpan; ubah; hapus | Kartu muncul / berubah / hilang disertai SnackBar |
| 9 | Nama kategori kembar | Tambah kategori "rent" | Pesan error "Nama kategori sudah ada" |
| 10 | Hapus kategori terpakai | Hapus "Rent" saat masih ada pengeluaran Rent | SnackBar penjelasan, kategori tidak terhapus |
| 11 | Analytics | Buka Analytics setelah tambah/hapus data | Grafik mingguan dan donat ikut berubah |
| 12 | Navigasi tetap berjalan | Pindah antar tab, buka See All lalu Kembali | Tidak ada error |
| 13 | Form BAB 6 tetap berjalan | Uji Sign In / Create Account dengan input kosong dan valid | Validasi dan feedback tetap berfungsi |

Uji otomatis (logika CRUD dan validator):
flutter test

## Fitur Utama
Navigasi antar screen menggunakan Navigator.push, Navigator.pop, MaterialPageRoute, dan Bottom Navigation Bar.
Validasi form menggunakan Form, GlobalKey<FormState>, TextFormField, dan fungsi validator khusus.
CRUD pengeluaran dan kategori budget dengan local/mock data (List) dan ChangeNotifier.
Visualisasi data pengeluaran dan anggaran dengan komponen UI kustom (grafik dihitung dari data).

## Cara Menjalankan
flutter pub get
flutter run -d chrome

## Bukti Running
Tambahkan screenshot atau link video singkat aplikasi berjalan (Home, Semua Pengeluaran, form tambah/ubah, dialog hapus, empty state, Budget, Analytics).

## Catatan Penggunaan AI
Lihat AI_USAGE.md.

## Catatan Keamanan Data
Seluruh data dalam aplikasi adalah data simulasi (mock data) dan tidak memuat data pribadi nyata, password, token, API key, credential, atau data sensitif lain. Login hanya simulasi: password tidak disimpan.
