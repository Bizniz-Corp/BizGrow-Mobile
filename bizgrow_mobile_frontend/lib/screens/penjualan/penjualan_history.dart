import 'package:bizgrow_mobile_frontend/screens/penjualan/penjualan_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bizgrow_mobile_frontend/themes/colors.dart';
import 'package:bizgrow_mobile_frontend/themes/text_styles.dart';
import 'package:bizgrow_mobile_frontend/widgets/navbar.dart';

class PenjualanHistory extends StatefulWidget {
  @override
  _PenjualanHistoryState createState() => _PenjualanHistoryState();
}

class _PenjualanHistoryState extends State<PenjualanHistory> {
  final List<Map<String, dynamic>> dataPenjualan = [
    {
      'Produk': 'Ayam Bakar Nashville',
      'ID': '001',
      'Tgl': '2024-10-22',
      'Kuantitas': 100,
      'Total': 2400000,
    },
    {
      'Produk': 'Sate Ayam',
      'ID': '002',
      'Tgl': '2024-10-21',
      'Kuantitas': 5,
      'Total': 125000,
    },
    {
      'Produk': 'Nasi Goreng',
      'ID': '003',
      'Tgl': '2024-10-20',
      'Kuantitas': 2,
      'Total': 50000,
    },
    {
      'Produk': 'Mie Goreng',
      'ID': '004',
      'Tgl': '2024-10-19',
      'Kuantitas': 4,
      'Total': 100000,
    },
    {
      'Produk': 'Tahu Tempe',
      'ID': '005',
      'Tgl': '2024-10-18',
      'Kuantitas': 10,
      'Total': 70000,
    },
  ];

  DateTime selectedDateFrom = DateTime(2024, 10, 19);
  DateTime selectedDateTo = DateTime(2024, 10, 19);
  String? selectedProduct;

  // Fungsi untuk mereset filter
  void _resetFilters() {
    setState(() {
      // Reset tanggal dan produk
      selectedDateFrom = DateTime.now();
      selectedDateTo = DateTime.now();
      selectedProduct = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Main.background,
      appBar: AppBar(
        backgroundColor: Main.darkBlue,
        title: Text(
          'Riwayat Penjualan',
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Monochrome.whiteDarkMode),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    PenjualanScreen(), // Navigasi ke halaman PenjualanHistory
              ),
            ); // Ini untuk kembali ke halaman sebelumnya
          },
        ),
        titleSpacing: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () =>
                      _showFilterDialog(context), // Memunculkan dialog filter
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'lib/assets/essential_icon/filter-icon.png',
                        width: 30,
                        height: 30,
                      ),
                      Text('Filter',
                          style: SemiBold.small
                              .withColor(Monochrome.whiteDarkMode))
                    ],
                  ),
                ),
                SizedBox(width: 8),
                FilterDateOption(
                  title: 'Date From',
                  selectedDate: selectedDateFrom,
                  onSelectDate: () => _selectDate(context, true),
                ),
                SizedBox(width: 8),
                FilterDateOption(
                  title: 'Date To',
                  selectedDate: selectedDateTo,
                  onSelectDate: () => _selectDate(context, false),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: _resetFilters,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'lib/assets/essential_icon/refresh-circle-icon.png',
                        width: 30,
                        height: 30,
                      ),
                      Text('Reset',
                          style: SemiBold.small
                              .withColor(Monochrome.whiteDarkMode))
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Produk',
                      style: SemiBold.body.withColor(Monochrome.whiteDarkMode)),
                  Text('Kuantitas',
                      style: SemiBold.body.withColor(Monochrome.whiteDarkMode)),
                  Text('Total',
                      style: SemiBold.body.withColor(Monochrome.whiteDarkMode)),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                child: ListView.builder(
                  itemCount: dataPenjualan.length, // Jumlah item di ListView
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Main.blueSecondary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 150,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(dataPenjualan[index]['Produk'],
                                        style: SemiBold.body.withColor(
                                            Monochrome.whiteDarkMode)),
                                    SizedBox(height: 4),
                                    Text('ID ${dataPenjualan[index]['ID']}',
                                        style: Regular.small.withColor(
                                            Monochrome.whiteDarkMode)),
                                    Text(dataPenjualan[index]['Tgl'],
                                        style: Regular.small.withColor(
                                            Monochrome.whiteDarkMode)),
                                  ],
                                ),
                              ),
                              Container(
                                width: 50,
                                child: Text(
                                    dataPenjualan[index]['Kuantitas']
                                        .toString(),
                                    style: SemiBold.body
                                        .withColor(Monochrome.whiteDarkMode)),
                              ),
                              Text(
                                  'Rp${dataPenjualan[index]['Total'].toString()}',
                                  style: SemiBold.body
                                      .withColor(Monochrome.whiteDarkMode)),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MainNavigator(selectedIndex: 1),
    );
  }

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        if (isFromDate) {
          selectedDateFrom = pickedDate; // Update 'Date From'
        } else {
          selectedDateTo = pickedDate; // Update 'Date To'
        }
      });
    }
  }

  void _showFilterDialog(BuildContext context) {
    // Sample list of products for filtering
    List<String> products = [
      'Semua',
      'Ayam Bakar Nashville',
      'Sate Ayam',
      'Nasi Goreng',
      'Mie Goreng',
      'Tahu Tempe',
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Filter Produk',
              style: SemiBold.large.withColor(Monochrome.whiteDarkMode)),
          backgroundColor: Main.darkBlue,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Cari Produk',
                  hintText: 'Masukkan nama produk',
                  labelStyle: Regular.body
                      .withColor(Monochrome.whiteDarkMode), // Ubah warna label
                  hintStyle: Regular.body
                      .withColor(Monochrome.grey), // Ubah warna hint
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color:
                            Monochrome.grey), // Warna border saat tidak aktif
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Main.lightBlue), // Warna border saat fokus
                  ),
                ),
                style: Regular.body.withColor(
                    Monochrome.whiteDarkMode), // Ubah warna teks input
                onChanged: (value) {
                  // Implement your search filtering logic here
                },
              ),
              SizedBox(height: 10),
              // List of products
              Container(
                height: 150, // Adjust height as needed
                width: double.maxFinite,
                decoration: BoxDecoration(color: Main.darkBlue),
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(products[index],
                          style:
                              Regular.body.withColor(Monochrome.whiteDarkMode)),
                      onTap: () {
                        // Apply filter logic here
                        selectedProduct = products[index];
                        Navigator.of(context).pop(); // Close the dialog
                        // Implement your filtering logic to update the ListView on the main page
                        print("Selected product: ${products[index]}");
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              style: TextButton.styleFrom(
                backgroundColor:
                    Main.blueSecondary, // Warna background untuk button
                padding: EdgeInsets.symmetric(
                    vertical: 10, horizontal: 20), // Padding untuk button
              ),
              child: Text(
                'Tutup',
                style: SemiBold.body.withColor(Monochrome.whiteDarkMode),
              ),
            ),
          ],
        );
      },
    );
  }
}

class FilterDateOption extends StatelessWidget {
  final String title;
  final DateTime selectedDate;
  final VoidCallback onSelectDate;

  const FilterDateOption({
    required this.title,
    required this.selectedDate,
    required this.onSelectDate,
  });

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('d MMMM yyyy').format(selectedDate);
    return GestureDetector(
      onTap: onSelectDate,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: SemiBold.body.withColor(Monochrome.white)),
          SizedBox(height: 4),
          Row(
            children: [
              Text(formattedDate,
                  style: Regular.body.withColor(Monochrome.white)),
              SizedBox(width: 4),
              Image.asset(
                'lib/assets/essential_icon/arrow-circle-down-icon.png',
                width: 16,
                height: 16,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
