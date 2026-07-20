import 'package:flutter/material.dart';

/// Central color palette, lifted directly from the Nutrition Rainbow
/// HTML design template so the Flutter app matches it 1:1.
class AppColors {
  AppColors._();

  // Backgrounds
  static const Color bg = Color(0xFFF3EFE6); // canvas / app background
  static const Color bgWarm = Color(0xFFFBF8F1); // screen background
  static const Color bgSoft = Color(0xFFFFFDF8); // onboarding top
  static const Color bgSoft2 = Color(0xFFFFF6EC); // onboarding bottom

  // Ink / text
  static const Color ink = Color(0xFF2A2925);
  static const Color inkSoft = Color(0xFF57544C);
  static const Color muted = Color(0xFF7A776E);
  static const Color muted2 = Color(0xFF9B978C);
  static const Color muted3 = Color(0xFFB7B3A8);
  static const Color faint = Color(0xFFC9C4B7);

  // Lines / surfaces
  static const Color line = Color(0xFFF0ECE2);
  static const Color lineDark = Color(0xFFEDE8DC);
  static const Color chip = Color(0xFFF3EFE6);
  static const Color white = Color(0xFFFFFFFF);

  // The six nutrition-rainbow colors
  static const Color red = Color(0xFFFF5A5F);
  static const Color redLight = Color(0xFFFF7A6E);
  static const Color orange = Color(0xFFFF9F45);
  static const Color orangeLight = Color(0xFFFFB061);
  static const Color yellow = Color(0xFFFFCE31);
  static const Color yellowDeep = Color(0xFFF5BE1E);
  static const Color yellowInk = Color(0xFF7A5B00);
  static const Color green = Color(0xFF34C77B);
  static const Color greenDeep = Color(0xFF2E7D5B);
  static const Color greenLight = Color(0xFF8BE0AF);
  static const Color greenInk = Color(0xFF1F7A4D);
  static const Color blue = Color(0xFF3B9EFF);
  static const Color purple = Color(0xFF9B6DFF);

  // Accents
  static const Color streak = Color(0xFFF97316);
  static const Color streakBg = Color(0xFFFFF1E4);
  static const Color tipBg = Color(0xFFFFF4E9);
  static const Color tipTitle = Color(0xFFB4690E);
  static const Color tipBody = Color(0xFF8A6A3E);

  /// The rainbow used for conic / sweep gradients (logo, rings).
  static const List<Color> rainbow = [
    red,
    orange,
    yellow,
    green,
    blue,
    purple,
    red,
  ];
}
