import 'package:bizgrow_mobile_frontend/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bizgrow_mobile_frontend/themes/colors.dart';
import 'package:bizgrow_mobile_frontend/themes/theme.dart';
import 'package:bizgrow_mobile_frontend/themes/text_styles.dart';
import 'package:bizgrow_mobile_frontend/screens/stok/input_data_stok.dart'; 
import 'package:bizgrow_mobile_frontend/screens/stok/stok_history.dart';
import 'package:bizgrow_mobile_frontend/screens/stok/stok_prediksi_screen.dart';

class StokScreen extends StatelessWidget {
  const StokScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Stok',
          style: GoogleFonts.montserrat(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF1D1B46), // Warna biru tua dari gambar
      ),
      body: Container(
        color: Color(0xFF1D1B46), // Latar belakang warna biru tua
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pilih Menu',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3, // Set ke 2 kolom
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 1.0, // Mengatur tinggi kotak agar lebih besar
                children: [
                  buildMenuButton(
                    context,
                    'Prediksi Stok',
                    'lib/assets/navbar_icon/Prediksi_Stok.png',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PrediksiStokScreen(),
                        ),
                      );
                    },
                  ),
                  buildMenuButton(
                    context,
                    'Riwayat Stok',
                    'lib/assets/navbar_icon/Riwayat.png',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StokHistory(),
                        ),
                      );
                    },
                  ),
                  buildMenuButton(
                    context,
                    'Input Data Stok',
                    'lib/assets/navbar_icon/Input.png',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InputDataStokScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MainNavigator(selectedIndex: 2),
    );
  }

  // Tambahkan parameter `imagePath` untuk gambar
  Widget buildMenuButton(BuildContext context, String title, String imagePath,
      VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF2D2F7E), // Warna biru dari kotak menu
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 50,
              height: 50,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
