import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_colors.dart';
import '../services/navigation_service.dart';

class TopNavigationBar extends StatefulWidget {
  final bool isScrolled;
  const TopNavigationBar({Key? key, this.isScrolled = false}) : super(key: key);

  @override
  State<TopNavigationBar> createState() => _TopNavigationBarState();
}

class _TopNavigationBarState extends State<TopNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final s = widget.isScrolled;
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;
    final isTablet = size.width >= 768 && size.width < 1024;

    return AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOutCubic,
          height: s ? 66 : 80,
          margin: s
              ? const EdgeInsets.fromLTRB(12, 8, 12, 0)
              : const EdgeInsets.all(20),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : (isTablet ? 32 : 48),
            vertical: s ? 8 : 12,
          ),
          decoration: BoxDecoration(
            color: s ? Colors.white : AppColors.lightCream,
            borderRadius: BorderRadius.circular(s ? 16 : 20),
            border: s
                ? Border.all(
                    color: Colors.black.withValues(alpha: 0.06),
                    width: 1,
                  )
                : null,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: s ? 0.10 : 0.05),
                blurRadius: s ? 28 : 10,
                spreadRadius: s ? 1 : 0,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLogo(s),
              if (!isMobile) _buildNavigationMenu(),
              if (!isMobile)
                _buildRightSection(isTablet)
              else
                _buildMobileMenu(),
            ],
          ),
        );
  }

  Widget _buildLogo(bool isScrolled) {
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          width: isScrolled ? 50 : 62,
          height: isScrolled ? 50 : 62,
          child: Image.asset(
            'lib/assets/images/logo-nascentia.png',
            fit: BoxFit.contain,
            cacheWidth: 124,
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
    return Builder(
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              final route = ModalRoute.of(context)?.settings.name;
              if (route == '/download') {
                Navigator.pushReplacementNamed(context, '/',
                    arguments: title);
              } else {
                NavigationService.scrollToSectionByName(title);
              }
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
      ),
    );
  }

  Widget _buildRightSection(bool isTablet) {
    return Row(
      children: [
        if (!isTablet) ...[
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => launchUrl(Uri.parse('tel:+2250778683353')),
              child: const Row(
                children: [
                  Icon(Icons.phone, size: 18, color: AppColors.primaryPink),
                  SizedBox(width: 8),
                  Text(
                    '(+225) 07 78 68 33 53',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkText,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 20),
        ],
        _buildCTAButton(isTablet),
      ],
    );
  }

  Widget _buildCTAButton(bool isSmall) {
    return Builder(
      builder: (context) => MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/download'),
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

  Widget _buildMobileMenu() {
    return Builder(
      builder: (context) => IconButton(
        icon: const Icon(Icons.menu, color: AppColors.darkText),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
    );
  }
}
