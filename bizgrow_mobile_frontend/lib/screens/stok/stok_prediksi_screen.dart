import 'package:bizgrow_mobile_frontend/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bizgrow_mobile_frontend/themes/theme.dart';
import 'package:bizgrow_mobile_frontend/themes/text_styles.dart';
import 'package:bizgrow_mobile_frontend/widgets/navbar.dart';

class PrediksiStokScreen extends StatefulWidget {
  const PrediksiStokScreen({super.key});

  @override
  _PrediksiStokScreenState createState() => _PrediksiStokScreenState();
}

class _PrediksiStokScreenState extends State<PrediksiStokScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prediksi Stok"),
      ),
      body: Container(
        margin: EdgeInsets.all(BizGrowTheme.getMargin(context)),
        child: const Text("ini prediksi stok"),
      ),
      bottomNavigationBar: MainNavigator(selectedIndex: 2),
    );
  }
}
