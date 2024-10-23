import 'package:bizgrow_mobile_frontend/screens/profil/edit_password.dart';
import 'package:flutter/material.dart';
import 'package:bizgrow_mobile_frontend/themes/theme.dart';
import 'package:bizgrow_mobile_frontend/widgets/navbar.dart';
import 'package:bizgrow_mobile_frontend/screens/beranda/beranda_screen.dart';
import 'package:bizgrow_mobile_frontend/screens/profil/edit_password.dart';

void main() {
  runApp(BizGrowApp());
}

class BizGrowApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: BizGrowTheme.darkMode,
      home: EditPassword(),
    );
  }
}
