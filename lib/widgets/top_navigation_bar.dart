import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../services/navigation_service.dart';

/// Top Navigation Bar - Barre de navigation supérieure
class TopNavigationBar extends StatelessWidget {
  const TopNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;
    final isTablet = size.width >= 768 && size.width < 1024;

    return Container(
      height: 80,
      margin: const EdgeInsets.all(20),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : (isTablet ? 40 : 60),
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: AppColors.lightCream,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          _buildLogo(),

          // Menu de navigation (Desktop & Tablet uniquement)
          if (!isMobile) _buildNavigationMenu(),

          // Contact + CTA
          if (!isMobile) _buildRightSection(isTablet) else _buildMobileMenu(),
        ],
      ),
    );
  }

  /// Logo NASCENTIA
  Widget _buildLogo() {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            gradient: AppColors.heroGradient,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Center(
            child: Text(
              'N',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          'NASCENTIA',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.darkText,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }

  /// Menu de navigation
  Widget _buildNavigationMenu() {
    final menuItems = [
      'Accueil',
      'Fonctionnalités',
      'Comment ça marche',
      'Application',
      'Contact',
    ];

    return Row(
      children: menuItems.map((item) => _buildMenuItem(item)).toList(),
    );
  }

  Widget _buildMenuItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            NavigationService.scrollToSectionByName(title);
          },
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: AppColors.darkText,
            ),
          ),
        ),
      ),
    );
  }

  /// Section droite (Téléphone + Bouton)
  Widget _buildRightSection(bool isTablet) {
    return Row(
      children: [
        // Numéro de téléphone
        if (!isTablet) ...[
          const Icon(
            Icons.phone,
            size: 18,
            color: AppColors.primaryPink,
          ),
          const SizedBox(width: 8),
          const Text(
            '(+225) 07 78 68 33 53',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(width: 20),
        ],

        // Bouton CTA
        _buildCTAButton(isTablet),
      ],
    );
  }

  /// Bouton CTA principal
  Widget _buildCTAButton(bool isSmall) {
    return Builder(
      builder: (context) => MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/download');
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: isSmall ? 20 : 28,
              vertical: 14,
            ),
            decoration: BoxDecoration(
              gradient: AppColors.heroGradient,
              borderRadius: BorderRadius.circular(999),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryPink.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              'Découvrir l\'application',
              style: TextStyle(
                fontSize: isSmall ? 13 : 15,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Menu hamburger (Mobile)
  Widget _buildMobileMenu() {
    return Builder(
      builder: (context) => IconButton(
        icon: const Icon(Icons.menu, color: AppColors.darkText),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
    );
  }
}
