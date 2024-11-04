import 'package:bizgrow_mobile_frontend/screens/profil/edit_password.dart';
import 'package:flutter/material.dart';
import 'package:bizgrow_mobile_frontend/themes/theme.dart';
import 'package:bizgrow_mobile_frontend/screens/beranda/beranda_screen.dart';
import 'package:bizgrow_mobile_frontend/screens/profil/edit_password.dart';
import 'package:bizgrow_mobile_frontend/screens/penjualan/penjualan_history.dart';

// for testing
import 'package:bizgrow_mobile_frontend/screens/penjualan/penjualan_prediksi_demand_screen.dart';

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
      home: BerandaScreen(),
    );
  }
}
