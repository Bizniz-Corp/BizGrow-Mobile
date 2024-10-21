import 'package:flutter/material.dart';
import 'colors.dart';
import 'text_styles.dart';

class BizGrowTheme{
  static ThemeData darkMode = ThemeData(
    scaffoldBackgroundColor: Main.background,
    appBarTheme: AppBarTheme(
      backgroundColor: Main.darkBlue,
      titleTextStyle: Bold.h3.withColor(Monochrome.whiteDarkMode),
      elevation: 48,
      titleSpacing: 32
    ),
  );

  static double getMargin(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return screenSize.width * 0.05;
  }
}