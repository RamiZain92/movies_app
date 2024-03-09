import 'package:flutter/material.dart';

class ColorResources {
  static const MaterialColor colorPrimary = MaterialColor(
    0XFFFC953F,
    {
      50: Color.fromRGBO(252, 149, 63, .1),
      100: Color.fromRGBO(252, 149, 63, .2),
      200: Color.fromRGBO(252, 149, 63, .3),
      300: Color.fromRGBO(252, 149, 63, .4),
      400: Color.fromRGBO(252, 149, 63, .5),
      500: Color.fromRGBO(252, 149, 63, .6),
      600: Color.fromRGBO(252, 149, 63, .7),
      700: Color.fromRGBO(252, 149, 63, .8),
      800: Color.fromRGBO(252, 149, 63, .9),
      900: Color.fromRGBO(252, 149, 63, 1),
    },
  );

  static const Color backgroundScaffold = Colors.white;
  static final Color bgBtnSelect = fromHex("#FFF4EC");
  // static final Color bgBtnSelect = fromHex("#FC953F");
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static final Color dark = fromHex("#393530");
  static final Color yellow_1 = fromHex("#F2C94C");
  static final Color orange_3 = fromHex("#999300");
  static final Color overlay_gray = fromHex("#EAEAEA");

  static final Color red = fromHex("#EB5757");
  static final Color backgroundAppBar = fromHex("#393530");
  static final Color backgroundInput = fromHex("#F2F2F2");
  static final Color darkBleu = fromHex("#20212E");
  static final Color gray = fromHex("#9F9F9E");
  static final Color lightGray = fromHex("#F5F5F5");
  static final Color gray_1 = fromHex("#333333");
  static final Color gray_2 = fromHex("#4F4F4F");
  static final Color gray_3 = fromHex("#828282");
  static final Color gray_4 = fromHex("#BDBDBD");
  static final Color gray_5 = fromHex("#E0E0E0");
  static final Color gray_6 = fromHex("#F2F2F2");
  static final Color green_1 = fromHex("#219653");
  static final Color blue_1 = fromHex("#2F80ED");
  static final Color orange = fromHex("#F2994A");
  static final Color orange2 = fromHex("#FC953F");

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
