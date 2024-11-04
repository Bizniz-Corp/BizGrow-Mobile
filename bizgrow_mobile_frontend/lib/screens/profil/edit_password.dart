import 'package:bizgrow_mobile_frontend/screens/profil/profil_screen.dart';
import 'package:flutter/material.dart';
import 'edit_password_confirm.dart';
import 'package:toastification/toastification.dart';
import 'package:bizgrow_mobile_frontend/themes/theme.dart';
import 'package:bizgrow_mobile_frontend/themes/colors.dart';
import 'package:bizgrow_mobile_frontend/themes/text_styles.dart';
import 'package:bizgrow_mobile_frontend/widgets/navbar.dart';
import 'package:bizgrow_mobile_frontend/widgets/button.dart';

class EditPassword extends StatelessWidget {
  final TextEditingController passwordController = TextEditingController();
  final String passLama = 'iniPass123';

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
                text: 'Berikutnya',
                size: 'small',
                onPressed: () {
                  if (passwordController.text == passLama) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditPasswordConfirm(),
                      ),
                    );
                  } else {
                    toastification.show(
                      context: context,
                      title: Text('Password salah! Coba lagi'),
                      type: ToastificationType.error,
                      style: ToastificationStyle.fillColored,
                      autoCloseDuration: const Duration(seconds: 5),
                      showProgressBar: false,
                    );
                  }
                }),
          ],
        ),
      ),
      bottomNavigationBar: MainNavigator(selectedIndex: 3),
    );
  }
}
