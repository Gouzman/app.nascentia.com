import 'package:flutter/material.dart';

/// Couleurs de l'application NASCENTIA - Palette Officielle
class AppColors {
  // ==================== COULEURS PRINCIPALES ====================
  // Palette de marque officielle NASCENTIA
  static const Color primary = Color(0xFFE95263); // Rose principal
  static const Color secondary = Color(0xFFF43666); // Rose secondaire
  static const Color accent = Color(0xFFFCADA3); // Rose clair accent
  static const Color purple = Color(0xFF582674); // Violet (couleur secondaire)

  // ==================== COULEURS TEXTE ====================
  static const Color white = Color(0xFFFFFFFF);
  static const Color darkText = Color(0xFF1E1E1E); // Texte principal
  static const Color greyText =
      Color(0xFF525252); // Sous-texte (meilleur contraste)
  static const Color greyLight = Color(0xFF6B7280); // Texte tertiaire

  // ==================== COULEURS FOND ====================
  static const Color lightBg = Color(0xFFF7F4F0); // Fond chaud (crème)
  static const Color warmCream = Color(0xFFF7F4F0); // Alias explicite
  static const Color warmGrey = Color(0xFF6B6560); // Gris chaud
  static const Color darkBg = Color(0xFF1E1E1E); // Fond sombre footer

  // ==================== COULEURS FEEDBACK ====================
  static const Color successGreen = Color(0xFF10B981); // Succès
  static const Color warningOrange = Color(0xFFF59E0B); // Avertissement
  static const Color infoBlue = Color(0xFF3B82F6); // Information
  static const Color errorRed = Color(0xFFEF4444); // Erreur

// ==================== DÉGRADÉS ====================
  // Dégradé principal (Hero, Sections clés) - ROSE
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      Color(0xFFE95263), // Rose principal
      Color(0xFFF43666), // Rose secondaire
    ],
    stops: [0.0, 0.85], // Transition plus progressive
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // Dégradé pour cartes (rose clair)
  static const LinearGradient cardGradient = LinearGradient(
    colors: [
      Color(0xFFFFE5E9), // Rose très clair
      Color(0xFFFCADA3), // Rose clair
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Dégradé violet pour sections spécifiques
  static const LinearGradient purpleGradient = LinearGradient(
    colors: [
      Color(0xFF582674), // Violet
      Color(0xFFA529E9), // Violet clair
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // ==================== ALIAS COMPATIBILITÉ ====================
  // Pour éviter de casser le code existant
  static const LinearGradient heroGradient = primaryGradient;
  static const LinearGradient buttonGradient = primaryGradient;
  static const LinearGradient blueCardGradient = cardGradient;

  static const Color primaryPink = primary;
  static const Color secondaryPink = secondary;
  static const Color accentPink = accent;
  static const Color primaryPurple = purple;
  static const Color secondaryPurple = accent;
  static const Color ctaColor = purple; // CTA en violet
  static const Color violet = purple;
  static const Color pink = secondary;
  static const Color blue = primary;
  static const Color accentPurple = purple;
  static const Color lightCream = Color(0xFFFFF8F5); // Crème clair
}
