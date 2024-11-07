import 'package:bizgrow_mobile_frontend/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bizgrow_mobile_frontend/themes/theme.dart';
import 'package:bizgrow_mobile_frontend/themes/text_styles.dart';
import 'package:bizgrow_mobile_frontend/widgets/navbar.dart';

class PenjualanInputExcelScreen extends StatefulWidget {
  const PenjualanInputExcelScreen({super.key});

  @override
  _PenjualanInputExcelScreenState createState() =>
      _PenjualanInputExcelScreenState();
}

class _PenjualanInputExcelScreenState extends State<PenjualanInputExcelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Input Data Penjualan"),
      ),
      body: Container(
        margin: EdgeInsets.all(BizGrowTheme.getMargin(context)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Column(
              children: [
                Text("Masukkan data penjualan dalam bentuk file ",
                    style: Regular.body.withColor(Monochrome.whiteDarkMode)),
                Text(".csv .xlsx",
                    style: SemiBold.body.withColor(Monochrome.whiteDarkMode))
              ],
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Main.lightBlue),
                  onPressed: () {
                    // action browse file
                  },
                  child: Text("Pilih File",
                      style: Regular.body.withColor(Monochrome.whiteDarkMode))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("File belum dipilih",
                  style: Regular.small.withColor(Monochrome.whiteDarkMode)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Main.blueSecondary),
                  onPressed: () {
                    // action send data
                  },
                  child: Text("Kirim Data",
                      style: Regular.body.withColor(Monochrome.whiteDarkMode))),
            )
          ],
        ),
      ),
      bottomNavigationBar: MainNavigator(selectedIndex: 1),
    );
  }
}
