import 'package:flutter/material.dart';
import 'package:pertemuan9/side_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}): super (key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? namauser;

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  void _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedUsername = prefs.getString('username');
    setState(() {
      namauser = storedUsername ?? 'Pengunjung';
    });
  }

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dasbor Aplikasi Kreatif'),
      ),
      drawer: const Sidemenu(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Hero( // Hero Widget yang sama tag-nya dengan LoginPage
              tag: 'appLogo',
              child: Icon(
                Icons.rocket_launch, 
                size: 100, 
                color: Colors.lightBlue,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Selamat Datang Kembali,',
              style: TextStyle(fontSize: 22, color: Theme.of(context).colorScheme.secondary),
            ),
            Text(
              namauser ?? 'Memuat...', 
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              icon: const Icon(Icons.settings),
              label: const Text('Pergi ke Pengaturan'),
              onPressed: () {
                // Navigasi ke Settings Page menggunakan named route
                Navigator.of(context).pushNamed('/settings'); 
              },
            )
          ],
        ),
      ),
    );
  }
}