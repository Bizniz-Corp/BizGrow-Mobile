import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bizgrow_mobile_frontend/themes/colors.dart';
import 'package:bizgrow_mobile_frontend/themes/theme.dart';
import 'package:bizgrow_mobile_frontend/themes/text_styles.dart';
import 'package:bizgrow_mobile_frontend/widgets/navbar.dart'; // Removed FontAwesome import

class BerandaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Beranda',
          style: GoogleFonts.montserrat(
            fontSize: 28,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Main.background,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset(
              'lib/assets/navbar_icon/Logo.png', // Sesuaikan path logo Anda
              height: 40,
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        color: Main.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting text
            Text(
              'Selamat datang, Nama',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Monochrome.whiteDarkMode,
                letterSpacing: -0.5,
              ),
            ),
            SizedBox(height: 10),

            // Status message box
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFF2D2F7E),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Semua berjalan dengan baik',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.check_circle,
                    color: Colors.greenAccent,
                    size: 24,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Profit section
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF2D2F7E),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Profit minggu ini',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                    width: 500,
                  ),
                  Text(
                    'Rp700.000,00',
                    style: GoogleFonts.montserrat(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Quick Access Title
            Text(
              'Akses Fitur Cepat',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),

            // Quick access grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildQuickAccessButton(
                    context,
                    Icons.people,
                    'Demand',
                  ),
                  _buildQuickAccessButton(
                    context,
                    Icons.inventory,
                    'Buffer Stock',
                  ),
                  _buildQuickAccessButton(
                    context,
                    Icons.show_chart,
                    'Profit',
                  ),
                  _buildQuickAccessButton(
                    context,
                    Icons.list_alt,
                    'Riwayat Penjualan',
                  ),
                  _buildQuickAccessButton(
                    context,
                    Icons.list_alt,
                    'Riwayat Stok',
                  ),
                  _buildQuickAccessButton(
                    context,
                    Icons.upload,
                    'Input Data Penjualan',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MainNavigator(selectedIndex: 0),
    );
  }

  // Helper function to create Quick Access Buttons
  Widget _buildQuickAccessButton(
    BuildContext context,
    IconData icon,
    String label,
  ) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          color: Color(0xFF2D2F7E),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 50,
            ),
            SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 12,
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
