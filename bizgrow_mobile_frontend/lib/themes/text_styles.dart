import 'package:flutter/material.dart';

// Extension untuk TextStyle
extension TextStyleExtension on TextStyle {
  TextStyle withColor(Color color) {
    return copyWith(color: color);
  }
}

// contoh penggunaan
// Text(
//   'ini tulisan',
//   style: Regular.h1.withColor(MainColors.blue),
// );

class Regular{
  static const TextStyle h1 = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 36,
    fontWeight: FontWeight.normal
  );
  static const TextStyle h2 = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 28,
    fontWeight: FontWeight.normal
  );
  static const TextStyle h3 = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 22,
    fontWeight: FontWeight.normal
  );
  static const TextStyle large = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 18,
    fontWeight: FontWeight.normal
  );
  static const TextStyle body = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 14,
    fontWeight: FontWeight.normal
  );
  static const TextStyle small = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 12,
    fontWeight: FontWeight.normal
  );
}

class SemiBold{
  static const TextStyle h1 = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 36,
    fontWeight: FontWeight.w600
  );
  static const TextStyle h2 = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 28,
    fontWeight: FontWeight.w600
  );
  static const TextStyle h3 = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 22,
    fontWeight: FontWeight.w600
  );
  static const TextStyle large = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 18,
    fontWeight: FontWeight.w600
  );
  static const TextStyle body = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 14,
    fontWeight: FontWeight.w600
  );
  static const TextStyle small = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 12,
    fontWeight: FontWeight.w600
  );
}

class Bold{
  static const TextStyle h1 = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 36,
    fontWeight: FontWeight.w700
  );
  static const TextStyle h2 = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 28,
    fontWeight: FontWeight.w700
  );
  static const TextStyle h3 = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 22,
    fontWeight: FontWeight.w700
  );
  static const TextStyle large = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 18,
    fontWeight: FontWeight.w700
  );
  static const TextStyle body = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 14,
    fontWeight: FontWeight.w700
  );
  static const TextStyle small = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 12,
    fontWeight: FontWeight.w700
  );
}

class Black{
  static const TextStyle h1 = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 36,
    fontWeight: FontWeight.w900
  );
  static const TextStyle h2 = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 28,
    fontWeight: FontWeight.w900
  );
  static const TextStyle h3 = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 22,
    fontWeight: FontWeight.w900
  );
  static const TextStyle large = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 18,
    fontWeight: FontWeight.w900
  );
  static const TextStyle body = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 14,
    fontWeight: FontWeight.w900
  );
  static const TextStyle small = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 12,
    fontWeight: FontWeight.w900
  );
}