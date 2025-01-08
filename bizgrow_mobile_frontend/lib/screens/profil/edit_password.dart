import 'package:flutter/material.dart';
import 'profil_screen.dart';
import 'edit_password_confirm.dart';
import 'package:toastification/toastification.dart';
import 'package:bizgrow_mobile_frontend/themes/theme.dart';
import 'package:bizgrow_mobile_frontend/themes/colors.dart';
import 'package:bizgrow_mobile_frontend/themes/text_styles.dart';
import 'package:bizgrow_mobile_frontend/widgets/navbar.dart';
import 'package:bizgrow_mobile_frontend/widgets/button.dart';
import 'package:bizgrow_mobile_frontend/services/api_service.dart';

class EditPassword extends StatefulWidget {
  @override
  State<EditPassword> createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  final TextEditingController passwordController = TextEditingController();
  final ApiService apiService = ApiService();
  final String token =
      "9|8h5vfax7jPtZff4xFAw78GqYdZHCzJWKMvU1TDwwba6f6d63"; // Replace dengan token sebenarnya

  bool isLoading = false;

  void _checkPassword() async {
    // Update UI untuk menampilkan loader
    setState(() {
      isLoading = true;
    });

    try {
      String message = await apiService.checkPassword(
        token,
        passwordController.text.trim(),
      );

      // Jika berhasil, tampilkan toast dan navigasi ke halaman berikutnya
      toastification.show(
        context: context,
        title: Text(message),
        type: ToastificationType.success,
        style: ToastificationStyle.fillColored,
        autoCloseDuration: const Duration(seconds: 5),
        showProgressBar: false,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => EditPasswordConfirm(),
        ),
      );
    } catch (e) {
      // Tangkap error dan tampilkan pesan error
      toastification.show(
        context: context,
        title: Text(e.toString().replaceAll("Exception: ", "")),
        type: ToastificationType.error,
        style: ToastificationStyle.fillColored,
        autoCloseDuration: const Duration(seconds: 5),
        showProgressBar: false,
      );
    } finally {
      // Set isLoading kembali ke false
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double margin = BizGrowTheme.getMargin(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Password',
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Monochrome.whiteDarkMode),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilScreen(),
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(margin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Masukkan Password Lama',
              style: Bold.large.withColor(Monochrome.whiteDarkMode),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: passwordController,
              textAlign: TextAlign.center,
              obscureText: true, // Untuk menyembunyikan teks (password)
              style: Regular.body.withColor(Monochrome.whiteDarkMode),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10),
                hintText: 'Password lama', // Label dalam input field
                hintStyle:
                    Regular.body.withColor(Monochrome.lightGrey), // Warna hint
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 2), // Warna border
                  borderRadius: BorderRadius.circular(10), // Radius border
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Monochrome.whiteDarkMode,
                      width: 2), // Warna border saat tidak aktif
                  borderRadius: BorderRadius.circular(
                      10), // Radius border saat tidak aktif
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Main.lightBlue,
                      width: 2), // Warna border saat fokus
                  borderRadius:
                      BorderRadius.circular(10), // Radius border saat fokus
                ),
              ),
            ),
            SizedBox(height: 32),
            CustomButton(
              text: isLoading ? 'Memproses...' : 'Berikutnya',
              size: 'small',
              onPressed: isLoading ? null : () => _checkPassword(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MainNavigator(selectedIndex: 3),
    );
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }
}
