CHANGELOG

v0.3 - Data Module
(2026-11-04)
## Perubahan:

Menambahkan model data ExpenseItem (id, title, amount, category, date) dan BudgetCategory (id, name, limit) di lib/models/.
Menambahkan ExpenseStore (lib/data/expense_store.dart): local/mock data di memori berbasis List dengan ChangeNotifier.
Menambahkan CRUD pengeluaran: tambah (form tervalidasi), tampil (ListView.builder), ubah (form edit), hapus (dialog konfirmasi).
Menambahkan CRUD kategori budget pada screen Budget: tambah, tampil, ubah, hapus (kategori yang masih dipakai tidak boleh dihapus).
Menghubungkan form BAB 6 dengan proses Create dan Update (ExpenseFormPage mode tambah/ubah, dialog kategori mode tambah/ubah).
Menambahkan empty state (EmptyState) pada Home, Semua Pengeluaran, Budget, dan Analytics.
Menambahkan SnackBar setelah tambah, ubah, dan hapus data.
Mengubah Home, Budget, dan Analytics menjadi berbasis data (Total Spent, Recent Expenses, progres budget, grafik mingguan, dan grafik kategori dihitung dari ExpenseStore).
Menambahkan validator uniqueName (nama kategori tidak boleh kembar) di validators.dart.
Menambahkan widget EmptyState, confirmDelete, dan CategoryStyle; memperbarui ExpenseTile dan BudgetProgressCard.
Menambahkan unit test CRUD (test/expense_store_test.dart) dan memperbarui validators_test.dart.
Menu Categories pada Settings kini membuka screen Budget.
Memastikan navigasi v0.1 dan Form & Validation v0.2 tetap berjalan.
Memperbarui README.md, AI_USAGE.md, dan versi pada pubspec.yaml (0.3.0+1).

## Bukti:
Screenshot/video aplikasi berjalan dan skenario CRUD (lihat README, bagian Skenario Uji).
Commit Git / tag v0.3.

v0.2 - Form & Validation
(2026-11-03)
## Perubahan:

Menambahkan form tervalidasi pada Sign In, Create Account, Tambah Pengeluaran, dan Add Category.
Menambahkan aturan validasi email, password, angka, dan kategori di validators.dart.
Menambahkan pesan error input dan SnackBar feedback.
Menambahkan state toggle password dan teks status.
Memastikan dispose() pada TextEditingController dan pengecekan mounted.
Menambahkan pengujian otomatis unit test (validators_test.dart).
Memperbarui README.md dan AI_USAGE.md.

v0.1 - Navigation 
(2026-11-03)
## Perubahan:

Membuat 8 screen utama sesuai UI Blueprint.
Menerapkan navigasi (push, pop, replacement).
Membuat Bottom Navigation Bar dengan tombol aksi (+).
Menambahkan visualisasi grafik dan progress bar statis.
Menerapkan tema warna proyek (teal, biru, merah).
Memperbarui README.md.

v0.0.1 - UI Blueprint 
(2026-10-13)
## Perubahan:

Merancang wireframe dan mockup screen di Figma.
Menyusun Style Guide dan Accessibility Checklist.

v0.0 - Prototype 
(2026-10-06)
## Perubahan:

Inisialisasi proyek Flutter awal.
Membuat tampilan home dan profil sederhana.
Menguji jalannya aplikasi di Chrome.