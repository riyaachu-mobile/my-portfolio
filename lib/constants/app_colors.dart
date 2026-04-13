import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFF06060B);
  static const Color surface = Color(0xFF0D0D1A);
  static const Color surfaceLight = Color(0xFF12121F);
  static const Color accentBlue = Color(0xFF4F8FFC);
  static const Color accentPurple = Color(0xFF6C5CE7);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFA0A0B0);
  static const Color textMuted = Color(0xFF5A5A7A);
  static const Color border = Color(0xFF1E1E30);
  static const Color cardBg = Color(0xFF0F0F1C);

  static const LinearGradient accentGradient = LinearGradient(
    colors: [accentBlue, accentPurple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGlow = LinearGradient(
    colors: [Color(0x334F8FFC), Color(0x336C5CE7)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
