import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bizgrow_mobile_frontend/themes/colors.dart';
import 'package:bizgrow_mobile_frontend/themes/theme.dart';
import 'package:bizgrow_mobile_frontend/widgets/navbar.dart';
import 'package:bizgrow_mobile_frontend/services/api_service.dart';
import 'package:intl/intl.dart';
import 'package:bizgrow_mobile_frontend/screens/penjualan/input_data_penjualan.dart';
import 'package:bizgrow_mobile_frontend/screens/penjualan/penjualan_history.dart';
import 'package:bizgrow_mobile_frontend/screens/stok/stok_history.dart';
import 'package:bizgrow_mobile_frontend/screens/penjualan/penjualan_prediksi_demand_screen.dart';
import 'package:bizgrow_mobile_frontend/screens/penjualan/penjualan_prediksi_profit_screen.dart';
import 'package:bizgrow_mobile_frontend/screens/stok/stok_prediksi_screen.dart';

class BerandaScreen extends StatefulWidget {
  const BerandaScreen({super.key});

  @override
  _BerandaScreenState createState() => _BerandaScreenState();
}

class _BerandaScreenState extends State<BerandaScreen> {
  final String token = "1|0Qv5q5hDpjU1no6CpwvTpzaT9D9N2PihAmc8ibSw410e7fc4"; // Token untuk autentikasi API

  double totalPembelian = 0.0;
  double totalPenjualan = 0.0;
  String umkmName = "Nama UMKM";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final apiService = ApiService();

    try {
      // Ambil data profit
      final profitData = await apiService.getMonthlyProfit(token);
      // Ambil data profil
      final profileData = await apiService.getProfile(token);

      setState(() {
        totalPembelian = double.tryParse(profitData['total_pembelian'].toString()) ?? 0.0;
        totalPenjualan = double.tryParse(profitData['total_penjualan'].toString()) ?? 0.0;
        umkmName = profileData['name'] ?? "Nama UMKM";
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  String formatRupiah(double amount) {
    return NumberFormat.currency(
      locale: 'id', // Locale untuk Indonesia
      symbol: 'Rp ', // Simbol rupiah
      decimalDigits: 0, // Tampilkan dua digit desimal
    ).format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beranda'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              margin: EdgeInsets.all(BizGrowTheme.getMargin(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Greeting text
                  Text(
                    'Selamat datang, $umkmName',
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      color: Monochrome.whiteDarkMode,
                      letterSpacing: -0.5,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Total Penjualan
                  _buildInfoCard(
                    context,
                    'Total Penjualan',
                    totalPenjualan,
                    'Total penjualan yang ditampilkan adalah untuk bulan ini.',
                  ),
                  SizedBox(height: 20),

                  // Total Pembelian
                  _buildInfoCard(
                    context,
                    'Total Pembelian',
                    totalPembelian,
                    'Total pembelian yang ditampilkan adalah untuk bulan ini.',
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
                          PrediksiDemandScreen(),
                        ),
                        _buildQuickAccessButton(
                          context,
                          Icons.inventory,
                          'Buffer Stock',
                          PrediksiStokScreen(),
                        ),
                        _buildQuickAccessButton(
                          context,
                          Icons.show_chart,
                          'Profit',
                          PrediksiProfitScreen(),
                        ),
                        _buildQuickAccessButton(
                          context,
                          Icons.history,
                          'Riwayat Penjualan',
                          PenjualanHistory(),
                        ),
                        _buildQuickAccessButton(
                          context,
                          Icons.list_alt,
                          'Riwayat Stok',
                          StokHistory(),
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

  Widget _buildInfoCard(
    BuildContext context,
    String title,
    double value,
    String description,
  ) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title),
              content: Text(description),
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
              title,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '${formatRupiah(value)}',
              style: GoogleFonts.montserrat(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

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
