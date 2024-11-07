import 'package:bizgrow_mobile_frontend/themes/colors.dart';
import 'package:bizgrow_mobile_frontend/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:bizgrow_mobile_frontend/widgets/navbar.dart';
import 'package:bizgrow_mobile_frontend/widgets/line_chart.dart';
import 'package:bizgrow_mobile_frontend/themes/theme.dart';
import 'package:bizgrow_mobile_frontend/services/data_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
      body: Container(
        margin: EdgeInsets.all(BizGrowTheme.getMargin(context)),
        child: CustomLineChart(
            jsonPath: _path),
      ),
      bottomNavigationBar: MainNavigator(selectedIndex: 1),
    );
  }
}
