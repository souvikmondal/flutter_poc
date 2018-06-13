import 'package:flutter/material.dart';

class AppColors {

  static const MaterialColor green = const MaterialColor(
    _greenPrimaryValue,
    const <int, Color>{
      50: const Color(0xFFF1F8E9),
      100: const Color(0xFFDCEDC8),
      200: const Color(0xFFC5E1A5),
      300: const Color(0xFFAED581),
      400: const Color(0xFF9CCC65),
      500: const Color(_greenPrimaryValue),
      600: const Color(0xFF7CB342),
      700: const Color(0xFF689F38),
      800: const Color(0xFF558B2F),
      900: const Color(0xFF33691E),
    },
  );

  static const int _greenPrimaryValue = 0xFF8BC34A;

  static const Color darkGreen = const Color(0xFF5F970E);
}
