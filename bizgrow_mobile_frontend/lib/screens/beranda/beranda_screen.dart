import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bizgrow_mobile_frontend/themes/colors.dart';
import 'package:bizgrow_mobile_frontend/themes/theme.dart';
import 'package:bizgrow_mobile_frontend/themes/text_styles.dart';
import 'package:bizgrow_mobile_frontend/widgets/navbar.dart';
import 'package:bizgrow_mobile_frontend/screens/penjualan/input_data_penjualan.dart';

class BerandaScreen extends StatelessWidget {
  const BerandaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beranda'),
      ),
      body: Container(
        margin: EdgeInsets.all(BizGrowTheme.getMargin(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting text
            Text(
              'Selamat datang, Nama UMKM',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                color: Monochrome.whiteDarkMode,
                letterSpacing: -0.5,
              ),
            ),
            SizedBox(height: 20),

            // Total Penjualan
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Total Penjualan'),
                      content: Text('Total penjualan yang ditampilkan adalah untuk bulan ini.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Tutup'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 13, 1, 107),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Penjualan',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Rp 700.000,00',
                      style: GoogleFonts.montserrat(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Total Pembelian
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Total Pembelian'),
                      content: Text('Total pembelian yang ditampilkan adalah untuk bulan ini.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Tutup'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 13, 1, 107),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Pembelian',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Rp 500.000,00',
                      style: GoogleFonts.montserrat(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
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
                    Icons.people,
                    'Demand',
                    InputDataPenjualanScreen(),
                  ),
                  _buildQuickAccessButton(
                    context,
                    Icons.inventory,
                    'Buffer Stock',
                    InputDataPenjualanScreen(),
                  ),
                  _buildQuickAccessButton(
                    context,
                    Icons.show_chart,
                    'Profit',
                    InputDataPenjualanScreen(),
                  ),
                  _buildQuickAccessButton(
                    context,
                    Icons.history,
                    'Riwayat Penjualan',
                    InputDataPenjualanScreen(),
                  ),
                  _buildQuickAccessButton(
                    context,
                    Icons.list_alt,
                    'Riwayat Stok',
                    InputDataPenjualanScreen(),
                  ),
                  _buildQuickAccessButton(
                    context,
                    Icons.upload,
                    'Input Data Penjualan',
                    InputDataPenjualanScreen(),
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
    Widget targetScreen,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetScreen),
        );
      },
      child: Container(
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
      ),
    );
  }
}