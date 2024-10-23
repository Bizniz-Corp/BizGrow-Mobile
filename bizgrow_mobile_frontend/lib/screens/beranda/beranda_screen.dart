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
        title: Text('Beranda'),
        backgroundColor: const Color.fromARGB(255, 13, 1, 107), // Custom color
      ),
      body: Container(
        margin: EdgeInsets.all(BizGrowTheme.getMargin(context)),
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
                color: const Color.fromARGB(255, 13, 1, 107),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Semua berjalan dengan baik',
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      color: Colors.white,
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
                color: const Color.fromARGB(255, 13, 1, 107),
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
                    ),
                  ),
                  SizedBox(height: 10),
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

            // Quick access grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildQuickAccessButton(
                    context,
                    Icons
                        .people, // Replaced FontAwesome with standard Flutter icon
                    'Demand',
                  ),
                  _buildQuickAccessButton(
                    context,
                    Icons
                        .inventory, // Replaced FontAwesome with standard Flutter icon
                    'Buffer Stock',
                  ),
                  _buildQuickAccessButton(
                    context,
                    Icons
                        .show_chart, // Replaced FontAwesome with standard Flutter icon
                    'Profit',
                  ),
                  _buildQuickAccessButton(
                    context,
                    Icons
                        .history, // Replaced FontAwesome with standard Flutter icon
                    'Riwayat Penjualan',
                  ),
                  _buildQuickAccessButton(
                    context,
                    Icons
                        .list_alt, // Replaced FontAwesome with standard Flutter icon
                    'Riwayat Stok',
                  ),
                  _buildQuickAccessButton(
                    context,
                    Icons
                        .upload, // Replaced FontAwesome with standard Flutter icon
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
      BuildContext context, IconData icon, String label) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 13, 1, 107),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 32,
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
