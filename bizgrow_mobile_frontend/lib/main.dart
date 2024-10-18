import 'package:flutter/material.dart';
import 'package:bizgrow_mobile_frontend/widgets/navbar.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Taest'),
        ),
        bottomNavigationBar: MainNavigator(), // Memasukkan MainNavigator sebagai bottomNavigationBar
      ),
    );
  }
}
