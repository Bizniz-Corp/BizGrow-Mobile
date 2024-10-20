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
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Taest',
                style: TextStyle(
                ),
              ),
            ],
        ),
        bottomNavigationBar: MainNavigator(), // Memasukkan MainNavigator sebagai bottomNavigationBar
      ),
    );
  }
}
