import 'package:flutter/material.dart';
import 'edit_password_confirm.dart';
import 'package:bizgrow_mobile_frontend/themes/colors.dart';
import 'package:bizgrow_mobile_frontend/themes/text_styles.dart';
import 'package:bizgrow_mobile_frontend/widgets/navbar.dart';

class EditPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        padding:
            const EdgeInsets.symmetric(horizontal: 32), // Padding untuk halaman
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Masukkan Password Lama',
              style: Bold.large.withColor(Monochrome.whiteDarkMode),
            ),
            SizedBox(height: 16),
            // TextField untuk input password
            TextFormField(
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
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        EditPasswordConfirm(), // Navigasi ke halaman PenjualanHistory
                  ),
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
                'Berikutnya',
                style: SemiBold.large.withColor(Monochrome.whiteDarkMode),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MainNavigator(selectedIndex: 3),
    );
  }
}
