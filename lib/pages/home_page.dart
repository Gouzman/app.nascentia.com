import 'package:flutter/material.dart';
import '../sections/hero_section.dart';
import '../sections/personalized_support_section.dart';
import '../sections/fast_order_section.dart';
import '../sections/about_section.dart';
import '../sections/credibility_section.dart';
import '../sections/features_section.dart';
import '../sections/how_it_works_section.dart';
import '../sections/calendar_section.dart';
import '../sections/app_section.dart';
import '../widgets/top_navigation_bar.dart';
import '../widgets/app_footer.dart';

/// Page d'accueil principale de NASCENTIA
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: const [
            // Top Navigation Bar
            TopNavigationBar(),

            // Section Hero - Plein écran
            HeroSection(),

            // Section 2 - Accompagnement personnalisé
            PersonalizedSupportSection(),

            // Section 3 - Commande rapide et simplifiée
            FastOrderSection(),

            // Section À propos
            AboutSection(),

            // Section Crédibilité
            CredibilitySection(),

            // Section Fonctionnalités
            FeaturesSection(),

            // Section Comment ça marche
            HowItWorksSection(),

            // Section Calendrier
            CalendarSection(),

            // Section Application
            AppSection(),

            // Footer
            AppFooter(),
          ],
        ),
      ),
    );
  }
}
