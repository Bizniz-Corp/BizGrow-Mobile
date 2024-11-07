import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:bizgrow_mobile_frontend/themes/colors.dart';
import 'package:bizgrow_mobile_frontend/themes/text_styles.dart';
import 'package:bizgrow_mobile_frontend/services/data_service.dart';
import 'dart:math';

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
  late double _maxX, _maxY;

  @override
  void initState() {
    fetchNotes(widget.jsonPath).then((value) {
      setState(() {
        _data.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    _chartData = getChartData(_data);
    if (_chartData.isEmpty || _data.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    List<FlSpot> dataReal = _chartData[0] as List<FlSpot>;
    List<FlSpot> dataForecast = _chartData[1] as List<FlSpot>;
    List<String> dateForXBar = _chartData[2] as List<String>;
    _maxY = getMaxY(_data);
    _maxX = _data.length as double;
    lineTitles = LineTitles(xLabels: ['$_maxY', '$_maxX']);

    return LineChart(LineChartData(
        minX: 0,
        maxX: _maxX,
        minY: 0,
        maxY: _maxY,
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
              spots: dataReal,
              isCurved: true,
              color: Monochrome.whiteDarkMode,
              dotData: FlDotData(show: false)),
          LineChartBarData(
              spots: dataForecast,
              isCurved: true,
              color: Main.lightBlue,
              dotData: FlDotData(show: false))
        ]));
  }
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

double getMaxY(var dataChart) {
  double maxY = 0;

  maxY = dataChart[0]['value'];

  for (var data in dataChart) {
    if (maxY < data['value']) {
      maxY = data['value'];
    }
  }

  maxY = roundUpToNearest(maxY);

  return maxY;
}

double roundUpToNearest(double value) {
  int magnitude = (value / 10).floor().toString().length - 1;
  double scale = pow(10, magnitude).toDouble();
  return (value / scale).ceil() * scale;
}

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

    // Jika dataReal tidak kosong, salin elemen terakhir ke awal dataForecast
    if (dataReal.isNotEmpty) {
      dataForecast.insert(0, dataReal.last);
    }
  }

  return [dataReal, dataForecast, dateForXBar];
}
