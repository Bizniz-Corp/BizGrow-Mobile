import 'dart:convert';
import 'dart:io';
import 'package:fl_chart/fl_chart.dart';


Future<List<dynamic>> readJsonFile(String filePath) async {
  var input = await File(filePath).readAsString();

  return jsonDecode(input) as List<dynamic>;
}

Future<List<List<dynamic>>> getChartData(String filePath) async {
  List<dynamic> jsonData = await readJsonFile(filePath);
  
  List<FlSpot> dataReal = [];
  List<FlSpot> dataForecast = [];
  List<String> dateForXBar = [];

  for (int i = 0; i < jsonData.length; i++){
    if (jsonData[i]['state'] == 0){
      dataReal.add(FlSpot(i.toDouble(), jsonData[i]['value'].toDouble()));
    }else if (jsonData[i].State == 1){
      dataForecast.add(FlSpot(i.toDouble(), jsonData[i]['value'].toDouble()));
    }
    dateForXBar.add(jsonData[i]['date']);
  }

  return [dataReal, dataForecast, dateForXBar];
}