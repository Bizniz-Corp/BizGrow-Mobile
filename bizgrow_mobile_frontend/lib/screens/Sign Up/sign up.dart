import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Define controllers for each TextField
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController npwpController = TextEditingController();

  @override
  void dispose() {
    // Dispose of controllers when the screen is disposed
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    npwpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0F1636), // Dark blue background
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 50.0),
            // Logo at the top
            Image.asset(
              'lib/assets/navbar_icon/Logo.png', // Replace with your logo path
              height: 80.0,
            ),
            SizedBox(height: 30.0),
            // Sign Up Text
            Text(
              'Sign Up',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30.0),
            // Name TextField
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Nama',
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
            // Email TextField
            TextField(
              controller: emailController,
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
              controller: passwordController,
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
            SizedBox(height: 20.0),
            // NPWP TextField
            TextField(
              controller: npwpController,
              decoration: InputDecoration(
                labelText: 'Nomor Pokok Wajib Pajak',
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
            // File Picker for SIUP (Optional)
            Row(
              children: [
                Text(
                  'Surat Izin Usaha Perusahaan',
                  style: TextStyle(color: Colors.white),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    // Implement file picking logic here
                  },
                  child: Text(
                    'Pilih Berkas',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              'No File Selected',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20.0),
            // Sign Up Button
            Container(
              height: 50.0,
              child: ElevatedButton(
                onPressed: () {
                  // Print the values when the button is pressed
                  print("Nama: ${nameController.text}");
                  print("Email: ${emailController.text}");
                  print("Password: ${passwordController.text}");
                  print("NPWP: ${npwpController.text}");
                  // Implement your sign-up logic here
                },
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
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            // Already have an account? Link
            Center(
              child: GestureDetector(
                onTap: () {
                  // Handle the "already have an account" action
                },
                child: Text(
                  'Sudah punya akun? Klik Di Sini',
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
