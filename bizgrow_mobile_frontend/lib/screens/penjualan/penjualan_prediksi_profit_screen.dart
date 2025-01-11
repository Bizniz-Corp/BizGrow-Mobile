import 'package:bizgrow_mobile_frontend/themes/colors.dart';
import 'package:bizgrow_mobile_frontend/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:bizgrow_mobile_frontend/widgets/navbar.dart';
import 'package:bizgrow_mobile_frontend/widgets/line_chart.dart';
import 'package:bizgrow_mobile_frontend/widgets/line_chart_prediction.dart';
import 'package:bizgrow_mobile_frontend/themes/theme.dart';
import 'package:bizgrow_mobile_frontend/services/api_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PrediksiProfitScreen extends StatefulWidget {
  @override
  _PrediksiProfitScreenState createState() => _PrediksiProfitScreenState();
}

class _PrediksiProfitScreenState extends State<PrediksiProfitScreen> {
  List<Map<String, dynamic>> _chartData = [];
  List<Map<String, dynamic>> _predictionData = [];
  final apiService = ApiService();
  bool _isLoading = true;
  bool _isLoadingPrediction = true;
  final TextEditingController _bulanController = TextEditingController();
  bool _predictionPressed = false;
  String _endMonthYear = '';

  Future<void> _fetchInitialData() async {
    const url =
        "http://localhost:3000/api/sales-transactions/aggregate-by-month-year/5";
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List<dynamic>;
        setState(() {
          _chartData = data
              .map((item) => {
                    "date": item['date'],
                    "total": item['total'],
                  })
              .toList();
          _isLoading = false;
        });
      } else {
        throw Exception(
            "Gagal memuat data. Status code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error: $error");
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Terjadi kesalahan saat memuat data awal.")),
      );
    }
  }

  Future<void> _fetchPredictionData() async {
    final bulanInt = int.parse(_bulanController.text) * 30;
    final numDays = _bulanController.text;

    String url =
        "http://localhost:3000/api/forecast/aggregate-by-month-year?umkmId=5&numDays=$bulanInt";
    String urlEndDate = "http://localhost:3000/api/getEndMonthYear/5";

    if (numDays.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Masukkan jumlah bulan untuk prediksi!")),
      );
      return;
    }

    setState(() {
      _predictionPressed = true;
    });

    try {
      final response = await http.get(Uri.parse(url));
      final responseEndDate = await http.get(Uri.parse(urlEndDate));

      print("aaaa");
      print(responseEndDate.body);
      if (response.statusCode == 200 && responseEndDate.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final predictionData = json.decode(response.body) as List<dynamic>;

        final responseEndDateBody = json.decode(responseEndDate.body);
        String endMonthYear = "";

        if (responseEndDateBody is Map) {
          endMonthYear = responseEndDateBody['endMonthYear'];
        } else {
          print('Response tidak dalam format Map');
        }
        setState(() {
          _predictionData = predictionData
              .map((item) => {
                    "date": item['date'],
                    "total": item['total'],
                  })
              .toList();

          _endMonthYear = endMonthYear.isNotEmpty ? endMonthYear : '';
          _isLoadingPrediction = false;
        });
      } else {
        throw Exception(
            "Gagal mengambil data prediksi. Status code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Terjadi kesalahan saat mengambil data prediksi.")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchInitialData();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Prediksi Profit"),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(BizGrowTheme.getMargin(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Masukkan jumlah bulan yang ingin diprediksi",
                  style: Regular.large.withColor(Monochrome.whiteDarkMode),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _bulanController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Contoh: 3",
                    hintStyle: TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.grey[800],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      _fetchPredictionData();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      "Prediksi",
                      style: TextStyle(
                        color: Colors.blue[900],
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                !_predictionPressed
                    ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          width: 1000,
                          height: 300,
                          child: CustomLineChart(data: _chartData),
                        ),
                      )
                    : _isLoadingPrediction
                        ? const Center(child: CircularProgressIndicator())
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              width: 2000,
                              height: 300,
                              child: CustomLineChartPrediction(
                                data: _predictionData,
                                endMonthYear: _endMonthYear,
                              ),
                            ),
                          ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: MainNavigator(selectedIndex: 1),
      );
    }
  }
}
