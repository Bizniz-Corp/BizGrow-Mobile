import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bizgrow_mobile_frontend/widgets/navbar.dart';

class InputDataPenjualanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Input Data Penjualan',
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
            SizedBox(height: 100),
            Expanded(
              child: GridView.count(
                crossAxisCount: 1,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 8.0, // Mengatur tinggi kotak agar lebih besar
                children: [
                  buildMenuButton(
                    context,
                    'Input Data Manual',
                    () {
                      // Navigasi ke halaman Prediksi Demand
                    },
                  ),
                  buildMenuButton(
                    context,
                    'Input Data File',
                    () {
                      // Navigasi ke halaman Riwayat Penjualan
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MainNavigator(selectedIndex: 1),
    );
  }

  Widget buildMenuButton(BuildContext context, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF2D2F7E), // Warna biru dari kotak menu
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
