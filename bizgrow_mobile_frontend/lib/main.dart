import 'package:bizgrow_mobile_frontend/screens/beranda/beranda_screen.dart';
import 'package:flutter/material.dart';
import 'package:bizgrow_mobile_frontend/themes/theme.dart';
import 'package:bizgrow_mobile_frontend/screens/Sign in/sign in.dart';
import 'package:bizgrow_mobile_frontend/services/api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final apiService = ApiService();

  final isLoggedIn = await apiService.isLoggedIn();
  runApp(BizGrowApp(isLoggedIn: isLoggedIn));
}

class BizGrowApp extends StatelessWidget {
  final bool isLoggedIn;

  const BizGrowApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: BizGrowTheme.darkMode,
      home: isLoggedIn ? BerandaScreen() : SignInScreen(),
    );
  }
}
