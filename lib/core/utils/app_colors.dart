import 'dart:ui';

import 'package:flutter/cupertino.dart';

class AppColors {

  static const Color white = Color(0xFFFFFFFF);
  static const Color white30Percent = Color(0x50FFFFFF);
  static const Color grey4E = Color(0xFF4E4E4E);
  static const Color grey78 = Color(0xFF787878);
  static const Color grey92 = Color(0xFF929292);
  static const Color greyB2 = Color(0xFFB2B2B2);
  static const Color black = Color(0xFF000000);
  static const Color black40Percent = Color(0x70000000);
  static const Color primaryGold = Color(0xFFD5A85E);
  static const Color secondaryGreen = Color(0xFF64937D);
  static const Color secondaryDarkBlue = Color(0xFF33526A);

  static const Color red10Percent = Color(0x1AF70004);

  static const LinearGradient primaryButtonGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
      colors: [
        Color(0xFFB2905F),
        Color(0xFFD5A85E),
  ]
  );

  static const LinearGradient onboardingGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
      colors: [
        Color(0xFFFFFFFF),
        Color(0xFF64937D),
  ]
  );
}