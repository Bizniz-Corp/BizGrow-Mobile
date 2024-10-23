import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bizgrow_mobile_frontend/widgets/navbar.dart';
import 'package:bizgrow_mobile_frontend/screens/penjualan/input_data_penjualan.dart'; // Pastikan ini diimpor

class PenjualanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Penjualan',
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
                crossAxisCount: 3,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 1.2, // Mengatur tinggi kotak agar lebih besar
                children: [
                  buildMenuButton(
                    context,
                    'Prediksi Demand',
                    () {
                      // Navigasi ke halaman Prediksi Demand
                    },
                  ),
                  buildMenuButton(
                    context,
                    'Riwayat Penjualan',
                    () {
                      // Navigasi ke halaman Riwayat Penjualan
                    },
                  ),
                  buildMenuButton(
                    context,
                    'Prediksi Profit',
                    () {
                      // Navigasi ke halaman Prediksi Profit
                    },
                  ),
                  buildMenuButton(
                    context,
                    'Input Data Penjualan',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InputDataPenjualanScreen(),
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
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
