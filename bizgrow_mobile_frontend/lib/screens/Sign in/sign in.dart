import 'package:flutter/material.dart';
import 'package:bizgrow_mobile_frontend/screens/Sign Up/sign up.dart';
import 'package:bizgrow_mobile_frontend/screens/beranda/beranda_screen.dart';
import 'package:bizgrow_mobile_frontend/themes/colors.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Main.background, // Dark blue background
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 50.0),
            // Logo at the top
            Image.asset(
              'lib/assets/navbar_icon/logo1.png', // Replace with your logo path
            ),
            SizedBox(height: 30.0),
            // Sign In Text
            Text(
              'Sign In',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30.0),
            // Email TextField
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Color(0xFF1E2640),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20.0),
            // Password TextField
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Color(0xFF1E2640),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                // Remember me checkbox
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.blue), // Checkbox color
                ),
                Text(
                  'Biarkan tetap masuk?',
                  style: TextStyle(color: Colors.white),
                ),
                Spacer(),
                // Forgot password
                GestureDetector(
                  onTap: () {
                    // Handle forgot password action
                  },
                  child: Text(
                    'Lupa password?',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            // Sign In Button
            Container(
              height: 50.0,
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFF2E4379)),
                  padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BerandaScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            // Register Option
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignInScreen(),
                    ),
                  );
                },
                child: Text(
                  'Belum punya akun? Klik Di Sini',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
