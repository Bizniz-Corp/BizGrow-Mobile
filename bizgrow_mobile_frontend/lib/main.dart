import 'package:flutter/material.dart';
import 'package:bizgrow_mobile_frontend/themes/theme.dart';
import 'package:bizgrow_mobile_frontend/screens/beranda/beranda_screen.dart';
import 'package:bizgrow_mobile_frontend/widgets/navbar.dart';

void main() {
  runApp(BizGrowApp());
}

class BizGrowApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: BizGrowTheme.darkMode, // Menggunakan tema dari BizGrowTheme
      home: MainNavigator(), // MainNavigator sebagai layar utama
    );
  }
}