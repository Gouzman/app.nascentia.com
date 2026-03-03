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
import '../widgets/scroll_reveal.dart';
import '../services/navigation_service.dart';

/// Page d'accueil principale de NASCENTIA
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: _buildMobileDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Navigation Bar (toujours visible, pas d'animation)
            const TopNavigationBar(),

            // Hero — animation propre intégrée dans la section
            _wrapWithKey(
              key: NavigationService.heroKey,
              child: const HeroSection(),
            ),

            // R9 — Toutes les sections suivantes révélées au scroll
            _wrapWithKey(
              key: NavigationService.personalizedSupportKey,
              child: const ScrollReveal(
                duration: Duration(milliseconds: 750),
                child: PersonalizedSupportSection(),
              ),
            ),

            _wrapWithKey(
              key: NavigationService.fastOrderKey,
              child: const ScrollReveal(
                delay: Duration(milliseconds: 130),
                duration: Duration(milliseconds: 680),
                child: FastOrderSection(),
              ),
            ),

            _wrapWithKey(
              key: NavigationService.aboutKey,
              child: const ScrollReveal(
                duration: Duration(milliseconds: 820),
                child: AboutSection(),
              ),
            ),

            _wrapWithKey(
              key: NavigationService.credibilityKey,
              child: const ScrollReveal(
                delay: Duration(milliseconds: 70),
                duration: Duration(milliseconds: 640),
                child: CredibilitySection(),
              ),
            ),

            _wrapWithKey(
              key: NavigationService.featuresKey,
              child: const ScrollReveal(
                duration: Duration(milliseconds: 760),
                child: FeaturesSection(),
              ),
            ),

            _wrapWithKey(
              key: NavigationService.howItWorksKey,
              child: const ScrollReveal(
                delay: Duration(milliseconds: 110),
                duration: Duration(milliseconds: 700),
                child: HowItWorksSection(),
              ),
            ),

            _wrapWithKey(
              key: NavigationService.calendarKey,
              child: const ScrollReveal(
                duration: Duration(milliseconds: 680),
                child: CalendarSection(),
              ),
            ),

            _wrapWithKey(
              key: NavigationService.appKey,
              child: const ScrollReveal(
                delay: Duration(milliseconds: 160),
                duration: Duration(milliseconds: 750),
                child: AppSection(),
              ),
            ),

            _wrapWithKey(
              key: NavigationService.contactKey,
              child: const ScrollReveal(
                duration: Duration(milliseconds: 600),
                child: AppFooter(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _wrapWithKey({required GlobalKey key, required Widget child}) {
    return Container(key: key, child: child);
  }

  Widget _buildMobileDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE95263), Color(0xFF582674)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  'NASCENTIA',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Navigation',
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
          ),
          ..._buildMobileMenuItems(),
        ],
      ),
    );
  }

  List<Widget> _buildMobileMenuItems() {
    final items = NavigationService.getSectionNames();
    return items.map((item) {
      return ListTile(
        title: Text(item),
        onTap: () {
          Navigator.pop(context);
          NavigationService.scrollToSectionByName(item);
        },
      );
    }).toList();
  }
}
