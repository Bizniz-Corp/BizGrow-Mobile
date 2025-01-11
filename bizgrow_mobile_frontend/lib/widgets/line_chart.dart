import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:bizgrow_mobile_frontend/themes/colors.dart';

class CustomLineChart extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  CustomLineChart({required this.data});

  @override
  _CustomLineChartState createState() => _CustomLineChartState();
}

class _CustomLineChartState extends State<CustomLineChart> {
  List<FlSpot> _chartData = [];
  List<String> _xLabels = [];
  bool _showXLabels = true;

  @override
  void initState() {
    super.initState();
    _parseData(widget.data);
  }

  void _parseData(List<Map<String, dynamic>> data) {
    List<FlSpot> spots = [];
    List<String> xLabels = [];

    for (int i = 0; i < data.length; i++) {
      final entry = data[i];
      final date = entry['date'] as String; // Format tanggal
      final total = (entry['total'] as num).toDouble(); // Total nilai
      spots.add(FlSpot(i.toDouble(), total));
      xLabels.add(date);
    }

    setState(() {
      _chartData = spots;
      _xLabels = xLabels;
      _showXLabels =
          xLabels.length <= 24; // Menentukan apakah X label ditampilkan
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_chartData.isEmpty) {
      return Center(child: Text("No data available"));
    }

    return LineChart(
      LineChartData(
        minX: 0,
        maxX: _chartData.length - 1,
        minY: _chartData.map((spot) => spot.y).reduce((a, b) => a < b ? a : b),
        maxY: _chartData.map((spot) => spot.y).reduce((a, b) => a > b ? a : b),
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
            spots: _chartData,
            isCurved: true,
            color: Monochrome.whiteDarkMode,
            dotData: FlDotData(show: false),
          ),
        ],
      ),
    );
  }

  FlGridData _getGridData() {
    return FlGridData(
      show: true,
      drawHorizontalLine: true, // Tetap tampilkan garis horizontal
      drawVerticalLine: true, // Aktifkan garis vertikal
      getDrawingVerticalLine: (value) {
        // Garis vertikal hanya di tempat titik data
        final index = value.toInt();
        // print(index);
        // print(_chartData.length);
        if (index >= 0 && index < _chartData.length) {
          return FlLine(
            color: Monochrome.whiteDarkMode,
            strokeWidth: 0.5,
          );
        }
        return FlLine(
            color: Colors.transparent); // Tidak ada garis jika bukan titik data
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
          showTitles: _showXLabels,
          getTitlesWidget: (value, meta) {
            final index = value.toInt();
            final label =
                index >= 0 && index < _xLabels.length ? _xLabels[index] : '';
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

            // final index = value.toInt();

            // // Hanya menampilkan label jika ada titik di data
            // if (index < 0 || index >= _chartData.length)
            //   return SizedBox.shrink();

            // final label = _xLabels[index];
            // return Padding(
            //   padding: const EdgeInsets.only(top: 8.0),
            //   child: Text(
            //     label,
            //     style: TextStyle(
            //       color: const Color(0xff68737d),
            //       fontWeight: FontWeight.bold,
            //       fontSize: 10,
            //     ),
            //   ),
            // );
          },
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: true),
      ),
    );
  }
}
