import 'package:bizgrow_mobile_frontend/screens/profil/profil_edit_photo.dart';
import 'package:bizgrow_mobile_frontend/themes/colors.dart';
import 'package:bizgrow_mobile_frontend/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bizgrow_mobile_frontend/themes/theme.dart';
import 'package:bizgrow_mobile_frontend/themes/text_styles.dart';

class ProfilEditScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profil'),
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
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilEditPhotoScreen()));
                      },
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
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
              decoration: InputDecoration(
                hintText: 'Budi', // Placeholder
                labelStyle: TextStyle(
                  color: Monochrome.white, // Warna label
                ),
                hintStyle: TextStyle(
                  color: Monochrome.white, // Warna placeholder
                ),

                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // Border melengkung
                ),
              ),
              style: TextStyle(color: Monochrome.white),
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
              decoration: InputDecoration(
                hintText: 'a@gmail.com', // Placeholder
                labelStyle: TextStyle(
                  color: Monochrome.white, // Warna label
                ),
                hintStyle: TextStyle(
                  color: Monochrome.white, // Warna placeholder
                ),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // Border melengkung
                ),
              ),
              style: TextStyle(color: Monochrome.white),
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
                  backgroundColor: Main.blueSecondary,
                  foregroundColor: Monochrome.white,
                ),
                child: Text('Ubah Password'),
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Main.blueSecondary,
                  foregroundColor: Monochrome.white,
                ),
                child: Text('Simpan'),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: MainNavigator(selectedIndex: 3),
    );
  }
}
