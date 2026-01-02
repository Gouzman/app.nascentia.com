import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Styles de texte NASCENTIA - Hiérarchie Material Design
/// Suit la hiérarchie : Display > Headline > Title > Body > Label
class AppTextStyles {
  // ==================== DISPLAY ====================
  // Pour les hero sections et titres très importants
  static TextStyle displayLarge(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 768;
    return GoogleFonts.poppins(
      fontSize: isSmall ? 40 : 72,
      fontWeight: FontWeight.w900,
      color: AppColors.white,
      height: 1.1,
      letterSpacing: -1.0,
    );
  }

  static TextStyle displayMedium(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 768;
    return GoogleFonts.poppins(
      fontSize: isSmall ? 32 : 56,
      fontWeight: FontWeight.bold,
      color: AppColors.white,
      height: 1.2,
    );
  }

  // ==================== HEADLINE ====================
  // Pour les titres de sections
  static TextStyle headlineLarge(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 768;
    return GoogleFonts.poppins(
      fontSize: isSmall ? 32 : 48,
      fontWeight: FontWeight.bold,
      color: AppColors.darkText,
      height: 1.2,
    );
  }

  static TextStyle headlineMedium(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 768;
    return GoogleFonts.poppins(
      fontSize: isSmall ? 28 : 40,
      fontWeight: FontWeight.bold,
      color: AppColors.darkText,
      height: 1.3,
    );
  }

  static TextStyle headlineSmall(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 768;
    return GoogleFonts.poppins(
      fontSize: isSmall ? 24 : 32,
      fontWeight: FontWeight.w600,
      color: AppColors.darkText,
      height: 1.3,
    );
  }

  // ==================== TITLE ====================
  // Pour les sous-titres et titres de cartes
  static TextStyle titleLarge(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 768;
    return GoogleFonts.poppins(
      fontSize: isSmall ? 20 : 24,
      fontWeight: FontWeight.w600,
      color: AppColors.darkText,
      height: 1.4,
    );
  }

  static TextStyle titleMedium(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 768;
    return GoogleFonts.poppins(
      fontSize: isSmall ? 18 : 20,
      fontWeight: FontWeight.w600,
      color: AppColors.darkText,
      height: 1.4,
    );
  }

  static TextStyle titleSmall(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.darkText,
      height: 1.4,
    );
  }

  // ==================== BODY ====================
  // Pour les paragraphes et contenus principaux
  static TextStyle bodyLarge(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 768;
    return GoogleFonts.poppins(
      fontSize: isSmall ? 16 : 18,
      fontWeight: FontWeight.w400,
      color: AppColors.white, // Par défaut blanc (pour Hero)
      height: 1.7, // Meilleure lisibilité
    );
  }

  static TextStyle bodyMedium(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.greyText,
      height: 1.7, // Uniformisé
    );
  }

  static TextStyle bodySmall(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.greyText,
      height: 1.6,
    );
  }

  // ==================== LABEL ====================
  // Pour les boutons, chips, badges
  static TextStyle labelLarge(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.white,
      letterSpacing: 0.5,
    );
  }

  static TextStyle labelMedium(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppColors.white,
      letterSpacing: 0.5,
    );
  }

  static TextStyle labelSmall(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: AppColors.greyText,
      letterSpacing: 0.5,
    );
  }

  // ==================== LEGACY COMPATIBILITY ====================
  // Alias pour compatibilité avec l'ancien code
  static TextStyle heroTitle(BuildContext context) => displayMedium(context);
  static TextStyle heroSubtitle(BuildContext context) =>
      bodyLarge(context).copyWith(color: AppColors.white);
  static TextStyle sectionTitle(BuildContext context) => headlineLarge(context);
  static TextStyle sectionSubtitle(BuildContext context) =>
      headlineSmall(context);
  static TextStyle bodyText(BuildContext context) => bodyLarge(context);
  static TextStyle buttonText(BuildContext context) => labelLarge(context);
  static TextStyle cardTitle(BuildContext context) => titleLarge(context);
  static TextStyle cardText(BuildContext context) => bodyMedium(context);
}
