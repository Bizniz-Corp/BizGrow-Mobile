import 'package:flutter/material.dart';
import 'package:bizgrow_mobile_frontend/themes/colors.dart';
import 'package:bizgrow_mobile_frontend/themes/text_styles.dart';

// CONTOH PENGGUNAAN

// CustomButton(
//   text: 'Submit',
//   size: 'large',
//   onPressed: () {
//     Navigator.pushReplacement(
//         context,
//         MaterialPageRoute((context) => PrediksiDemandScreen()),
//     );
//   },
// )

// CustomButton(
//   text: 'Add',
//   size: 'medium',
//   iconPath: 'assets/icons/add_icon.png', // Path ikon
//   iconPosition: 'leftIcon',
//   onPressed: () {
//     print('Button with left icon clicked');
//   },
// )

// CustomButton(
//   text: '', // Kosong karena hanya ikon
//   size: 'medium',
//   iconPath: 'assets/icons/settings_icon.png',
//   iconPosition: 'icon only',
//   onPressed: () {
//     print('Icon-only button clicked');
//   },
// )

// CustomButton(
//   text: 'Submit',
//   size: 'large',
//   width: 300, // Lebar kustom
//   onPressed: () {
//     print('Large button with custom width clicked');
//   },
// )

class CustomButton extends StatelessWidget {
  final String text;
  final String size;
  final double? width; // BISA NULL
  final String? iconPath; // BISA NULL
  final String? buttonType; // Posisi icon: right, left, atau BISA NULL
  final VoidCallback? onPressed; // Fungsi yang dipanggil ketika button ditekan
  final Color? color; // BISA NULL
  final double? radius; // BISA NULL
  final double? iconSize;

  CustomButton(
      {required this.text,
      required this.size,
      this.width,
      this.iconPath,
      this.buttonType = 'noIcon',
      required this.onPressed,
      this.color = Main.blueSecondary,
      this.radius,
      this.iconSize});

  @override
  Widget build(BuildContext context) {
    double buttonHeight;
    double horizontalPadding;
    TextStyle textStyle;
    double radius;

    switch (size) {
      case 'large':
        buttonHeight = 48;
        horizontalPadding = 24;
        textStyle = SemiBold.large.withColor(Monochrome.whiteDarkMode);
        radius = 12;
        break;
      case 'medium':
        buttonHeight = 40;
        horizontalPadding = 16;
        radius = 8;
        textStyle = SemiBold.large.withColor(Monochrome.whiteDarkMode);
        break;
      case 'small':
        buttonHeight = 36;
        horizontalPadding = 12;
        radius = 6;
        textStyle = SemiBold.large.withColor(Monochrome.whiteDarkMode);
        break;
      default:
        buttonHeight = 40;
        horizontalPadding = 16;
        radius = 8;
        textStyle = SemiBold.large.withColor(Monochrome.whiteDarkMode);
    }

    double widthDefault =
        (textStyle.fontSize! * text.length) + (horizontalPadding * 2);

    return SizedBox(
      width: width ?? widthDefault,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon di sebelah kiri jika `left icon`

            if (iconPath != null && buttonType == 'leftIcon')
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child:
                    Image.asset(iconPath!, height: iconSize, width: iconSize),
              ),

            // text Text
            if (buttonType != 'iconOnly')
              Text(
                text,
                style: textStyle.copyWith(color: Colors.white),
              ),

            // Icon di sebelah kanan jika `right icon`
            if (iconPath != null && buttonType == 'rightIcon')
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child:
                    Image.asset(iconPath!, height: iconSize, width: iconSize),
              ),

            // Jika tipe `icon only`
            if (buttonType == 'iconOnly' && iconPath != null)
              Image.asset(iconPath!, height: iconSize, width: iconSize),
          ],
        ),
      ),
    );
  }
}
