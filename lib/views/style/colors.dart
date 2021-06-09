import 'package:flutter/material.dart';

class EcoAppColors{

  static const Color MAIN_COLOR = Color.fromRGBO(20, 153, 17, 1);
  static const Color MAIN_DARK_COLOR = Color.fromRGBO(0, 139, 114, 1);//Color.fromRGBO(37, 109, 27, 1);
  static const Color ACCENT_COLOR = Color.fromRGBO(245, 184, 46, 1);
  static const Color BLUE_ACCENT_COLOR = Color.fromRGBO(58, 174, 216, 1);
  static const Color RED_COLOR = Color.fromRGBO(255, 15, 128, 1);
  static const Color LEFT_BAR_COLOR = Color.fromRGBO(0, 139, 114, 1);


  // ranges from 0.0 to 1.0

  static Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  static Color lighten(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }
}