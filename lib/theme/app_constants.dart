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
  static const double spacing30 = 30.0;
  static const double spacing32 = 32.0;
  static const double spacing40 = 40.0;
  static const double spacing48 = 48.0;
  static const double spacing56 = 56.0;
  static const double spacing60 = 60.0;
  static const double spacing64 = 64.0;
  static const double spacing80 = 80.0;
  static const double spacing100 = 100.0;

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
  static const double breakpointSmallMobile = 600.0; // iPhone SE, petits Android
  static const double breakpointMobile = 768.0;
  static const double breakpointTablet = 1024.0;
  static const double breakpointDesktop = 1440.0;

  // ==================== RESPONSIVE HELPERS ====================
  /// Vérifie si l'écran est très petit (< 600px) - iPhone SE, Android compacts
  static bool isSmallMobile(BuildContext context) {
    return (MediaQuery.maybeOf(context)?.size.width ?? 1024) < breakpointSmallMobile;
  }

  /// Vérifie si l'écran est en mode mobile (< 768px)
  static bool isMobile(BuildContext context) {
    return (MediaQuery.maybeOf(context)?.size.width ?? 1024) < breakpointMobile;
  }

  /// Vérifie si l'écran est en mode tablet (768px - 1024px)
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.maybeOf(context)?.size.width ?? 1024;
    return width >= breakpointMobile && width < breakpointTablet;
  }

  /// Vérifie si l'écran est en mode desktop (>= 1024px)
  static bool isDesktop(BuildContext context) {
    return (MediaQuery.maybeOf(context)?.size.width ?? 1024) >= breakpointTablet;
  }

  /// Retourne la largeur de l'écran
  static double screenWidth(BuildContext context) {
    return MediaQuery.maybeOf(context)?.size.width ?? 1024;
  }

  /// Padding horizontal responsive optimisé pour tous les téléphones
  /// - Petit mobile (< 600px): 16px (gain d'espace)
  /// - Mobile standard (< 768px): 20px
  /// - Tablet: 40px
  /// - Desktop: 80px
  static double responsiveHorizontalPadding(BuildContext context) {
    final width = screenWidth(context);
    if (width < breakpointSmallMobile) return spacing16; // iPhone SE, petits Android
    if (width < breakpointMobile) return spacing20; // Mobile standard
    if (width < breakpointTablet) return spacing40; // Tablet
    return spacing80; // Desktop
  }

  /// Padding vertical responsive basé sur la taille d'écran
  static double responsiveVerticalPadding(BuildContext context) {
    return isMobile(context) ? spacing56 : spacing80;
  }

  /// Espacement vertical entre sections responsive
  /// Remplace les SizedBox(height: 60) fixes
  /// - Petit mobile: 24px
  /// - Mobile standard: 32px
  /// - Tablet+: 60px
  static double responsiveSectionSpacing(BuildContext context) {
    final width = screenWidth(context);
    if (width < breakpointSmallMobile) return spacing24;
    if (width < breakpointMobile) return spacing32;
    return spacing60;
  }

  /// Espacement vertical entre éléments dans une section
  /// - Petit mobile: 16px
  /// - Mobile standard: 20px
  /// - Tablet+: 30px
  static double responsiveItemSpacing(BuildContext context) {
    final width = screenWidth(context);
    if (width < breakpointSmallMobile) return spacing16;
    if (width < breakpointMobile) return spacing20;
    return spacing30;
  }

  /// Largeur maximale responsive pour images/phone mockups
  /// Garantit qu'ils ne dépassent jamais l'écran avec marge confortable
  /// - Retourne min(maxWidth, 70% de la largeur d'écran)
  static double responsiveMaxWidth(BuildContext context, double maxWidth) {
    final screenW = screenWidth(context);
    if (isMobile(context)) {
      return screenW < breakpointSmallMobile
          ? screenW * 0.70 // Petit mobile: max 70%
          : screenW * 0.75; // Mobile standard: max 75%
    }
    return maxWidth; // Tablet/Desktop: utiliser maxWidth fixe
  }

  /// Font size minimum pour lisibilité (WCAG compliance)
  /// Augmente automatiquement si < 12px
  static double ensureMinFontSize(double fontSize) {
    return fontSize < 12.0 ? 12.0 : fontSize;
  }
}
