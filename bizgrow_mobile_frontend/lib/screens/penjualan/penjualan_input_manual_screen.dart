import 'package:bizgrow_mobile_frontend/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bizgrow_mobile_frontend/themes/theme.dart';
import 'package:bizgrow_mobile_frontend/themes/text_styles.dart';
import 'package:bizgrow_mobile_frontend/widgets/navbar.dart';

class PenjualanInputManualScreen extends StatefulWidget{
  @override
  _PenjualanInputManualScreenState createState() => _PenjualanInputManualScreenState();
}

class _PenjualanInputManualScreenState extends State<PenjualanInputManualScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Input Data Penjualan"),
      ),
      body: Container(
        // margin: EdgeInsets.all(BizGrowTheme.getMargin(context)),
        child: Column(
          children: [
            Text("Input Data Manual", style: Regular.h3.withColor(Monochrome.whiteDarkMode)),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Tanggal", style: TextStyle(color: Monochrome.whiteDarkMode))),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'DD/MM/YYYY',
                    ),
                  ),
                ),

                // !! 
                // ADD DATE PICKER 
                // combine with text field above and refactor into a row
                // AAA !!

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Nama Produk", style: TextStyle(color: Monochrome.whiteDarkMode))),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Nama Produk',
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Harga", style: TextStyle(color: Monochrome.whiteDarkMode))
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Harga',
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Kuantitas", style: TextStyle(color: Monochrome.whiteDarkMode))
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Kuantitas',
                    ),
                  ),
                ),

                ]
              ),
              ],
            )
        ),
      bottomNavigationBar: MainNavigator(selectedIndex: 1)
      );
    
  }
}