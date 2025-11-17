// test/widget_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Pastikan import ini sesuai dengan nama proyek Anda (asumsi 'pertemuan9')
import 'package:pertemuan9/main.dart';
import 'package:pertemuan9/login_page.dart';
import 'package:pertemuan9/home_page.dart';
import 'package:pertemuan9/about_page.dart';

void main() {
  // 💡 PENTING: Atur Shared Preferences sebelum setiap tes
  // Ini memastikan local storage bersih atau disiapkan sesuai kebutuhan
  setUp(() {
    // Mocking SharedPreferences
    SharedPreferences.setMockInitialValues({}); 
  });

  // --- TEST 1: Memastikan Tampilan Awal (Login Page) Dimuat ---
  testWidgets('Aplikasi memulai pada halaman Login dan menampilkan form', (WidgetTester tester) async {
    // Memuat aplikasi
    await tester.pumpWidget(const MyApp());
    // Menunggu FutureBuilder di main.dart selesai memuat
    await tester.pumpAndSettle();

    // Verifikasi bahwa LoginPage terlihat
    expect(find.byType(LoginPage), findsOneWidget);
    
    // Verifikasi elemen kunci di LoginPage
    expect(find.text('Aplikasi Kreatif - Login'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2)); // Dua field input
    expect(find.text('MASUK'), findsOneWidget);
  });

  // --- TEST 2: Pengujian Login Berhasil dan Navigasi ke Home Page ---
  testWidgets('Input kredensial benar, login berhasil, dan navigasi ke Home Page', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle(); 

    // 1. Masukkan Username
    // Menggunakan find.byType dan find.descendant untuk target yang spesifik
    final usernameField = find.descendant(
      of: find.widgetWithText(TextFormField, 'Nama Pengguna'),
      matching: find.byType(TextFormField),
    );
    await tester.enterText(usernameField, 'admin');

    // 2. Masukkan Password
    final passwordField = find.descendant(
      of: find.widgetWithText(TextFormField, 'Kata Sandi'),
      matching: find.byType(TextFormField),
    );
    await tester.enterText(passwordField, 'admin');

    // 3. Tekan tombol Login
    await tester.tap(find.text('MASUK'));
    // Trigger frame, menunggu dialog muncul
    await tester.pump(); 

    // Verifikasi alert Login Berhasil muncul
    expect(find.text('Login Berhasil! Selamat Datang.'), findsOneWidget);

    // 4. Tekan tombol OK pada dialog
    await tester.tap(find.text('OK'));
    // Trigger frame, menunggu dialog tertutup dan navigasi selesai (ke HomePage)
    await tester.pumpAndSettle(); 

    // Verifikasi navigasi ke HomePage berhasil
    expect(find.byType(LoginPage), findsNothing);
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.text('Dasbor Aplikasi Kreatif'), findsOneWidget);
  });

  // --- TEST 3: Pengujian Navigasi Side Menu dari Home Page ---
  testWidgets('Navigasi dari Home Page ke About Page melalui Side Menu', (WidgetTester tester) async {
    // 1. Inisiasi Login State 
    // Kita harus menyuntikkan username ke SharedPreferences untuk melewati LoginPage
    SharedPreferences.setMockInitialValues({'flutter.username': 'testuser'});
    
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle(); // Sekarang aplikasi dimulai langsung di HomePage

    // Verifikasi bahwa kita berada di HomePage
    expect(find.byType(HomePage), findsOneWidget);
    
    // 2. Buka Side Menu
    // Gunakan find.byIcon(Icons.menu) atau find.byType(DrawerController) untuk membuka drawer
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle(); // Tunggu drawer terbuka

    // Verifikasi Side Menu terlihat
    expect(find.text('Menu Navigasi'), findsOneWidget);

    // 3. Tekan ListTile 'Info Aplikasi'
    await tester.tap(find.text('Info Aplikasi'));
    await tester.pumpAndSettle(); // Tunggu navigasi selesai (ke AboutPage)

    // Verifikasi navigasi ke AboutPage berhasil
    expect(find.byType(HomePage), findsNothing);
    expect(find.byType(AboutPage), findsOneWidget);
    expect(find.text('Proyek Tugas 7'), findsOneWidget);
  });
}