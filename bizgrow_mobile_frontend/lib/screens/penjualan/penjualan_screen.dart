import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bizgrow_mobile_frontend/themes/theme.dart';
import 'package:bizgrow_mobile_frontend/themes/text_styles.dart';
import 'package:bizgrow_mobile_frontend/widgets/navbar.dart';
import 'package:bizgrow_mobile_frontend/screens/penjualan/input_data_penjualan.dart'; 
import 'package:bizgrow_mobile_frontend/screens/penjualan/penjualan_prediksi_demand_screen.dart';
import 'package:bizgrow_mobile_frontend/screens/penjualan/penjualan_history.dart'; 
import 'package:bizgrow_mobile_frontend/screens/penjualan/penjualan_prediksi_profit_screen.dart';

class PenjualanScreen extends StatelessWidget {
  const PenjualanScreen({super.key});

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
      ),
      body: Container(
        color: Color(0xFF0A092E), 
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
                childAspectRatio: 1.0, 
                children: [
                  buildMenuButton(
                    context,
                    'Prediksi Demand',
                    'lib/assets/navbar_icon/Prediksi_Demand.png',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PrediksiDemandScreen(),
                        ),
                      );
                    },
                  ),
                  buildMenuButton(
                    context,
                    'Riwayat Penjualan',
                    'lib/assets/navbar_icon/Riwayat.png',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PenjualanHistory(),
                        ),
                      );
                    },
                  ),
                  buildMenuButton(
                    context,
                    'Prediksi Profit',
                    'lib/assets/navbar_icon/Prediksi_Profit.png',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PrediksiProfitScreen(),
                        ),
                      );
                    },
                  ),
                  buildMenuButton(
                    context,
                    'Input Data Penjualan',
                    'lib/assets/navbar_icon/Input.png',
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

  Widget buildMenuButton(BuildContext context, String title, String imagePath,
      VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 13, 1, 107),
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
