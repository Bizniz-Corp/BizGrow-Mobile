import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:bizgrow_mobile_frontend/themes/colors.dart';
import 'package:bizgrow_mobile_frontend/themes/text_styles.dart';
import 'package:bizgrow_mobile_frontend/services/data_service.dart';

class CustomLineChart extends StatefulWidget {
  final String jsonPath;

  CustomLineChart({required this.jsonPath});

  @override
  _CustomLineChartState createState() => _CustomLineChartState();
}

class _CustomLineChartState extends State<CustomLineChart> {
  List<List<dynamic>> _chartData = [];
  List<dynamic> _data = [];
  late LineTitles lineTitles;
  late double _minX, _minY, _maxX, _maxY;


  // Function to convert data from json format to chart data

  List<List<dynamic>> getChartData(var data) {
    List<FlSpot> dataReal = [];
    List<FlSpot> dataForecast = [];
    List<String> dateForXBar = [];

    if (data.isNotEmpty) {
      for (int i = 0; i < data.length; i++) {
        if (data[i]['state'] == 0) {
          dataReal.add(FlSpot(i.toDouble(), data[i]['value'].toDouble()));
        } else if (data[i]['state'] == 1) {
          dataForecast.add(FlSpot(i.toDouble(), data[i]['value'].toDouble()));
        }
        dateForXBar.add(data[i]['date']);
      }
    }

    return [dataReal, dataForecast, dateForXBar];
  }

  @override
  void initState() {
    fetchNotes(widget.jsonPath).then((value) {
      setState(() {
        _data.addAll(value);
      });
    });
    _chartData = getChartData(_data);
    lineTitles = LineTitles(xLabels: ['1', 'ada']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<FlSpot> dataReal = _chartData[0] as List<FlSpot>;
    List<FlSpot> dataForecast = _chartData[1] as List<FlSpot>;
    List<String> dateForXBar = _chartData[2] as List<String>;

    return LineChart(LineChartData(
        minX: 0,
        maxX: 11,
        minY: 0,
        maxY: 6,
        titlesData: lineTitles.getTitleData(),
        gridData: FlGridData(
            show: true,
            getDrawingHorizontalLine: (value) {
              return FlLine(color: Monochrome.whiteDarkMode, strokeWidth: 0.5);
            },
            getDrawingVerticalLine: (value) {
              return FlLine(strokeWidth: 0);
            }),
        borderData: FlBorderData(
            show: true,
            border: Border.symmetric(
                horizontal:
                    BorderSide(width: 0.5, color: Monochrome.whiteDarkMode))),
        lineBarsData: [
          LineChartBarData(
              spots: [FlSpot(0, 3), FlSpot(2, 1), FlSpot(8, 2)],
              isCurved: true,
              color: Monochrome.whiteDarkMode,
              dotData: FlDotData(show: false)),
          LineChartBarData(
              spots: [FlSpot(2, 5), FlSpot(4, 6), FlSpot(5, 1)],
              isCurved: true,
              color: Main.lightBlue,
              dotData: FlDotData(show: false))
        ]));

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
                spots: dataReal, color: Monochrome.whiteDarkMode, barWidth: 3),
            LineChartBarData(
                spots: dataForecast, color: additionalColor.green, barWidth: 3)
          ]),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return FutureBuilder<List<List<dynamic>>>(
  //       future: _chartData,
  //       builder: (context, snapshot) {
  //         if (snapshot.hasData) {
  //           List<FlSpot> dataReal = snapshot.data![0] as List<FlSpot>;
  //           List<FlSpot> dataForecast = snapshot.data![1] as List<FlSpot>;
  //           List<String> dateForXBar = snapshot.data![2] as List<String>;

  //           print(dataReal);
  //           print(dataForecast);
  //           print(dateForXBar);
  //         } else {
  //           print('tidak ada data');
  //         }
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return CircularProgressIndicator();
  //         } else if (snapshot.hasError) {
  //           return Text('Error: ${snapshot.error}',
  //               style: Bold.h3.withColor(Monochrome.whiteDarkMode));
  //         } else {
  //           List<FlSpot> dataReal = snapshot.data![0] as List<FlSpot>;
  //           List<FlSpot> dataForecast = snapshot.data![1] as List<FlSpot>;
  //           List<String> dateForXBar = snapshot.data![2] as List<String>;

  //           return LineChart(
  //             LineChartData(
  //                 titlesData: FlTitlesData(
  //                   bottomTitles: AxisTitles(
  //                     sideTitles: SideTitles(getTitlesWidget: (value, _) {
  //                       int index = value.toInt();
  //                       if (index >= 0 && index < dateForXBar.length) {
  //                         return Text(dateForXBar[index]);
  //                       } else {
  //                         return Text('');
  //                       }
  //                     }),
  //                   ),
  //                 ),
  //                 lineBarsData: [
  //                   LineChartBarData(
  //                       spots: dataReal,
  //                       color: Monochrome.whiteDarkMode,
  //                       barWidth: 3),
  //                   LineChartBarData(
  //                       spots: dataForecast,
  //                       color: additionalColor.green,
  //                       barWidth: 3)
  //                 ]),
  //           );
  //         }
  //       });
  // }
}

class LineTitles {
  final List<String> xLabels;

  LineTitles({required this.xLabels});

  FlTitlesData getTitleData() {
    return FlTitlesData(
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            final index = value.toInt();
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                index >= 0 && index < xLabels.length ? xLabels[index] : '',
                style: TextStyle(
                  color: const Color(0xff68737d),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            );
          },
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: true),
      ),
    );
  }
}

