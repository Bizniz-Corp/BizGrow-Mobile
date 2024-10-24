import 'package:flutter/material.dart';
import 'package:bizgrow_mobile_frontend/themes/colors.dart';
import 'package:bizgrow_mobile_frontend/themes/text_styles.dart';

class CustomButton extends StatelessWidget {
  final String text; 
  final String size; 
  final double? width; 
  final String? iconPath; 
  final String? buttonType; // Posisi icon: right, left, atau null
  final VoidCallback onPressed; // Fungsi yang dipanggil ketika button ditekan
  final Color? color; 
  final double? radius;

  CustomButton({
    required this.text,
    required this.size,
    this.width,
    this.iconPath,
    this.buttonType = 'no icon',
    required this.onPressed,
    this.color = Main.blueSecondary,
    this.radius,
  });

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

    double widthDefault = (textStyle.fontSize! * text.length) + (horizontalPadding * 2);

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
                child: Image.asset(iconPath!, height: 24, width: 24),
              ),

            // text Text
            if (buttonType != 'icon only') 
              Text(
                text,
                style: textStyle.copyWith(color: Colors.white),
              ),

            // Icon di sebelah kanan jika `right icon`
            if (iconPath != null && buttonType == 'rightIcon') 
              Padding(
                padding: const EdgeInsets.only(left: 8.0), 
                child: Image.asset(iconPath!, height: 24, width: 24),
              ),
            
            // Jika tipe `icon only`
            if (buttonType == 'icon only' && iconPath != null)
              Image.asset(iconPath!, height: 24, width: 24),
          ],
        ),
      ),
    );
  }
}
