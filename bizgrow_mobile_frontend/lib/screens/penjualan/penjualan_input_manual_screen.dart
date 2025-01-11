import 'package:bizgrow_mobile_frontend/models/product.dart';
import 'package:bizgrow_mobile_frontend/services/api_service.dart';
import 'package:bizgrow_mobile_frontend/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:bizgrow_mobile_frontend/themes/theme.dart';
import 'package:bizgrow_mobile_frontend/themes/text_styles.dart';
import 'package:bizgrow_mobile_frontend/widgets/navbar.dart';
import 'package:intl/intl.dart';

import 'input_data_penjualan.dart';

class PenjualanInputManualScreen extends StatefulWidget {
  const PenjualanInputManualScreen({super.key});

  @override
  _PenjualanInputManualScreenState createState() =>
      _PenjualanInputManualScreenState();
}

class _PenjualanInputManualScreenState
    extends State<PenjualanInputManualScreen> {
  DateTime selectedDate = DateTime.now();

  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  Product? selectedProduct;
  List<Product> products = [];
  final String token =
      "1|0Qv5q5hDpjU1no6CpwvTpzaT9D9N2PihAmc8ibSw410e7fc4"; // Token untuk autentikasi API

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Input Data Penjualan"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Monochrome.whiteDarkMode),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      InputDataPenjualanScreen(), // Navigasi ke halaman PenjualanHistory
                ),
              ); // Ini untuk kembali ke halaman sebelumnya
            },
          ),
        ),
        body: Container(
            margin: EdgeInsets.all(BizGrowTheme.getMargin(context)),
            child: Column(
              children: [
                Text("Input Data Manual",
                    style: Regular.h3.withColor(Monochrome.whiteDarkMode)),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FilterDateOption(
                      title: 'Tanggal',
                      selectedDate: selectedDate,
                      onSelectDate: () => _selectDate(context, true),
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Nama Produk",
                          style: TextStyle(color: Monochrome.whiteDarkMode))),
                  DropdownButtonFormField<Product>(
                    value: selectedProduct,
                    onChanged: (Product? newValue) {
                      setState(() {
                        selectedProduct = newValue!;
                      });
                    },
                    items: products.map((Product product) {
                      return DropdownMenuItem<Product>(
                        value: product,
                        child: Text(product.productName),
                      );
                    }).toList(),
                    decoration: InputDecoration(labelText: 'Nama Produk'),
                  ),
                  // const Padding(
                  //   padding: EdgeInsets.all(8.0),
                  //   child: TextField(
                  //     decoration: InputDecoration(
                  //       border: OutlineInputBorder(),
                  //       hintText: 'Nama Produk',
                  //     ),
                  //   ),
                  // ),
                  const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Harga",
                          style: TextStyle(color: Monochrome.whiteDarkMode))),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _priceController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Harga',
                      ),
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Kuantitas",
                          style: TextStyle(color: Monochrome.whiteDarkMode))),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _quantityController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Kuantitas',
                      ),
                    ),
                  ),
                  // submit button
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Main.lightBlue),
                          onPressed: () {
                            //  save data
                          },
                          child: Text("Kirim Data",
                              style: Regular.body
                                  .withColor(Monochrome.whiteDarkMode))),
                    ),
                  )
                ]),
              ],
            )),
        bottomNavigationBar: MainNavigator(selectedIndex: 1));
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
          selectedDate = pickedDate;
        }
      });
    }
  }

  Future<void> _submitData() async {
    String price = _priceController.text;
    String quantity = _quantityController.text;

    if (selectedProduct == null || price.isEmpty || quantity.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please fill all the fields"),
        backgroundColor: Colors.red,
      ));
      return;
    }

    int total = int.parse(price) * int.parse(quantity);

    try {
      final response = await ApiService().insertSalesTransaction(
        token: token,
        productId: selectedProduct!.productId,
        salesDate: DateFormat("yyyy-MM-dd").format(selectedDate),
        salesQuantity: quantity,
        pricePerItem: price,
        total: total,
      );

      if (response['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(response['message']),
          backgroundColor: Colors.green,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(response['message']),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to submit data: $e"),
        backgroundColor: Colors.red,
      ));
    }
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
          Padding(
            padding: const EdgeInsets.only(bottom: 8, top: 8),
            child:
                Text(title, style: SemiBold.body.withColor(Monochrome.white)),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: Center(
              child: Text(formattedDate,
                  style: Regular.body.withColor(Monochrome.white)),
            ),
          ),
        ],
      ),
    );
  }
}
