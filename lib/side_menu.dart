import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sidemenu extends StatelessWidget {
  const Sidemenu({Key? key}): super (key: key);

  void _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username'); 

    // Navigasi menggunakan named route dan menghapus semua rute sebelumnya
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/', // Kembali ke root (LoginPage)
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build (BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor, // Menggunakan warna tema
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Menu Navigasi', style: TextStyle(color: Colors.white, fontSize: 20)),
                SizedBox(height: 5),
                Text('Fitur Lengkap', style: TextStyle(color: Colors.white70, fontSize: 14)),
              ],
            ),
          ),

          // ListTile Home
          ListTile(
            leading: const Icon (Icons.dashboard),
            title: const Text('Dasbor Utama'),
            onTap: () {
              Navigator.pop(context); 
              Navigator.of(context).pushReplacementNamed('/home'); // Named route
            },
          ),
          
          // ListTile Settings (Baru)
          ListTile(
            leading: const Icon (Icons.settings),
            title: const Text('Pengaturan'),
            onTap: () {
              Navigator.pop(context); 
              Navigator.of(context).pushReplacementNamed('/settings'); // Named route
            },
          ),

          // ListTile About
          ListTile(
            leading: const Icon (Icons.info_outline),
            title: const Text('Info Aplikasi'),
            onTap: () {
              Navigator.pop(context); 
              Navigator.of(context).pushReplacementNamed('/about'); // Named route
            },
          ),
          
          const Divider(),

          // ListTile Logout
          ListTile(
            leading: const Icon (Icons.exit_to_app, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () {
              _logout(context);
            },
          ),
        ],
      ),
    );
  }
}