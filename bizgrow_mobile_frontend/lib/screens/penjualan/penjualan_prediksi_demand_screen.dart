import 'package:bizgrow_mobile_frontend/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bizgrow_mobile_frontend/themes/theme.dart';
import 'package:bizgrow_mobile_frontend/themes/text_styles.dart';
import 'package:bizgrow_mobile_frontend/widgets/navbar.dart';
import 'package:bizgrow_mobile_frontend/widgets/line_chart.dart';
import 'package:bizgrow_mobile_frontend/services/data_service.dart';

class PrediksiDemandScreen extends StatefulWidget {
  @override
  _PrediksiDemandScreenState createState() => _PrediksiDemandScreenState();
}

class _PrediksiDemandScreenState extends State<PrediksiDemandScreen> {
  List<dynamic> data = [];

  Future fetchNotes() async{
    
  }

  @override
  void initState() {
    super.initState();
    loadData(); // Memanggil fungsi untuk membaca data JSON
  }

  Future<void> loadData() async {
    List<dynamic> jsonData = await readJsonFile(
        '../../assets/data/data_dummy.json');
    setState(() {
      data = jsonData; // Memperbarui data setelah JSON terbaca
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prediksi Demand"),
      ),
      body: data.isEmpty
          ? Center(child: CircularProgressIndicator()) // Menampilkan loader saat data belum ada
          : Container(
              child: Text("Data berhasil dimuat"),
              // Kamu bisa lanjutkan dengan menampilkan data dalam chart atau widget lain
            ),
      // body: Container(
      //   margin: EdgeInsets.all(BizGrowTheme.getMargin(context)),
      //   child: Text('${data[0]['value']}'),
      //   // child: CustomLineChart(
      //   //     jsonPath:
      //   //         'bizgrow_mobile_frontend/lib/assets/data/data_dummy.json'),
      // ),
      bottomNavigationBar: MainNavigator(selectedIndex: 1),
    );
  }
}
