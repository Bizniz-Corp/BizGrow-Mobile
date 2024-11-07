import 'package:bizgrow_mobile_frontend/themes/colors.dart';
import 'package:bizgrow_mobile_frontend/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:bizgrow_mobile_frontend/widgets/navbar.dart';
import 'package:bizgrow_mobile_frontend/widgets/line_chart.dart';
import 'package:bizgrow_mobile_frontend/themes/theme.dart';
import 'package:bizgrow_mobile_frontend/services/data_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:searchfield/searchfield.dart';

class PrediksiDemandScreen extends StatefulWidget {
  @override
  _PrediksiDemandScreenState createState() => _PrediksiDemandScreenState();
}

class _PrediksiDemandScreenState extends State<PrediksiDemandScreen> {
  List<dynamic> _data = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _path =
        'https://raw.githubusercontent.com/Bizniz-Corp/BizGrow-Mobile/refs/heads/1302223041-Syahreza/bizgrow_mobile_frontend/lib/assets/data/data_dummy1.json';

    return Scaffold(
      appBar: AppBar(
        title: Text("Prediksi Demand"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(BizGrowTheme.getMargin(context)),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 175,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'Pilih Produk',
                        style: Regular.large.withColor(Monochrome.whiteDarkMode),),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 10,
                            offset: Offset(0, 10)
                          )
                        ]
                      ),
                      child: SearchField(
                        hint: 'Cari Produk',
                        searchInputDecoration: SearchInputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Monochrome.whiteDarkMode,
                              width: 1
                            ),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Main.lightBlue,
                              width: 2
                            ),
                            borderRadius: BorderRadius.circular(10)
                          )
                        ),
                        itemHeight: 50,
                        maxSuggestionsInViewPort: 5,
                        suggestionsDecoration: SuggestionDecoration(
                          color: Main.lightBlue,
                          borderRadius: BorderRadius.circular(10),
                          selectionColor: Monochrome.whiteDarkMode
                        ),
                        suggestions: [
                          SearchFieldListItem('Ayam Bakar Nashviled'),
                          SearchFieldListItem('Ayam Goreng Nashviled'),
                          SearchFieldListItem('Ayam Rebus Nashviled'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 200,
                child: CustomLineChart(jsonPath: _path),
              ),
            ],
          ),
        ),

      ),
      bottomNavigationBar: MainNavigator(selectedIndex: 1),
    );
  }
}
