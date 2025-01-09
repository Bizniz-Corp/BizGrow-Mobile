import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bizgrow_mobile_frontend/screens/Sign%20in/sign%20in.dart';

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

  String selectedFile = 'No File Selected';
  File? file;

  @override
  void dispose() {
    // Dispose of controllers when the screen is disposed
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    npwpController.dispose();
    super.dispose();
  }

  // Fungsi untuk sign-up dan mendapatkan token dari API Laravel
  Future<void> signUp() async {
    final url = Uri.parse(
        'https://your-laravel-api.com/api/register'); // Ganti dengan URL API Laravel Anda

    var request = http.MultipartRequest('POST', url);
    request.fields['name'] = nameController.text;
    request.fields['email'] = emailController.text;
    request.fields['password'] = passwordController.text;
    request.fields['npwp'] = npwpController.text;

    if (file != null) {
      // Menambahkan file ke dalam request
      request.files.add(await http.MultipartFile.fromPath('file', file!.path));
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final data = jsonDecode(responseData);
      print("Token: ${data['token']}");

      // Simpan token untuk digunakan dalam permintaan selanjutnya
      saveToken(data['token']);
    } else {
      print("Failed to sign up: ${response.reasonPhrase}");
    }
  }

  // Fungsi untuk menyimpan token ke SharedPreferences
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token); // Menyimpan token
  }

  // Fungsi untuk mengambil token dari SharedPreferences
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token'); // Mengambil token
  }

  // Fungsi untuk pick file
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        selectedFile = result.files.single.name;
        file = File(result.files.single.path!); // Menyimpan file yang dipilih
      });
    } else {
      // User canceled the picker
      setState(() {
        selectedFile = 'No File Selected';
        file = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0F1636), // Dark blue background
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 50.0),
              // Logo at the top (kecilkan ukuran logo)
              Image.asset(
                'lib/assets/navbar_icon/logo1.png', // Replace with your logo path
                height: 50.0, // Ukuran logo lebih kecil
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
                    onTap: pickFile,
                    child: Text(
                      'Pilih Berkas',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Text(
                selectedFile,
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20.0),
              // Sign Up Button
              Container(
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () async {
                    await signUp(); // Panggil fungsi signUp
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignInScreen(),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFF2E4379)),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    overlayColor: MaterialStateProperty.all(
                        Colors.blue.withOpacity(0.1)), // Menghilangkan overlay
                  ),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              // Already have an account? Link
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
                    'Sudah punya akun? Klik Di Sini',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
