import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bizgrow_mobile_frontend/themes/colors.dart';
import 'package:bizgrow_mobile_frontend/themes/text_styles.dart';
import 'package:bizgrow_mobile_frontend/widgets/navbar.dart';
import 'package:bizgrow_mobile_frontend/screens/stok/stok_screen.dart';
import 'package:bizgrow_mobile_frontend/themes/theme.dart';
import 'package:bizgrow_mobile_frontend/widgets/button.dart';
import 'package:flutter/services.dart';
import 'package:bizgrow_mobile_frontend/services/api_service.dart';
import 'package:bizgrow_mobile_frontend/models/stock_change.dart';

class StokHistory extends StatefulWidget {
  // final String token;
  const StokHistory({super.key});

  @override
  _StokHistoryState createState() => _StokHistoryState();
}

class _StokHistoryState extends State<StokHistory> {
  final ApiService apiService = ApiService();
  late Future<List<StockChange>> futureStockHistory;

  final String token = "9|8h5vfax7jPtZff4xFAw78GqYdZHCzJWKMvU1TDwwba6f6d63";

  DateTime selectedDateFrom = DateTime.now();
  DateTime selectedDateTo = DateTime.now();
  String? selectedProduct;

  List<StockChange> stokList = [];
  List<StockChange> filteredStokList = [];

  // Fungsi untuk mereset filter
  void _resetFilters() {
    setState(() {
      selectedDateFrom = DateTime.now();
      selectedDateTo = DateTime.now();
      selectedProduct = "Semua";
      filteredStokList = stokList;
    });
  }

  // Fungsi untuk membaca file JSON dan mengubahnya ke objek Penjualan
  // Future<void> loadStokData() async {
  //   String jsonString =
  //       await rootBundle.loadString('lib/assets/data/stok.json');

  //   // Parsing JSON
  //   List<dynamic> jsonResponse = json.decode(jsonString);
  //   setState(() {
  //     stokList = jsonResponse.map((data) => Stok.fromJson(data)).toList();
  //     filteredStokList = stokList;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    futureStockHistory = apiService.fetchStockHistory(token);
  }

  @override
  Widget build(BuildContext context) {
    double margin = BizGrowTheme.getMargin(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Riwayat Stok',
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Monochrome.whiteDarkMode),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    StokScreen(), // Navigasi ke halaman PenjualanHistory
              ),
            ); // Ini untuk kembali ke halaman sebelumnya
          },
        ),
      ),
      body: FutureBuilder<List<StockChange>>(
          future: futureStockHistory,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Tidak ada data penjualan'));
            } else {
              final stockHistory = snapshot.data!;
              return Padding(
                padding: EdgeInsets.all(margin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomButton(
                          width: MediaQuery.of(context).size.width * 0.35,
                          text: 'Filter',
                          size: 'small',
                          iconPath: 'lib/assets/essential_icon/filter-icon.png',
                          buttonType: 'leftIcon',
                          onPressed: () {
                            _showFilterDialog(context);
                          },
                        ),
                        SizedBox(width: 8),
                        CustomButton(
                          width: MediaQuery.of(context).size.width * 0.35,
                          text: 'Reset',
                          size: 'small',
                          iconPath:
                              'lib/assets/essential_icon/refresh-circle-icon.png',
                          buttonType: 'leftIcon',
                          onPressed: () {
                            _resetFilters();
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FilterDateOption(
                          title: 'Tanggal Awal',
                          selectedDate: selectedDateFrom,
                          onSelectDate: () => _selectDate(context, true),
                        ),
                        SizedBox(width: 8),
                        FilterDateOption(
                          title: 'Tanggal Akhir',
                          selectedDate: selectedDateTo,
                          onSelectDate: () => _selectDate(context, false),
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
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: Text('Produk',
                                style: SemiBold.body
                                    .withColor(Monochrome.whiteDarkMode)),
                          ),
                          Text('Perubahan',
                              style: SemiBold.body
                                  .withColor(Monochrome.whiteDarkMode)),
                          Text('Total',
                              style: SemiBold.body
                                  .withColor(Monochrome.whiteDarkMode)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount:
                            stockHistory.length, // Jumlah item di ListView
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final stok = stockHistory[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Main.blueSecondary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(stok.productName,
                                              style: SemiBold.body.withColor(
                                                  Monochrome.whiteDarkMode)),
                                          Text(stok.changesDate,
                                              style: Regular.small.withColor(
                                                  Monochrome.whiteDarkMode)),
                                        ],
                                      ),
                                    ),
                                    Text(stok.changesQuantity.toString(),
                                        style: SemiBold.body.withColor(
                                            Monochrome.whiteDarkMode)),
                                    Text('${stok.totalStock.toString()} Stok',
                                        style: SemiBold.body.withColor(
                                            Monochrome.whiteDarkMode)),
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
              );
            }
          }),
      bottomNavigationBar: MainNavigator(selectedIndex: 1),
    );
  }

  //Function untuk merubah input tanggal string, menjadi bentuk format DD-MM-YYYY
  String formatTanggal(String tanggal) {
    // Parse string tanggal ke format DateTime dengan format MM/dd/yyyy
    DateTime parsedDate = DateFormat("MM/dd/yyyy").parse(tanggal);
    // Ubah format tanggal ke format dd-MM-yyyy
    String formattedDate = DateFormat("dd-MM-yyyy").format(parsedDate);
    return formattedDate;
  }

  //Procedure untuk memilih/membuka date picker
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
        applyFilters(); // Terapkan filter gabungan setelah tanggal dipilih
      });
    }
  }

  //Function untuk mendapatkan listproduk untuk list di filter
  List<String> getListProduk(List<StockChange> stokList) {
    List<String> temp = [];

    for (var item in stokList) {
      if (!temp.contains(item.productName)) {
        temp.add(item.productName);
      }
    }
    temp.sort();
    temp.insert(0, "Semua");

    return temp;
  }

  //Procedure untuk melakukan filtering produk
  void filterStokByProduct(String? selectedProduct) {
    setState(() {
      this.selectedProduct = selectedProduct;
      applyFilters(); // Terapkan filter gabungan setelah produk dipilih
    });
  }

  // Fungsi untuk menggabungkan filter berdasarkan tanggal dan produk
  void applyFilters() {
    setState(() {
      filteredStokList = stokList.where((stok) {
        // Filter berdasarkan rentang tanggal
        DateTime stokDate = DateFormat("MM/dd/yyyy").parse(stok.changesDate);
        bool dateMatches =
            stokDate.isAfter(selectedDateFrom.subtract(Duration(days: 1))) &&
                stokDate.isBefore(selectedDateTo.add(Duration(days: 1)));

        // Filter berdasarkan produk
        bool productMatches =
            selectedProduct == "Semua" || stok.productName == selectedProduct;

        // Gabungkan kedua filter
        return dateMatches && productMatches;
      }).toList();
    });
  }

  //Procedure untuk menampilkan dialog ketika menekan filter
  void _showFilterDialog(BuildContext context) {
    List<String> products = getListProduk(stokList);

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
              Container(
                  height: 2,
                  width: double.maxFinite,
                  decoration: BoxDecoration(color: Monochrome.whiteDarkMode)),
              Container(
                height: 300,
                width: double.maxFinite,
                decoration: BoxDecoration(color: Main.darkBlue),
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(products[index],
                          style: SemiBold.body
                              .withColor(Monochrome.whiteDarkMode)),
                      onTap: () {
                        selectedProduct = products[index];
                        Navigator.of(context).pop();
                        filterStokByProduct(selectedProduct);
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
          Text(title, style: SemiBold.small.withColor(Monochrome.white)),
          SizedBox(height: 4),
          Row(
            children: [
              Text(formattedDate,
                  style: Regular.small.withColor(Monochrome.white)),
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
