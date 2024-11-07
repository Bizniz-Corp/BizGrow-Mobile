import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:bizgrow_mobile_frontend/widgets/navbar.dart';
import 'package:bizgrow_mobile_frontend/themes/colors.dart';
import 'package:bizgrow_mobile_frontend/themes/text_styles.dart';
import 'package:bizgrow_mobile_frontend/screens/profil/profil_screen.dart';
import 'package:bizgrow_mobile_frontend/themes/theme.dart';
import 'package:bizgrow_mobile_frontend/widgets/button.dart';

class EditPasswordConfirm extends StatelessWidget {
  final TextEditingController passBaru = TextEditingController();
  final TextEditingController passBaruKonfirm = TextEditingController();

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
              'Masukkan Password Baru',
              style: SemiBold.large.withColor(Monochrome.whiteDarkMode),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: passBaru,
              textAlign: TextAlign.center,
              obscureText: true,
              style: Regular.body.withColor(Monochrome.whiteDarkMode),
              decoration: InputDecoration(
                hintText: 'Password Baru',
                hintStyle: Regular.body.withColor(Monochrome.lightGrey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      BorderSide(color: Monochrome.whiteDarkMode, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Main.lightBlue, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Monochrome.whiteDarkMode, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Konfirmasi Password Baru',
              style: SemiBold.large.withColor(Monochrome.whiteDarkMode),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: passBaruKonfirm,
              textAlign: TextAlign.center,
              obscureText: true,
              style: Regular.body.withColor(Monochrome.whiteDarkMode),
              decoration: InputDecoration(
                hintText: 'Konfirmasi Password  Baru',
                hintStyle: Regular.body.withColor(Monochrome.lightGrey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      BorderSide(color: Monochrome.whiteDarkMode, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Main.lightBlue, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Monochrome.whiteDarkMode, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              ),
            ),
            SizedBox(height: 40),
            CustomButton(
              text: 'Simpan',
              size: 'small',
              onPressed: () {
                if (passBaru.text == passBaruKonfirm.text) {
                  toastification.show(
                    context: context,
                    title: Text('Password Baru Berhasil Disimpan'),
                    type: ToastificationType.success,
                    style: ToastificationStyle.fillColored,
                    autoCloseDuration: const Duration(seconds: 3),
                    showProgressBar: false,
                  );
                  Future.delayed(const Duration(seconds: 3), () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfilScreen()));
                  });
                } else {
                  toastification.show(
                      context: context,
                      title: Text('Password Baru Tidak Sama!'),
                      type: ToastificationType.error,
                      style: ToastificationStyle.fillColored,
                      autoCloseDuration: const Duration(seconds: 3),
                      showProgressBar: false);
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: MainNavigator(selectedIndex: 3),
    );
  }
}
