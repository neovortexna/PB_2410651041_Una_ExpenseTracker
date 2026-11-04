## CATATAN PENGGUNAAN AI

Proyek: Expense Tracker (Flutter/Dart)
Milestone: Navigation v0.1 (BAB 5), Form & Validation v0.2 (BAB 6), dan Data Module v0.3 (BAB 7)


## TOOL AI YANG DIGUNAKAN
Claude (Anthropic) melalui claude.ai.

## PERAN AI

L1 Explainer: Menjelaskan modul BAB 5-7 dan konsep dasar Flutter (Form, GlobalKey, TextFormField, validator, TextEditingController, dispose, mounted, setState).
L2 Reviewer: Meninjau kesesuaian proyek dengan modul dan UI Blueprint.

## TUJUAN PENGGUNAAN

Menganalisis kekurangan proyek.
Menerjemahkan UI Blueprint menjadi kode Flutter.
Membuat scaffolding form tervalidasi dan navigasi screen.
Menyusun draf dokumentasi (README, CHANGELOG, AI_USAGE).


## CATATAN PENGGUNAAN AI - BAB 7 (Data Module v0.3)

Tool AI yang Digunakan: Claude (Anthropic) melalui claude.ai.
Peran AI: L2 Scaffolder dan L3 Reviewer.
Tujuan Penggunaan: Menyusun struktur awal model data, ExpenseStore (list + ChangeNotifier), CRUD pengeluaran dan kategori budget, empty state, dialog konfirmasi hapus, unit test CRUD, serta draf README dan CHANGELOG.
Bagian yang Dibantu: lib/models/, lib/data/expense_store.dart, expense_form_page.dart (mode tambah/ubah), expense_list_page.dart, budget_page.dart, home_page.dart, analytics_page.dart, widget EmptyState/confirmDelete, test/, README.md, CHANGELOG.md.
Saran AI yang Digunakan: Pemisahan model/data/screens/widgets; ExpenseStore berbasis ChangeNotifier + ListenableBuilder agar semua screen sinkron; kategori yang masih dipakai tidak boleh dihapus; rename kategori ikut memperbarui pengeluaran.
Verifikasi oleh AI: Logika ExpenseStore dan validator diuji dengan Dart SDK (25 unit test lulus pada sandbox dengan Flutter diganti shim sederhana). Tampilan UI belum dijalankan oleh AI di Flutter/Chrome, sehingga wajib diuji sendiri oleh mahasiswa.

Modifikasi atau Verifikasi Mahasiswa: [ISI SENDIRI - apa yang diubah, dijalankan, dan diuji di Chrome, misalnya skenario uji pada README]
Bagian yang Saya Pahami: [ISI SENDIRI - misalnya alur tambah/ubah/hapus data di ExpenseStore, fungsi notifyListeners dan ListenableBuilder, empty state, SnackBar]
Status Akhir: [selesai / belum selesai / perlu revisi]

Catatan keamanan: tidak ada data pribadi, API key, token, atau credential yang dimasukkan ke AI maupun repository. Seluruh data adalah mock data.
