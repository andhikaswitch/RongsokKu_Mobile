import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Palet & tema RongsokKu — mengacu ke desain Figma (emerald + amber).
class AppColors {
  static const emerald = Color(0xFF059669);
  static const emeraldDark = Color(0xFF047857);
  static const emeraldLight = Color(0xFFD1FAE5);
  static const amber = Color(0xFFF59E0B);
  static const amberLight = Color(0xFFFEF3C7);

  static const bg = Color(0xFFF8FAFC);
  static const surface = Color(0xFFFFFFFF);
  static const ink = Color(0xFF0F172A);
  static const inkMuted = Color(0xFF64748B);
  static const line = Color(0xFFE2E8F0);
  static const danger = Color(0xFFDC2626);
}

ThemeData buildTheme() {
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.emerald,
      primary: AppColors.emerald,
      secondary: AppColors.amber,
      surface: AppColors.surface,
    ),
    scaffoldBackgroundColor: AppColors.bg,
  );

  return base.copyWith(
    textTheme: GoogleFonts.plusJakartaSansTextTheme(base.textTheme).apply(
      bodyColor: AppColors.ink,
      displayColor: AppColors.ink,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.surface,
      foregroundColor: AppColors.ink,
      elevation: 0,
      centerTitle: false,
      scrolledUnderElevation: 0,
    ),
  );
}
