import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // === Primary Palette ===
  static const Color primary = Color(0xFF00E5FF); // Cyan
  static const Color secondary = Color(0xFFBB86FC); // Purple
  static const Color accent = Color(0xFFFF4081); // Magenta/Pink

  // === Background ===
  static const Color bgDark = Color(0xFF050A14);
  static const Color bgCard = Color(0xFF0D1526);
  static const Color bgSurface = Color(0xFF111D33);
  static const Color bgGlass = Color(0x1A00E5FF); // cyan tinted glass

  // === Text ===
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textLight = Color(0xFFCDD6F4);
  static const Color textMuted = Color(0xFF7A8AAE);
  static const Color textDim = Color(0xFF3D4F6E);

  // === Borders / Dividers ===
  static const Color borderGlass = Color(0x3300E5FF);
  static const Color borderSubtle = Color(0x1AFFFFFF);

  // === Gradients ===
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF00E5FF), Color(0xFFBB86FC)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF050A14), Color(0xFF0A1628), Color(0xFF050A14)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0x2200E5FF), Color(0x22BB86FC)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFFFF4081), Color(0xFFBB86FC)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient timelineGradient = LinearGradient(
    colors: [Color(0xFF00E5FF), Color(0xFFBB86FC), Color(0xFFFF4081)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // === Skill Colors ===
  static const List<Color> skillColors = [
    Color(0xFF00E5FF),
    Color(0xFFBB86FC),
    Color(0xFFFF4081),
    Color(0xFF00FF88),
    Color(0xFFFFB300),
    Color(0xFF29B6F6),
    Color(0xFFFF7043),
    Color(0xFF66BB6A),
  ];

  // === Glow Colors ===
  static Color primaryGlow = const Color(0xFF00E5FF).withOpacity(0.3);
  static Color secondaryGlow = const Color(0xFFBB86FC).withOpacity(0.3);
  static Color accentGlow = const Color(0xFFFF4081).withOpacity(0.25);
}
