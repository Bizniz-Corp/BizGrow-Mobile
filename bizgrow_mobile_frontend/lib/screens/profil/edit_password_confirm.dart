import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:bizgrow_mobile_frontend/widgets/navbar.dart';
import 'package:bizgrow_mobile_frontend/themes/colors.dart';
import 'package:bizgrow_mobile_frontend/themes/text_styles.dart';

class EditPasswordConfirm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Main.background,
      appBar: AppBar(
        backgroundColor: Main.darkBlue,
        title: Text(
          'Edit Profil',
          style: Bold.large.withColor(Monochrome.whiteDarkMode),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Monochrome.whiteDarkMode),
          onPressed: () {
            Navigator.pop(context); // Ini untuk kembali ke halaman sebelumnya
          },
        ),
        titleSpacing: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildPasswordInput(
              label: 'Masukkan Password Baru',
            ),
            SizedBox(height: 20),
            _buildPasswordInput(
              label: 'Konfirmasi Password Baru',
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // TODO: Add save password logic here
                toastification.show(
                  context: context,
                  title: Text('Password Baru Berhasil Disimpan'),
                  type: ToastificationType.success,
                  style: ToastificationStyle.fillColored,
                  autoCloseDuration: const Duration(seconds: 5),
                  showProgressBar: false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Main.blueSecondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              ),
              child: Text(
                'Simpan',
                style: SemiBold.large.withColor(Monochrome.whiteDarkMode),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MainNavigator(selectedIndex: 3),
    );
  }

  Widget _buildPasswordInput({required String label}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: SemiBold.large.withColor(Monochrome.whiteDarkMode),
        ),
        SizedBox(height: 16),
        TextFormField(
          textAlign: TextAlign.center,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Password Baru',
            hintStyle: Regular.body.withColor(Monochrome.lightGrey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Monochrome.whiteDarkMode, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Main.lightBlue, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Monochrome.whiteDarkMode, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          ),
          style: Regular.body.withColor(Monochrome.whiteDarkMode),
        ),
      ],
    );
  }
}
