import 'package:flutter/material.dart';
import 'package:pertemuan9/login_page.dart';
import 'package:pertemuan9/home_page.dart';
import 'package:pertemuan9/about_page.dart';
import 'package:pertemuan9/settings_page.dart'; // Import SettingsPage
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart'; // Import untuk State Management

// =========================================================
// 1. Theme Provider (Mengelola Status Tema)
// Class ini mengelola status mode gelap/terang di seluruh aplikasi
// =========================================================
class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  // Constructor untuk menentukan tema awal
  ThemeProvider(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  // Fungsi untuk mengubah tema dan menyimpan preferensi ke Local Storage
  void toggleTheme(bool isDark) async {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDark);
    notifyListeners(); // Memberi tahu widget yang mendengarkan untuk rebuild
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Memastikan binding Flutter siap
  runApp (const MyApp());
}

// =========================================================
// 2. MyApp (Menentukan Rute Awal dan Konfigurasi Tema)
// =========================================================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Fungsi untuk memuat preferensi tema awal
  Future<bool> _getInitialTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Default mode adalah Light jika belum pernah disimpan
    return prefs.getBool('isDarkMode') ?? false; 
  }

  // Fungsi untuk menentukan rute awal (sudah login atau belum)
  Future<String> _getInitialRoute() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    
    // Jika username ada, rute awal adalah '/home', jika tidak '/'.
    if (username != null && username.isNotEmpty) {
      return '/home';
    } else {
      return '/'; // Mengarah ke LoginPage
    }
  }

  @override
  Widget build (BuildContext context) {
    // FutureBuilder menunggu kedua Future selesai (Tema dan Rute Awal)
    return FutureBuilder(
      future: Future.wait([_getInitialTheme(), _getInitialRoute()]),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final bool isDark = snapshot.data![0] as bool;
          final String initialRoute = snapshot.data![1] as String;
          
          return ChangeNotifierProvider( // Menyediakan ThemeProvider ke widget di bawahnya
            create: (_) => ThemeProvider(isDark),
            child: Consumer<ThemeProvider>( // Mendengarkan perubahan tema
              builder: (context, themeProvider, child) {
                return MaterialApp(
                  title: 'Aplikasi Demo Tugas Kreatif',
                  // --- Konfigurasi Tema ---
                  theme: ThemeData( 
                    primarySwatch: Colors.indigo,
                    brightness: Brightness.light,
                    appBarTheme: const AppBarTheme(backgroundColor: Colors.indigo),
                    useMaterial3: true,
                  ),
                  darkTheme: ThemeData( 
                    primarySwatch: Colors.indigo,
                    brightness: Brightness.dark,
                    appBarTheme: const AppBarTheme(backgroundColor: Colors.black54),
                    useMaterial3: true,
                  ),
                  themeMode: themeProvider.themeMode, 
                  
                  // --- Konfigurasi Named Routes ---
                  initialRoute: initialRoute,
                  routes: {
                    '/': (context) => const LoginPage(),
                    '/home': (context) => const HomePage(),
                    '/about': (context) => const AboutPage(),
                    '/settings': (context) => const SettingsPage(), 
                  },
                );
              },
            ),
          );
        } else {
          // Tampilkan CircularProgressIndicator saat memuat data awal
          return const MaterialApp( 
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }
}