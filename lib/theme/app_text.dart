import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Typography helpers. The template uses two families:
///  - Fredoka   -> playful display / headings
///  - Be Vietnam Pro -> body text (great Vietnamese diacritics support)
///
/// Fonts are pulled at runtime via `google_fonts`. On first launch an
/// internet connection is used to fetch them; afterwards they are cached.
class AppText {
  AppText._();

  /// Display / heading font (Fredoka).
  static TextStyle fredoka({
    double size = 16,
    FontWeight weight = FontWeight.w600,
    Color color = AppColors.ink,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.fredoka(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  /// Body font (Be Vietnam Pro).
  static TextStyle body({
    double size = 14,
    FontWeight weight = FontWeight.w400,
    Color color = AppColors.inkSoft,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.beVietnamPro(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }
}
