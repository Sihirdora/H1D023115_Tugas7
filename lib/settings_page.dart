// File: settings_page.dart
import 'package:flutter/material.dart';
import 'package:pertemuan9/side_menu.dart';
import 'package:pertemuan9/main.dart'; // Import main.dart untuk ThemeProvider
import 'package:provider/provider.dart'; // Import Provider
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkMode = false;
  String _initialUsername = '';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
      _initialUsername = prefs.getString('username') ?? 'N/A';
    });
  }

  void _toggleDarkMode(bool value) {
    setState(() {
      _isDarkMode = value;
    });
    // Panggil ThemeProvider untuk mengubah tema secara global
    Provider.of<ThemeProvider>(context, listen: false).toggleTheme(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan Aplikasi'),
      ),
      drawer: const Sidemenu(),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Preferensi Akun', 
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Nama Pengguna (Local)'),
            subtitle: Text(_initialUsername),
          ),

          const SizedBox(height: 20),

          const Text(
            'Pengaturan Tampilan', 
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          ListTile(
            leading: Icon(_isDarkMode ? Icons.dark_mode : Icons.light_mode),
            title: const Text('Mode Gelap'),
            trailing: Switch(
              value: _isDarkMode,
              onChanged: _toggleDarkMode,
              activeColor: Theme.of(context).primaryColor,
            ),
            subtitle: Text(_isDarkMode ? 'Tema Gelap Aktif' : 'Tema Terang Aktif'),
            onTap: () => _toggleDarkMode(!_isDarkMode),
          ),

          const SizedBox(height: 40),
          Center(
            child: Text(
              'Gacor Kang', 
              style: TextStyle(color: Colors.grey[600], fontStyle: FontStyle.italic),
            ),
          )
        ],
      ),
    );
  }
}