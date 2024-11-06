import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:fl_chart/fl_chart.dart';
import 'package:bizgrow_mobile_frontend/themes/colors.dart';
import 'package:bizgrow_mobile_frontend/themes/text_styles.dart';
import 'package:bizgrow_mobile_frontend/services/data_service.dart';

Future<List<List<dynamic>>> getChartData(String filePath) async {
  List<dynamic> jsonData = await readJsonFile(filePath);

  if (jsonData != null) {
    print('${jsonData[0]['value']}');
  } else {
    print('No');
  }

  List<FlSpot> dataReal = [];
  List<FlSpot> dataForecast = [];
  List<String> dateForXBar = [];

  for (int i = 0; i < jsonData.length; i++) {
    if (jsonData[i]['state'] == 0) {
      dataReal.add(FlSpot(i.toDouble(), jsonData[i]['value'].toDouble()));
    } else if (jsonData[i]['state'] == 1) {
      dataForecast.add(FlSpot(i.toDouble(), jsonData[i]['value'].toDouble()));
    }
    dateForXBar.add(jsonData[i]['date']);
  }

  return [dataReal, dataForecast, dateForXBar];
}

class CustomLineChart extends StatefulWidget {
  final String jsonPath;

  CustomLineChart({required this.jsonPath});

  @override
  _CustomLineChartState createState() => _CustomLineChartState();
}

class _CustomLineChartState extends State<CustomLineChart> {
  Future<List<List<dynamic>>>? chartDataFuture;

  @override
  Future<void> initState() async {
    super.initState();
    chartDataFuture = (await getChartData(widget.jsonPath)) as Future<List<List<dynamic>>>?;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<List<dynamic>>>(
        future: chartDataFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<FlSpot> dataReal = snapshot.data![0] as List<FlSpot>;
            List<FlSpot> dataForecast = snapshot.data![1] as List<FlSpot>;
            List<String> dateForXBar = snapshot.data![2] as List<String>;

            print(dataReal);
            print(dataForecast);
            print(dateForXBar);
          } else {
            print('tidak ada data');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}',
                style: Bold.h3.withColor(Monochrome.whiteDarkMode));
          } else {
            List<FlSpot> dataReal = snapshot.data![0] as List<FlSpot>;
            List<FlSpot> dataForecast = snapshot.data![1] as List<FlSpot>;
            List<String> dateForXBar = snapshot.data![2] as List<String>;

            return LineChart(
              LineChartData(
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(getTitlesWidget: (value, _) {
                        int index = value.toInt();
                        if (index >= 0 && index < dateForXBar.length) {
                          return Text(dateForXBar[index]);
                        } else {
                          return Text('');
                        }
                      }),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                        spots: dataReal,
                        color: Monochrome.whiteDarkMode,
                        barWidth: 3),
                    LineChartBarData(
                        spots: dataForecast,
                        color: additionalColor.green,
                        barWidth: 3)
                  ]),
            );
          }
        });
  }
}
