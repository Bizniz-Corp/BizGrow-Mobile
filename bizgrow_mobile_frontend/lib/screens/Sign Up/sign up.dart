import 'dart:io';
import 'package:bizgrow_mobile_frontend/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:bizgrow_mobile_frontend/screens/Sign%20in/sign%20in.dart';
import 'package:bizgrow_mobile_frontend/services/api_service.dart';

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
  final apiService = ApiService();
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

  Future<void> signUp() async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        file == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Harap lengkapi semua data!")),
      );
      return;
    }

    // Data yang akan dikirim
    Map<String, String> data = {
      'name': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'npwp': npwpController.text,
    };

    try {
      // Kirim request
      var response = await apiService.register(data, file!.path);

      if (response['success']) {
        // Beri tahu user dan arahkan ke halaman sign in
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registrasi berhasil!")),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignInScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['message'] ?? "Registrasi gagal")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Terjadi kesalahan: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Main.background, // Dark blue background
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
                  color: Monochrome.whiteDarkMode,
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
              SizedBox(height: 20.0),
              // Email TextField
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
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
              SizedBox(height: 20.0),
              // Password TextField
              TextField(
                controller: passwordController,
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
              SizedBox(height: 20.0),
              // NPWP TextField
              TextField(
                controller: npwpController,
                decoration: InputDecoration(
                  labelText: 'Nomor Pokok Wajib Pajak',
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
              SizedBox(height: 20.0),
              // File Picker for SIUP (Optional)
              Row(
                children: [
                  Text(
                    'Surat Izin Usaha Perusahaan',
                    style: TextStyle(color: Monochrome.whiteDarkMode),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: pickFile,
                    child: Text(
                      'Pilih Berkas',
                      style: TextStyle(color: Main.lightBlue),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Text(
                selectedFile,
                style: TextStyle(color: Monochrome.whiteDarkMode),
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
                        MaterialStateProperty.all(Main.blueSecondary),
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
                    style: TextStyle(color: Monochrome.whiteDarkMode),
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
                    style: TextStyle(color: Monochrome.whiteDarkMode),
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
