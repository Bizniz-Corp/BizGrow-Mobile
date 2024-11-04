import 'package:flutter/material.dart';
import 'package:bizgrow_mobile_frontend/themes/theme.dart';
import 'package:bizgrow_mobile_frontend/widgets/navbar.dart';
import 'package:bizgrow_mobile_frontend/screens/beranda/beranda_screen.dart';

void main() {
  runApp(BizGrowApp());
}

class BizGrowApp extends StatelessWidget {
  const BizGrowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: BizGrowTheme.darkMode,
      home: BerandaScreen(),
    );
  }
}