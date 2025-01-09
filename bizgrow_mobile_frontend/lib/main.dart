import 'package:bizgrow_mobile_frontend/screens/beranda/beranda_screen.dart';
import 'package:flutter/material.dart';
import 'package:bizgrow_mobile_frontend/themes/theme.dart';
import 'package:bizgrow_mobile_frontend/screens/beranda/landing_page.dart';
import 'package:bizgrow_mobile_frontend/screens/stok/stok_screen.dart';
import 'package:bizgrow_mobile_frontend/screens/Sign in/sign in.dart';

void main() {
  runApp(BizGrowApp());
}

class BizGrowApp extends StatelessWidget {
  const BizGrowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: BizGrowTheme.darkMode,
      home: SignInScreen(),
    );
  }
}
