Nama Aplikasi:
UI Expense Tracker

Tema Aplikasi:
Aplikasi pencatatan dan manajemen keuangan pribadi bergaya minimalis, bersih, dan modern dengan dominasi warna hijau emerald (teal green). Berfokus pada kemudahan alokasi anggaran, pemantauan pengeluaran harian, dan analisis visual.

Target Pengguna:
Mahasiswa, pekerja muda, dan masyarakat umum yang membutuhkan aplikasi pencatatan keuangan yang simpel, cepat, dan tidak membingungkan untuk memantau arus pengeluaran harian.

Tujuan Aplikasi:
Memudahkan pengguna dalam mencatat pengeluaran harian, memantau alokasi budget harian/bulanan agar tidak overspending, serta menganalisis statistik pengeluaran melalui grafik visual.

Daftar Screen & Komponen UI (5 Layar)
1. Screen 1: Welcome (Sign In)
Fungsi: Halaman autentikasi utama untuk masuk ke dalam aplikasi bagi pengguna yang sudah memiliki akun.

Komponen:

Judul Utama: "Welcome" (Bold, rata tengah).

Label & Input Field 1: Email (Placeholder: "Email or business name").

Label & Input Field 2: Password (Placeholder: "********").

Tombol Utama (Filled): Sign In (Berwarna hijau emerald dengan teks putih).

Tombol Sekunder (Outlined): Continue With Google (Latar putih dengan border hijau).

Tautan Teks: "Don't have an account?" di bagian bawah.

2. Screen 2: Create Account (Register)
Fungsi: Halaman registrasi akun baru bagi pengguna baru.

Komponen:

Judul Utama: "Create Account" (Bold, rata tengah).

Label & Input Field 1: Username (Placeholder: "Name").

Label & Input Field 2: Email (Placeholder: "Email or business name").

Label & Input Field 3: Password (Placeholder: "********" dengan ikon panah di kanan).

Label & Input Field 4: Confirm Password.

Tombol Utama (Filled): Sign In / Registrasi (Hijau emerald).

Tombol Sekunder (Outlined): Continue With Google.

Tautan Navigasi: "Already have an account? Sign In".

3. Screen 3: Home Dashboard (Welcome, [User])
Fungsi: Dasbor utama untuk melihat ringkasan total pengeluaran, grafik tren, dan riwayat transaksi terbaru.

Komponen:

Sapaan/Header: "Welcome, [User]" (Rata kiri).

Card Ringkasan Finansial: Kotak putih (rounded) berisi teks Total Spent Rp.2.000.000 dan grafik garis (line chart) tren pengeluaran hijau.

Bagian Transaksi: Header "Recent Expenses" dan tautan "See All" (Hijau).

Daftar Transaksi (Expense Items):

Makan: Ikon hijau, nama transaksi, nominal merah -20.000.

Bensin: Ikon hijau, nama transaksi, nominal merah -50.000.

Navigasi Bawah (Floating Bottom Navigation Bar): Bilah melayang berwarna hijau emerald dengan 5 ikon menu (Home, Folder, Tombol Tambah [+] Mencolok di Tengah, Wallet, Profile).

4. Screen 4: Create Budget (Track Budget)
Fungsi: Layar untuk memantau dan mengelola batasan anggaran berdasarkan kategori pengeluaran.

Komponen:

Header Layar: Banner hijau emerald penuh di bagian atas berisikan judul "Create Budget" (Teks putih, rata tengah).

Sub-header: "Track Budget".

Indikator Progres Anggaran (Category Progress Bars):

Food & Dining: Teks indikator 70%, progress bar hijau emerald.

Rent: Teks indikator 45%, progress bar biru tua.

Transportation: Teks indikator 90%, progress bar merah (sebagai peringatan visual mendekati limit).

Tombol Aksi: "+ Add Category" (Filled button hijau emerald).

Navigasi Bawah (Floating Bottom Navigation Bar): Tetap konsisten dengan tombol (+) di tengah.

5. Screen 5: Analytics
Fungsi: Menyajikan statistik dan analisis pengeluaran dalam bentuk visual chart harian/mingguan dan kategori.

Komponen:

Header Layar: Banner hijau emerald penuh berisikan judul "Analytics" (Teks putih, rata tengah).

Grafik Pengeluaran Mingguan (Weekly Spending): Bar chart vertikal (Senin–Minggu) berwarna hijau.

Grafik Kategori Pengeluaran (Expense Categories): Grafik Donat (Donut Chart) berwarna-warni beserta legenda kategori (Food & Dining, Rent, Transportation, Other).

Navigasi Bawah (Floating Bottom Navigation Bar): Tetap konsisten di bagian bawah layar.

Alur Navigasi (Flow)
Welcome (Sign In) ↔ Create Account

Welcome / Create Account → Home Dashboard

Home Dashboard → Create Budget (via Bottom Nav / Tombol Tambah)

Home Dashboard → Analytics (via Bottom Nav)