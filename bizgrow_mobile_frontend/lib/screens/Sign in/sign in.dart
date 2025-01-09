import 'package:flutter/material.dart';
import 'package:bizgrow_mobile_frontend/screens/Sign Up/sign up.dart';
import 'package:bizgrow_mobile_frontend/screens/beranda/beranda_screen.dart';
import 'package:bizgrow_mobile_frontend/services/api_service.dart';
import 'package:bizgrow_mobile_frontend/themes/colors.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final ApiService apiService = ApiService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _handleSignIn() async {
    // Logika sign-in dummy untuk demonstrasi
    final result =
        await apiService.login(_emailController.text, _passwordController.text);

    if (result['success']) {
      final authToken = await apiService.getToken(); // Tambahkan await di sini
      print('Auth Token: $authToken');

      // Navigasi ke layar berikutnya
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BerandaScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email atau Password tidak boleh kosong.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Main.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Responsif ukuran logo
                  FractionallySizedBox(
                    widthFactor: 0.5,
                    child: Image.asset(
                      'lib/assets/navbar_icon/logo1.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Text(
                    'Sign In',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Monochrome.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Monochrome.white),
                      filled: true,
                      fillColor: Main.darkBlue,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Main.lightBlue,
                        ),
                      ),
                    ),
                    style: TextStyle(color: Monochrome.whiteDarkMode),
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Monochrome.whiteDarkMode),
                      filled: true,
                      fillColor: Main.darkBlue,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Main.lightBlue,
                        ),
                      ),
                    ),
                    style: TextStyle(color: Monochrome.whiteDarkMode),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value ?? false;
                          });
                        },
                        checkColor: Monochrome.whiteDarkMode,
                        fillColor: MaterialStateProperty.resolveWith(
                            (states) => Colors.blue),
                      ),
                      Text(
                        'Biarkan tetap masuk?',
                        style: TextStyle(color: Monochrome.whiteDarkMode),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          // Handle forgot password action
                        },
                        child: Text(
                          'Lupa password?',
                          style: TextStyle(color: Monochrome.whiteDarkMode),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed:
                          _handleSignIn, // Pastikan onPressed tidak dihapus
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Main.blueSecondary),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(vertical: 16.0),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      child: Text(
                        'Sign In',
                        style: TextStyle(color: Monochrome.whiteDarkMode),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Belum punya akun? Klik Di Sini',
                        style: TextStyle(color: Monochrome.whiteDarkMode),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
