import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:bizgrow_mobile_frontend/themes/colors.dart';

class CustomLineChartPrediction extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final String endMonthYear;

  CustomLineChartPrediction({required this.data, required this.endMonthYear});

  @override
  _CustomLineChartPredictionState createState() =>
      _CustomLineChartPredictionState();
}

class _CustomLineChartPredictionState extends State<CustomLineChartPrediction> {
  List<FlSpot> _chartDataBefore = [];
  List<FlSpot> _chartDataAfter = [];
  List<String> _xLabelsBefore = [];
  List<String> _xLabelsAfter = [];

  @override
  void initState() {
    super.initState();
    _parseData(widget.data);
  }

  void _parseData(List<Map<String, dynamic>> data) {
    DateTime endDate = DateTime.parse("${widget.endMonthYear}-01");

    List<FlSpot> spotsBefore = [];
    List<FlSpot> spotsAfter = [];
    List<String> xLabelsBefore = [];
    List<String> xLabelsAfter = [];

    for (int i = 0; i < data.length; i++) {
      final entry = data[i];
      final date = entry['date'] as String;
      final total = (entry['total'] as num).toDouble();
      DateTime currentDate = DateTime.parse("$date-01");

      if (currentDate.isBefore(endDate) ||
          currentDate.isAtSameMomentAs(endDate)) {
        spotsBefore.add(FlSpot(i.toDouble(), total));
        xLabelsBefore.add(date);
      } else {
        spotsAfter.add(FlSpot(i.toDouble(), total));
        xLabelsAfter.add(date);
      }
    }

    setState(() {
      _chartDataBefore = spotsBefore;
      _chartDataAfter = spotsAfter;
      _xLabelsBefore = xLabelsBefore;
      _xLabelsAfter = xLabelsAfter;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_chartDataBefore.isEmpty && _chartDataAfter.isEmpty) {
      return Center(child: Text("No data available"));
    }

    return LineChart(
      LineChartData(
        minX: 0,
        maxX: (_chartDataBefore.length + _chartDataAfter.length - 1).toDouble(),
        minY: _chartDataBefore
                .map((spot) => spot.y)
                .reduce((a, b) => a < b ? a : b)
                .isNaN
            ? 0
            : _chartDataBefore
                .map((spot) => spot.y)
                .reduce((a, b) => a < b ? a : b),
        maxY: _chartDataBefore
                .map((spot) => spot.y)
                .reduce((a, b) => a > b ? a : b)
                .isNaN
            ? 0
            : _chartDataBefore
                .map((spot) => spot.y)
                .reduce((a, b) => a > b ? a : b),
        titlesData: _getTitlesData(),
        gridData: _getGridData(),
        borderData: FlBorderData(
          show: true,
          border: Border.symmetric(
            horizontal: BorderSide(width: 0.5, color: Monochrome.whiteDarkMode),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: _chartDataBefore,
            isCurved: true,
            color: Colors.blue,
            dotData: FlDotData(show: false),
          ),
          LineChartBarData(
            spots: _chartDataAfter,
            isCurved: true,
            color: Colors.red,
            dotData: FlDotData(show: false),
          ),
        ],
      ),
    );
  }

  FlGridData _getGridData() {
    return FlGridData(
      show: true,
      drawHorizontalLine: true,
      drawVerticalLine: true,
      getDrawingVerticalLine: (value) {
        final index = value.toInt();
        if (index >= 0 &&
            index < _chartDataBefore.length + _chartDataAfter.length) {
          return FlLine(
            color: Monochrome.whiteDarkMode,
            strokeWidth: 0.5,
          );
        }
        return FlLine(color: Colors.transparent);
      },
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: Monochrome.whiteDarkMode,
          strokeWidth: 0.5,
        );
      },
    );
  }

  FlTitlesData _getTitlesData() {
    return FlTitlesData(
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            final index = value.toInt();
            String label = '';
            if (index < _xLabelsBefore.length) {
              label = _xLabelsBefore[index];
            } else if (index - _xLabelsBefore.length < _xLabelsAfter.length) {
              label = _xLabelsAfter[index - _xLabelsBefore.length];
            }
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                label,
                style: TextStyle(
                  color: const Color(0xff68737d),
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
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
