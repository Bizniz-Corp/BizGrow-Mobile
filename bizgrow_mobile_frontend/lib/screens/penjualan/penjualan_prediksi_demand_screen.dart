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

  Future<List<dynamic>> fetchNotes() async {
    var url =
        'https://raw.githubusercontent.com/Bizniz-Corp/BizGrow-Mobile/refs/heads/main/bizgrow_mobile_frontend/lib/assets/data/data_dummy.json';
    var response = await http.get(Uri.parse(url));

    List<dynamic> data = [];

    if (response.statusCode == 200) {
      var dataJson = json.decode(response.body);
      for (var dj in dataJson) {
        data.add(dj);
      }
    }

    return data;
  }

  @override
  void initState() {
    fetchNotes().then((value) {
      setState(() {
        _data.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _path =
        'https://raw.githubusercontent.com/Bizniz-Corp/BizGrow-Mobile/refs/heads/main/bizgrow_mobile_frontend/lib/assets/data/data_dummy.json';
    return Scaffold(
      appBar: AppBar(
        title: Text("Prediksi Demand"),
      ),
      body: Container(
        margin: EdgeInsets.all(BizGrowTheme.getMargin(context)),
        // child: Text('${_data[0]}', style: SemiBold.h1.withColor(Monochrome.whiteDarkMode),),
        child: CustomLineChart(
            jsonPath: _path),
      ),
      bottomNavigationBar: MainNavigator(selectedIndex: 1),
    );
  }
}
