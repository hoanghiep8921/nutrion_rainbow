import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Global [ThemeData] for the app.
class AppTheme {
  AppTheme._();

  static ThemeData light() {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.bgWarm,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.green,
        primary: AppColors.green,
        surface: AppColors.bgWarm,
        brightness: Brightness.light,
      ),
      splashColor: AppColors.green.withOpacity(0.12),
      highlightColor: AppColors.green.withOpacity(0.06),
    );

    return base.copyWith(
      textTheme: GoogleFonts.beVietnamProTextTheme(base.textTheme).apply(
        bodyColor: AppColors.inkSoft,
        displayColor: AppColors.ink,
      ),
    );
  }
}
