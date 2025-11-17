# Feidinata Artandi - H1D023115

# Tugas 7 - Pertemuan 9



<img width="379" height="842" alt="SS Login Page" src="https://github.com/user-attachments/assets/355ec7ec-7dbc-41d3-991a-fa6908100b0a" />
<img width="382" height="852" alt="SS Dashboard" src="https://github.com/user-attachments/assets/9823c23c-592d-4c05-ac17-8ab8e1aee8f3" />
<img width="383" height="854" alt="SS Settings" src="https://github.com/user-attachments/assets/32323014-b432-483f-9b62-746b245404fd" />
<img width="380" height="851" alt="SS Settings mode gelap" src="https://github.com/user-attachments/assets/0fb21d4f-d621-4e86-80be-163899c6999e" />
<img width="374" height="851" alt="SS Info Aplikasi" src="https://github.com/user-attachments/assets/63b8f614-91cc-4be7-8458-aad21ec20e23" />
<img width="380" height="849" alt="SS Sidemenu" src="https://github.com/user-attachments/assets/15ef89f4-f48b-4a17-bc97-d7551c133cd8" />

1. main.dart 🚀
Peran Utama: Titik masuk (Entry Point) aplikasi dan pusat konfigurasi tingkat tinggi.

Fitur Kunci:

Mendefinisikan ThemeProvider (ChangeNotifier) untuk mengelola status Mode Terang/Gelap secara global.

Menggunakan FutureBuilder untuk memeriksa status login awal (username di local storage) dan preferensi tema sebelum memuat tampilan pertama.

Menerapkan Named Routes (/, /home, /about, /settings) sebagai sistem navigasi aplikasi.

2. login_page.dart 🔐
Peran Utama: Menangani otentikasi pengguna dan menyimpan sesi awal.

Fitur Kunci:

Menggunakan Form dan TextFormField untuk validasi input (memastikan username dan password tidak kosong).

Menyimpan username ke SharedPreferences (Local Storage) setelah login berhasil.

Mengarahkan pengguna ke /home menggunakan Named Routes setelah sukses.

Menggunakan widget Hero (tag: 'appLogo') untuk animasi transisi kreatif saat login/logout.

3. home_page.dart 🏠
Peran Utama: Halaman utama yang ditampilkan setelah pengguna berhasil login.

Fitur Kunci:

Memuat dan menampilkan nama pengguna dari SharedPreferences saat halaman dimuat (initState).

Menggunakan widget Hero (tag: 'appLogo') yang sama dengan LoginPage untuk menyelesaikan animasi transisi.

Menampilkan tombol navigasi ke SettingsPage.

Menyediakan akses ke SideMenu.

4. side_menu.dart 🧭
Peran Utama: Menyediakan navigasi utama antar halaman.

Fitur Kunci:

Berisi daftar menu (ListTile) untuk navigasi ke Dasbor (/home), Pengaturan (/settings), dan Info Aplikasi (/about) menggunakan Named Routes.

Menambahkan fungsi Logout yang secara eksplisit menghapus username dari SharedPreferences dan mengarahkan pengguna kembali ke / (LoginPage).

5. settings_page.dart ⚙️
Peran Utama: Memungkinkan pengguna mengubah preferensi aplikasi.

Fitur Kunci:

Menampilkan detail local storage (Nama Pengguna).

Mengimplementasikan fungsi Toggle Mode Gelap/Terang (Switch).

Menggunakan Provider untuk memanggil ThemeProvider dan menyimpan preferensi tema ke local storage.

6. about_page.dart ℹ️
Peran Utama: Menyediakan informasi mengenai aplikasi.

Fitur Kunci:

Halaman StatelessWidget sederhana yang menampilkan informasi proyek.

Menyediakan akses ke SideMenu.
