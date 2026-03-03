import 'package:flutter/material.dart';

/// Service de navigation pour les sections de la page d'accueil
class NavigationService {
  // GlobalKeys pour chaque section
  static final GlobalKey heroKey = GlobalKey();
  static final GlobalKey personalizedSupportKey = GlobalKey();
  static final GlobalKey fastOrderKey = GlobalKey();
  static final GlobalKey aboutKey = GlobalKey();
  static final GlobalKey credibilityKey = GlobalKey();
  static final GlobalKey featuresKey = GlobalKey();
  static final GlobalKey howItWorksKey = GlobalKey();
  static final GlobalKey calendarKey = GlobalKey();
  static final GlobalKey appKey = GlobalKey();
  static final GlobalKey contactKey = GlobalKey();

  /// Dictionnaire des sections avec leurs noms
  static final Map<String, GlobalKey> sections = {
    'Accueil': heroKey,
    'Fonctionnalités': featuresKey,
    'Comment ça marche': howItWorksKey,
    'Application': appKey,
    'Contact': contactKey,
  };

  /// Fait défiler jusqu'à une section spécifique
  static void scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Fait défiler jusqu'à une section par nom
  static void scrollToSectionByName(String sectionName) {
    final key = sections[sectionName];
    if (key != null) {
      scrollToSection(key);
    }
  }

  /// Obtient tous les noms de sections
  static List<String> getSectionNames() {
    return sections.keys.toList();
  }
}
