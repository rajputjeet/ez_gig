import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppColors {
  static const background    = Color(0xFFF4F4F4);
  static const surface       = Color(0xFFFFFFFF);
  static const dark          = Color(0xFF1C1C1C);
  static const darkCard      = Color(0xFF474747);
  static const pinkCardBg    = Color(0xFFFFF0F8);
  static const pinkCardText  = Color(0xFFE84C7D);
  static const purpleCardBg  = Color(0xFFF5F3FF);
  static const purpleCardText = Color(0xFF7B5CF0);
  static const redBadge      = Color(0xFFFF3B30);
  static const starColor     = Color(0xFFFFC107);
  static const expBadgeBg    = Color(0xFFF0EEE8);
  static const expBadgeText  = Color(0xFF8C8C8C);
  static const textPrimary   = Color(0xFF1A1A1A);
  static const textSecondary = Color(0xFF9E9E9E);
  static const grey          = Color(0xFFF9F9F9);
  static const textGrey       = Color(0xFF7D7D7D);
  static const textHint      = Color(0xFFBDBDBD);
  static const border        = Color(0xFFEEEEEE);
  static const divider       = Color(0xFFF0F0F0);
  static const toggleActive  = Color(0xFF1C1C1C);
  static const logoutRed     = Color(0xFFFF3B30);
  static const profileHeaderBg = Color(0xFFF0EDE6);
}

abstract class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,
    fontFamily: 'Jost',
    textTheme: GoogleFonts.jostTextTheme().copyWith(
      titleLarge: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      titleMedium: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      bodyMedium: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      bodySmall: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.dark,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 18, fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      iconTheme: IconThemeData(color: AppColors.textPrimary),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.dark, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.logoutRed),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

    ),
  );

}
