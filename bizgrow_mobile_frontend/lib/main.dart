import 'package:flutter/material.dart';
import 'package:bizgrow_mobile_frontend/themes/theme.dart';
import 'package:bizgrow_mobile_frontend/screens/beranda/beranda_screen.dart';
import 'package:bizgrow_mobile_frontend/screens/penjualan/penjualan_prediksi_demand_screen.dart';

void main() {
  runApp(BizGrowApp());
}

class BizGrowApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: BizGrowTheme.darkMode,
      // for testing
      home: BerandaScreen(),
    );
  }
}