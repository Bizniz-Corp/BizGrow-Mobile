import 'package:bizgrow_mobile_frontend/screens/penjualan/penjualan_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:bizgrow_mobile_frontend/themes/colors.dart';
import 'package:bizgrow_mobile_frontend/themes/text_styles.dart';
import 'package:bizgrow_mobile_frontend/widgets/navbar.dart';
import 'package:bizgrow_mobile_frontend/themes/theme.dart';
import 'package:bizgrow_mobile_frontend/widgets/button.dart';
import 'package:bizgrow_mobile_frontend/models/sales_transaction.dart';
import 'package:bizgrow_mobile_frontend/models/pagination.dart';
import 'package:bizgrow_mobile_frontend/models/product.dart';
import 'package:bizgrow_mobile_frontend/services/api_service.dart';

class PenjualanHistory extends StatefulWidget {
  // final String token;
  const PenjualanHistory({super.key});

  @override
  _PenjualanHistoryState createState() => _PenjualanHistoryState();
}

class _PenjualanHistoryState extends State<PenjualanHistory> {
  final ApiService apiService = ApiService();
  // late Future<List<SalesTransaction>> futureSalesHistory;

  final String token = "27|aDo5BrgsVfh5eG3rR0PztKm4dPLUtGJk9XWsqzAgd26b4ad8";

  List<SalesTransaction> penjualanList = [];
  // List<SalesTransaction> filteredPenjualanList = [];

  // DateTime selectedDateFrom = DateTime.now().subtract(Duration(days: 30));
  DateTime? selectedDateFrom;
  DateTime? selectedDateTo;
  String? selectedProduct;
  final ScrollController _scrollController = ScrollController();

  bool isLoading = false;
  int currentPage = 1;
  int totalPages = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    fetchSalesData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Fungsi untuk mereset filter
  void _resetFilters() {
    setState(() {
      selectedDateFrom = null;
      selectedDateTo = null;
      selectedProduct = "Semua";
      currentPage = 1;
      fetchSalesData();
    });
  }

  Future<void> fetchSalesData({bool append = false}) async {
    if (isLoading || (append && currentPage > totalPages)) return;

    setState(() {
      isLoading = true;
    });

    try {
      final result = await apiService.fetchSalesHistory(
        token: token,
        page: currentPage,
        productName: selectedProduct,
        startDate: selectedDateFrom.toString(),
        endDate: selectedDateTo.toString(),
      );

      print("aaaaaaaaaaaaaaaa");
      print("Result panggil service: ${result}");

      final newTransactions = result['salesData'] as List<SalesTransaction>;
      final paginationInfo = result['pagination'] as Pagination;

      setState(() {
        if (append) {
          penjualanList.addAll(newTransactions);
        } else {
          penjualanList = newTransactions;
        }
        totalPages = paginationInfo.lastPage;
        currentPage += 1;
      });
    } catch (error) {
      print('Error fetching sales data: $error');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      fetchSalesData(append: true);
    }
  }

  void applyFilters(String? productName, DateTime? start, DateTime? end) {
    setState(() {
      currentPage = 1;
      selectedProduct = productName;
      selectedDateFrom = start;
      selectedDateTo = end;
    });

    fetchSalesData();
  }

  // Formatter tanggal ke dd-MM-yyyy
  String formatDate(String inputDate) {
    DateTime dateTime = DateTime.parse(inputDate); // Parse dari format asli
    return DateFormat('dd-MM-yyyy').format(dateTime); // Format ke dd-MM-yyyy
  }

  // Formatter ke format Rupiah
  String formatRupiah(double amount) {
    return NumberFormat.currency(
      locale: 'id', // Locale untuk Indonesia
      symbol: 'Rp', // Simbol rupiah
      decimalDigits: 0, // Tampilkan dua digit desimal
    ).format(amount);
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
        applyFilters(selectedProduct, selectedDateFrom, selectedDateTo);
      });
    }
  }

  //Function untuk mendapatkan listproduk untuk list di filter
  Future<List<String>> getListProduk() async {
    List<String> temp = [];
    final products = await apiService.fetchAllProduct(token);
    print(products);
    for (var product in products) {
      temp.add(product.productName);
    }
    temp.sort();
    temp.insert(0, "Semua");

    print("Final products: $temp");

    return temp;
  }

  @override
  Widget build(BuildContext context) {
    double margin = BizGrowTheme.getMargin(context);
    return Scaffold(
      appBar: AppBar(
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
            );
          },
        ),
      ),
      body: Padding(
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
                  width: MediaQuery.of(context).size.width * 0.38,
                  text: 'Reset',
                  size: 'small',
                  iconPath: 'lib/assets/essential_icon/refresh-circle-icon.png',
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              child: ListView.builder(
                controller: _scrollController,
                itemCount: penjualanList.length + 1,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  if (index == penjualanList.length) {
                    return isLoading
                        ? Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : SizedBox.shrink();
                  }
                  final penjualan = penjualanList[index];
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(penjualan.productName,
                                      style: SemiBold.body
                                          .withColor(Monochrome.whiteDarkMode)),
                                  Text(formatDate(penjualan.salesDate),
                                      style: Regular.small
                                          .withColor(Monochrome.whiteDarkMode)),
                                ],
                              ),
                            ),
                            Text(penjualan.salesQuantity.toString(),
                                style: Regular.body
                                    .withColor(Monochrome.whiteDarkMode)),
                            Text(formatRupiah(penjualan.total),
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
          ],
        ),
      ),
      bottomNavigationBar: MainNavigator(selectedIndex: 1),
    );
  }

  //Procedure untuk menampilkan dialog ketika menekan filter
  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Filter Produk',
              style: SemiBold.large.withColor(Monochrome.whiteDarkMode)),
          backgroundColor: Main.darkBlue,
          content: FutureBuilder<List<String>>(
              future: getListProduk(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Terjadi kesalahan: ${snapshot.error}',
                      style: SemiBold.body.withColor(Monochrome.whiteDarkMode),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      'Produk tidak ditemukan',
                      style: SemiBold.body.withColor(Monochrome.whiteDarkMode),
                    ),
                  );
                } else {
                  final products = snapshot.data!;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          height: 2,
                          width: double.maxFinite,
                          decoration:
                              BoxDecoration(color: Monochrome.whiteDarkMode)),
                      Container(
                        height: 300, // Adjust height as needed
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
                                applyFilters(selectedProduct, selectedDateFrom,
                                    selectedDateTo);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
              }),
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
  final DateTime? selectedDate;
  final VoidCallback onSelectDate;

  const FilterDateOption({
    required this.title,
    required this.selectedDate,
    required this.onSelectDate,
  });

  @override
  Widget build(BuildContext context) {
    String formattedDate = selectedDate != null
        ? DateFormat('d MMMM yyyy').format(selectedDate!)
        : 'Select a date';
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


// TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Cari Produk',
//                   hintText: 'Masukkan nama produk',
//                   labelStyle: Regular.body.withColor(Monochrome.whiteDarkMode),
//                   hintStyle: Regular.body.withColor(Monochrome.grey),
//                   enabledBorder: const UnderlineInputBorder(
//                     borderSide: BorderSide(color: Monochrome.grey),
//                   ),
//                   focusedBorder: const UnderlineInputBorder(
//                     borderSide: BorderSide(color: Main.lightBlue),
//                   ),
//                 ),
//                 style: Regular.body.withColor(
//                     Monochrome.whiteDarkMode), // Ubah warna teks input
//                 onChanged: (value) {
//                   // Implement your search filtering logic here
//                 },
//               ),