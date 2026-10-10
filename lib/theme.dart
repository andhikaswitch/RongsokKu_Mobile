import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Palet RongsokKu — nama & nilai mengikuti variabel Figma
/// (merk = emerald, nilai = amber, slate = netral, status = warna status).
class AppColors {
  // merk
  static const merk50 = Color(0xFFECFDF5);
  static const merk100 = Color(0xFFD1FAE5);
  static const merk200 = Color(0xFFA7F3D0);
  static const merk500 = Color(0xFF10B981);
  static const merk600 = Color(0xFF059669);
  static const merk700 = Color(0xFF047857);
  static const merk800 = Color(0xFF065F46);
  static const merk900 = Color(0xFF064E3B);

  // nilai (uang / aksen)
  static const nilai50 = Color(0xFFFFFBEB);
  static const nilai100 = Color(0xFFFEF3C7);
  static const nilai500 = Color(0xFFF59E0B);
  static const nilai700 = Color(0xFFB45309);

  // slate
  static const slate50 = Color(0xFFF8FAFC);
  static const slate100 = Color(0xFFF1F5F9);
  static const slate200 = Color(0xFFE2E8F0);
  static const slate300 = Color(0xFFCBD5E1);
  static const slate400 = Color(0xFF94A3B8);
  static const slate500 = Color(0xFF64748B);
  static const slate600 = Color(0xFF475569);
  static const slate700 = Color(0xFF334155);
  static const slate800 = Color(0xFF1E293B);
  static const slate900 = Color(0xFF0F172A);

  // status
  static const sky50 = Color(0xFFF0F9FF);
  static const sky700 = Color(0xFF0369A1);
  static const violet50 = Color(0xFFF5F3FF);
  static const violet600 = Color(0xFF7C3AED);
  static const violet700 = Color(0xFF6D28D9);
  static const orange50 = Color(0xFFFFF7ED);
  static const orange700 = Color(0xFFC2410C);
  static const rose50 = Color(0xFFFFF1F2);
  static const rose100 = Color(0xFFFFE4E6);
  static const rose600 = Color(0xFFE11D48);
  static const rose700 = Color(0xFFBE123C);
  static const blue600 = Color(0xFF2563EB);

  static const putih = Colors.white;

  // alias lama
  static const emerald = merk600;
  static const emeraldDark = merk700;
  static const emeraldLight = merk100;
  static const amber = nilai500;
  static const amberLight = nilai100;
  static const bg = slate50;
  static const surface = putih;
  static const ink = slate900;
  static const inkMuted = slate500;
  static const line = slate200;
  static const danger = rose600;
}

/// Gaya teks dari Figma (Plus Jakarta Sans). Letter-spacing -1.5% pada judul.
class T {
  static const xl = TextStyle(
      fontSize: 26, height: 32 / 26, fontWeight: FontWeight.w800,
      letterSpacing: -0.39, color: AppColors.slate900);
  static const l = TextStyle(
      fontSize: 20, height: 28 / 20, fontWeight: FontWeight.w700,
      letterSpacing: -0.3, color: AppColors.slate900);
  static const m = TextStyle(
      fontSize: 16, height: 22 / 16, fontWeight: FontWeight.w700,
      letterSpacing: -0.24, color: AppColors.slate900);
  static const body = TextStyle(
      fontSize: 14, height: 20 / 14, fontWeight: FontWeight.w400,
      color: AppColors.slate900);
  static const bodyBold = TextStyle(
      fontSize: 14, height: 20 / 14, fontWeight: FontWeight.w600,
      color: AppColors.slate900);
  static const s = TextStyle(
      fontSize: 12, height: 16 / 12, fontWeight: FontWeight.w400,
      color: AppColors.slate500);
  static const label = TextStyle(
      fontSize: 12, height: 16 / 12, fontWeight: FontWeight.w600,
      color: AppColors.slate900);
  static const xs = TextStyle(
      fontSize: 10, height: 14 / 10, fontWeight: FontWeight.w600,
      color: AppColors.slate500);
}

ThemeData buildTheme() {
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.merk600,
      primary: AppColors.merk600,
      secondary: AppColors.nilai500,
      surface: AppColors.putih,
    ),
    scaffoldBackgroundColor: AppColors.slate50,
    splashFactory: InkRipple.splashFactory,
  );

  return base.copyWith(
    textTheme: GoogleFonts.plusJakartaSansTextTheme(base.textTheme).apply(
      bodyColor: AppColors.slate900,
      displayColor: AppColors.slate900,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.putih,
      foregroundColor: AppColors.slate900,
      elevation: 0,
      centerTitle: false,
      scrolledUnderElevation: 0,
    ),
    dividerTheme: const DividerThemeData(color: AppColors.slate100, space: 1),
  );
}
