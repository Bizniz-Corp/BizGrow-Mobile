import 'package:flutter/material.dart';
import 'colors.dart';
import 'text_styles.dart';

class BizGrowTheme{
  static ThemeData darkMode = ThemeData(
    scaffoldBackgroundColor: Main.background,
    appBarTheme: AppBarTheme(
      backgroundColor: Main.darkBlue,
      titleTextStyle: Bold.large.withColor(Monochrome.whiteDarkMode)
    ),
  );
}