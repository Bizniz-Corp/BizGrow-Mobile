import 'package:bizgrow_mobile_frontend/screens/profil/profil_edit.dart';
import 'package:bizgrow_mobile_frontend/themes/colors.dart';
import 'package:bizgrow_mobile_frontend/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bizgrow_mobile_frontend/themes/theme.dart';
import 'package:bizgrow_mobile_frontend/themes/text_styles.dart';
import 'package:bizgrow_mobile_frontend/screens/profil/edit_password.dart';
import 'package:bizgrow_mobile_frontend/widgets/navbar.dart';

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: Container(
        margin: EdgeInsets.all(BizGrowTheme.getMargin(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Monochrome.lightGrey,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Monochrome.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Nama',
              style: GoogleFonts.montserrat(
                  fontSize: 28,
                  color: Monochrome.whiteDarkMode,
                  letterSpacing: -1),
            ),
            // DI SINI INPUT BORDER
            TextField(
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'Masukkan nama Anda', // Placeholder
                labelStyle: TextStyle(
                  color: Monochrome.white, // Warna label
                ),
                hintStyle: TextStyle(
                  color: Monochrome.white, // Warna placeholder
                ),
                fillColor: Main.lightBlue,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // Border melengkung
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Email',
              style: GoogleFonts.montserrat(
                  fontSize: 28,
                  color: Monochrome.whiteDarkMode,
                  letterSpacing: -1),
            ),
            // DI SINI INPUT BORDER
            TextField(
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'a@gmail.com', // Placeholder
                labelStyle: TextStyle(
                  color: Monochrome.white, // Warna label
                ),
                hintStyle: TextStyle(
                  color: Monochrome.white, // Warna placeholder
                ),
                fillColor: Main.lightBlue,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // Border melengkung
                ),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfilEditScreen()));
                  },
                  child: Text('Edit Profil'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Main.blueSecondary,
                    foregroundColor: Monochrome.white,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/profil/prof');
                  },
                  child: Text('Hapus Akun'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: additionalColor.red,
                    foregroundColor: Monochrome.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: additionalColor.red,
                  foregroundColor: Monochrome.white,
                ),
                child: Text('Keluar'),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: MainNavigator(selectedIndex: 3),
    );
  }
}
