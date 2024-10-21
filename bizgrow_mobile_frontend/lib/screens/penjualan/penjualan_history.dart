import 'package:flutter/material.dart';
import 'package:bizgrow_mobile_frontend/styles/colors.dart';
import 'package:bizgrow_mobile_frontend/widgets/navbar.dart';

class PenjualanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          MainColors.darkBlue, // Sesuai warna background pada gambar
      appBar: AppBar(
        backgroundColor: MainColors.darkBlue,
        title: Text('Riwayat Penjualan', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FilterDateOption(title: 'Date From', date: '19 Oktober 2024'),
                FilterDateOption(title: 'Date To', date: '19 Oktober 2024'),
                Icon(Icons.filter_alt_outlined, color: Colors.white),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Produk',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                Text('Kuantitas',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                Text('Total',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5, // Jumlah item di ListView, bisa diubah
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: MainColors.blueSecondary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ayam Bakar Nashville',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'ID 136-809\n19 Oktober 2024',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('100',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                          SizedBox(height: 4),
                          Text('Rp480.000.000',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          MainNavigator(), // Bottom Navigation dari file navbar.dart
    );
  }
}

class FilterDateOption extends StatelessWidget {
  final String title;
  final String date;

  const FilterDateOption({required this.title, required this.date});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: TextStyle(color: Colors.white)),
        SizedBox(height: 4),
        Text(date, style: TextStyle(color: Colors.white, fontSize: 16)),
      ],
    );
  }
}
