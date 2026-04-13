import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextStyle displayLarge = GoogleFonts.dmSerifDisplay(
    fontSize: 64,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.1,
  );

  static TextStyle displayMedium = GoogleFonts.dmSerifDisplay(
    fontSize: 48,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.15,
  );

  static TextStyle displaySmall = GoogleFonts.dmSerifDisplay(
    fontSize: 36,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  static TextStyle headingMedium = GoogleFonts.dmSerifDisplay(
    fontSize: 28,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static TextStyle bodyLarge = GoogleFonts.outfit(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.7,
  );

  static TextStyle bodyMedium = GoogleFonts.outfit(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.6,
  );

  static TextStyle bodySmall = GoogleFonts.outfit(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
    height: 1.6,
  );

  static TextStyle labelLarge = GoogleFonts.outfit(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 0.5,
  );

  static TextStyle labelSmall = GoogleFonts.outfit(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textMuted,
    letterSpacing: 1.5,
  );

  static TextStyle monoMedium = GoogleFonts.jetBrainsMono(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.accentBlue,
  );

  static TextStyle monoSmall = GoogleFonts.jetBrainsMono(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
  );

  static TextStyle navLink = GoogleFonts.outfit(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    letterSpacing: 0.8,
  );

  static TextStyle statNumber = GoogleFonts.dmSerifDisplay(
    fontSize: 40,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static TextStyle statLabel = GoogleFonts.outfit(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
    letterSpacing: 0.5,
  );
}
