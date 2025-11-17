import 'package:flutter/material.dart';
import 'package:pertemuan9/side_menu.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info dan Kredit'),
      ),
      drawer: const Sidemenu(),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Proyek Tugas Kreatif',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Theme.of(context).primaryColor),
              ),
              const SizedBox(height: 15),
              const Text(
                'Aplikasi ini mengimplementasikan fitur: Named Routes, Side Menu, Login Form dengan Validasi, Local Storage (Shared Preferences), Animasi Hero, dan Pengaturan Tema.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),
              const Icon(Icons.flutter_dash, size: 80, color: Colors.blue),
            ],
          ),
        ),
      ),
    );
  }
}