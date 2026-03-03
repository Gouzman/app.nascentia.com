import 'package:flutter/material.dart';

/// Constantes de design NASCENTIA - Material Design System
/// Toutes les valeurs suivent le principe de spacing 8dp
class AppConstants {
  // ==================== SPACING ====================
  // Utiliser ces valeurs pour tous les paddings/margins
  static const double spacing4 = 4.0;
  static const double spacing8 = 8.0;
  static const double spacing12 = 12.0;
  static const double spacing16 = 16.0;
  static const double spacing20 = 20.0;
  static const double spacing24 = 24.0;
  static const double spacing32 = 32.0;
  static const double spacing40 = 40.0;
  static const double spacing48 = 48.0;
  static const double spacing56 = 56.0;
  static const double spacing64 = 64.0;
  static const double spacing80 = 80.0;

  // ==================== BORDER RADIUS ====================
  // Système cohérent de border radius
  static const double radiusSmall = 8.0; // Petits éléments (chips, badges)
  static const double radiusMedium = 16.0; // Cartes, inputs
  static const double radiusLarge = 24.0; // Grandes cartes
  static const double radiusXLarge = 32.0; // Sections principales
  static const double radiusPill = 999.0; // Boutons pill

  // BorderRadius prédéfinis
  static BorderRadius get borderRadiusSmall =>
      BorderRadius.circular(radiusSmall);
  static BorderRadius get borderRadiusMedium =>
      BorderRadius.circular(radiusMedium);
  static BorderRadius get borderRadiusLarge =>
      BorderRadius.circular(radiusLarge);
  static BorderRadius get borderRadiusXLarge =>
      BorderRadius.circular(radiusXLarge);
  static BorderRadius get borderRadiusPill => BorderRadius.circular(radiusPill);

  // ==================== ELEVATION ====================
  // Ombres Material Design
  static List<BoxShadow> get shadowSmall => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ];

  static List<BoxShadow> get shadowMedium => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get shadowLarge => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.12),
          blurRadius: 24,
          offset: const Offset(0, 8),
        ),
      ];

  static List<BoxShadow> get shadowXLarge => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.16),
          blurRadius: 32,
          offset: const Offset(0, 12),
        ),
      ];

  // ==================== DIMENSIONS ====================
  // Hauteurs standard Material Design
  static const double buttonHeightSmall = 40.0;
  static const double buttonHeightMedium = 48.0;
  static const double buttonHeightLarge = 56.0;

  static const double inputHeight = 56.0;
  static const double iconSize = 24.0;
  static const double iconSizeLarge = 32.0;

  // ==================== ANIMATION ====================
  // Durées standard
  static const Duration animationFast = Duration(milliseconds: 150);
  static const Duration animationMedium = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);

  // Curves
  static const Curve animationCurve = Curves.easeInOut;

  // ==================== CONSTRAINTS ====================
  // Largeurs maximum pour le contenu
  static const double maxContentWidth = 1200.0;
  static const double maxTextWidth = 680.0;

  // Breakpoints responsive
  static const double breakpointMobile = 768.0;
  static const double breakpointTablet = 1024.0;
  static const double breakpointDesktop = 1440.0;
}
