import 'package:flutter/material.dart';

class AppColors {

  static const primaryColor = Color(0xffFFFFFF);
  static const secondaryColor = Color(0xff282B42);
  static const black = Color(0xff000000);
  static const lightthemeColor = Color(0xffF1F0F7);
  static const bluecolor = Color(0xff007BFF);
  static const blueLightColor = Color(0xff56A8FF);
  static const gradiantStartColor = Color(0xff007BFF);
  static const gradiantEndColor = Color(0xff56a8ff);
  static const redColors = Color(0xfffc6969);
  static const setColors = Color(0xff424242);
  static const liveColors = Color(0xff17a2b8);
  static const greenColors = Color(0xff00c12b);
  static const otherColors = Color(0xff2790b1);
  static const textBlue = Color(0xff51A7DC);

  static const greenColor = Color(0xff5ECE7B);




  static const greyColor = Color(0xff767676);
  static const greyTextColor = Color(0xff838BA1);
  static const greyHintColor = Color(0xffA7A8AA);
  static const greyBgColor = Color(0xffD3D3D3);
  static const lightgreybgColor = Color(0xffDF9F9F9);
  static const lightGreyTextColor = Color(0xff989898);
  static const greyBtnColor = Color(0xffD9DAD7);


  static const appBarBackgroundColor = Color(0xfff0f0f0);
  static const lightGreyColor = Color(0xFFF4F4F4);
  static const yellowColor = Color(0xffF1BF38);

  static const lightGreenColor = Color(0xff81E5E2);
  static const redColor = Color(0xffff0000);
  static const backgroundColor = Color(0xfff8f8f8);
  static const lightRedColor = Color(0xffF2B2B8);
  static const secondaryLightGreenColor = Color(0xff7FEFE1);
  static const pinkColor = Color(0xffAFA1FA);
  static const lightPinkColor = Color(0xffF5EFFF);
  static const highlightYellow = Color(0xffFAC145);
  static const dummytest = Color(0xff282b42);
  static const noColor = Colors.transparent;


  /// Returns a shade of a [Color] from a double value
  ///
  /// The 'darker' boolean determines whether the shade
  /// should be .1 darker or lighter than the provided color
  static Color getShade(Color color, {bool darker = false, double value = .1}) {
    assert(value >= 0 && value <= 1, 'shade values must be between 0 and 1');

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness(
      (darker ? (hsl.lightness - value) : (hsl.lightness + value))
          .clamp(0.0, 1.0),
    );

    return hslDark.toColor();
  }

  /// Returns a [MaterialColor] from a [Color] object
  static MaterialColor getMaterialColorFromColor(Color color) {
    final colorShades = <int, Color>{
      50: getShade(color, value: 0.5),
      100: getShade(color, value: 0.4),
      200: getShade(color, value: 0.3),
      300: getShade(color, value: 0.2),
      400: getShade(color, value: 0.1),
      500: color, //Primary value
      600: getShade(color, value: 0.1, darker: true),
      700: getShade(color, value: 0.15, darker: true),
      800: getShade(color, value: 0.2, darker: true),
      900: getShade(color, value: 0.25, darker: true),
    };
    return MaterialColor(color.value, colorShades);
  }

}