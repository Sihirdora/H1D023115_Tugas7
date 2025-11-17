import 'package:flutter/material.dart';
import 'package:pertemuan9/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Fungsi untuk menyimpan username ke local storage
  void _saveUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Simpan Username ke local storage
    prefs.setString('username', _usernameController.text);
  }

  // Fungsi untuk menampilkan input pada form login dengan dekorasi berbeda
  Widget _showInput(namacontroller, placeholder, isPassword) {
    return TextField(
      controller: namacontroller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: placeholder, // Menggunakan labelText alih-alih hintText
        border: const OutlineInputBorder( // Menggunakan OutlineInputBorder
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      ),
    );
  }

  // Fungsi untuk menampilkan alert dan navigasi
  Future<void> _showDialog(String pesan, Widget? alamat) {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(pesan),
          actions: [
            TextButton(
              child: const Text('TUTUP'),
              onPressed: () {
                Navigator.pop(context); // Tutup dialog
                if (alamat != null) {
                  // Navigasi ke halaman setelah dialog ditutup
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => alamat,
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  // Logika Login
  void _handleLogin() {
    if (_usernameController.text == 'admin' &&
        _passwordController.text == 'admin') {
      _saveUsername();
      // Mengubah pesan alert dan langsung navigasi ke HomePage
      _showDialog('Login Berhasil! Selamat Datang.', const HomePage());
    } else {
      // Mengubah pesan alert dan tidak ada navigasi
      _showDialog('Gagal: Username atau Password salah!', null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplikasi Login Kreatif'),
        backgroundColor: Colors.indigo, // Warna AppBar berbeda
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Card( // Menggunakan Card untuk membungkus form login
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Agar Column tidak memakan seluruh tinggi
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Masuk ke Akun Anda',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.indigo),
                  ),
                  const SizedBox(height: 20),
                  _showInput(_usernameController, 'Nama Pengguna', false),
                  const SizedBox(height: 15),
                  _showInput(_passwordController, 'Kata Sandi', true),
                  const SizedBox(height: 25),
                  Container(
                    width: double.infinity,
                    height: 45,
                    child: TextButton( // Mengganti ElevatedButton dengan TextButton dengan styling
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Colors.indigo,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text('MASUK', style: TextStyle(fontSize: 16)),
                      onPressed: _handleLogin,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}