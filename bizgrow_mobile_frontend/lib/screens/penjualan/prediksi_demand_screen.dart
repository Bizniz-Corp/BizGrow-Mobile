import 'package:bizgrow_mobile_frontend/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bizgrow_mobile_frontend/themes/theme.dart';
import 'package:bizgrow_mobile_frontend/themes/text_styles.dart';
import 'package:bizgrow_mobile_frontend/widgets/navbar.dart';

class PrediksiDemandScreen extends StatefulWidget{
  const PrediksiDemandScreen({super.key});

  @override
  _PrediksiDemandScreenState createState() => _PrediksiDemandScreenState();
}

class _PrediksiDemandScreenState extends State<PrediksiDemandScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("prediksi"),
      ),
      body: Container(
        margin: EdgeInsets.all(BizGrowTheme.getMargin(context)),
        child: const Text("ini prediksi demand"),
      ),
      bottomNavigationBar: MainNavigator(selectedIndex: 1),
    );
  }
}