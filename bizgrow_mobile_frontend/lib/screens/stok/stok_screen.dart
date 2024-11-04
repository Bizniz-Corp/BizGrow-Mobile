import 'package:bizgrow_mobile_frontend/screens/stok/stok_history.dart';
import 'package:bizgrow_mobile_frontend/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bizgrow_mobile_frontend/themes/theme.dart';
import 'package:bizgrow_mobile_frontend/themes/text_styles.dart';
import 'package:bizgrow_mobile_frontend/widgets/navbar.dart';

class StokScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stok'),
      ),
      body: Container(
        margin: EdgeInsets.all(BizGrowTheme.getMargin(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Semua berjalan dengan baik',
              style: GoogleFonts.montserrat(
                  fontSize: 28,
                  color: Monochrome.whiteDarkMode,
                  letterSpacing: -0.5),
            ),
            Text(
              'Semua berjalan dengan baik',
              style: GoogleFonts.montserrat(
                  fontSize: 28,
                  color: Monochrome.whiteDarkMode,
                  letterSpacing: -1),
            ),
            Text(
              'Semua berjalan dengan baik',
              style: Regular.large.withColor(Monochrome.whiteDarkMode),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StokHistory(),
                    ),
                  );
                },
                child: Text("ke history test"))
          ],
        ),
      ),
      bottomNavigationBar: MainNavigator(selectedIndex: 2),
    );
  }
}
