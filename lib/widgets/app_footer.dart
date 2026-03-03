import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_colors.dart';
import '../theme/app_constants.dart';
import '../services/navigation_service.dart';

/// Footer NASCENTIA — Design Premium
class AppFooter extends StatelessWidget {
  const AppFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 768 && size.width < 1024;
    final isMobile = size.width < 768; // R4 — breakpoint unifié

    return Container(
      width: double.infinity,
      color: AppColors.darkBg,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile
            ? AppConstants.spacing24
            : (isTablet ? AppConstants.spacing48 : AppConstants.spacing80),
        vertical: isMobile ? AppConstants.spacing40 : AppConstants.spacing64,
      ),
      child: Column(
        children: [
          isMobile
              ? _buildMobileLayout(context)
              : isTablet
                  ? _buildTabletLayout(context)
                  : _buildDesktopLayout(context),

          const SizedBox(height: 50),

          Divider(
            // R12 — withValues au lieu de withOpacity
            color: Colors.white.withValues(alpha: 0.1),
            thickness: 1,
          ),

          const SizedBox(height: 24),

          _buildBottomBar(context, isMobile),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(flex: 3, child: _buildBrandColumn()),
        const SizedBox(width: 60),
        Expanded(flex: 2, child: _buildContactColumn()),
        const SizedBox(width: 60),
        Expanded(flex: 2, child: _buildLinksColumn(context)),
        const SizedBox(width: 60),
        Expanded(flex: 3, child: _buildNewsletterColumn()),
      ],
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildBrandColumn()),
            const SizedBox(width: 40),
            Expanded(child: _buildContactColumn()),
          ],
        ),
        const SizedBox(height: 40),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildLinksColumn(context)),
            const SizedBox(width: 40),
            Expanded(child: _buildNewsletterColumn()),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBrandColumn(),
        const SizedBox(height: 40),
        _buildContactColumn(),
        const SizedBox(height: 40),
        _buildLinksColumn(context),
        const SizedBox(height: 40),
        _buildNewsletterColumn(),
      ],
    );
  }

  Widget _buildBrandColumn() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'NASCENTIA —\nComprendre aujourd\'hui,\npréparer demain.',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1.4,
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Une approche scientifique au service des familles.',
          style: TextStyle(
            fontSize: 15,
            color: Colors.white70,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildContactColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contact',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 20),
        _buildContactItem(Icons.email_outlined, 'doumbiabonmanin@gmail.com'),
        const SizedBox(height: 12),
        _buildContactItem(Icons.phone_outlined, '(+225) 07 78 68 33 53'),
        const SizedBox(height: 12),
        _buildContactItem(Icons.location_on_outlined, 'Cocody, Côte d\'Ivoire'),
      ],
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70, size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 14, color: Colors.white70, height: 1.5),
          ),
        ),
      ],
    );
  }

  /// R3 — Liens fonctionnels (Téléchargement navigue vers /download)
  Widget _buildLinksColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'NASCENTIA',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 20),
        _buildLink('Fonctionnalités', context),
        _buildLink('Comment ça marche', context),
        _buildLink('Téléchargement', context),
        _buildLink('Contact', context),
      ],
    );
  }

  Widget _buildLink(String text, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => _handleLinkNavigation(text, context),
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 14, color: Colors.white70, height: 1.5),
          ),
        ),
      ),
    );
  }

  void _handleLinkNavigation(String linkText, BuildContext context) {
    switch (linkText) {
      case 'Fonctionnalités':
        NavigationService.scrollToSectionByName('Fonctionnalités');
        break;
      case 'Comment ça marche':
        NavigationService.scrollToSectionByName('Comment ça marche');
        break;
      case 'Téléchargement':
        // R3 — Navigation fonctionnelle vers la page de téléchargement
        Navigator.pushNamed(context, '/download');
        break;
      case 'Contact':
        NavigationService.scrollToSectionByName('Contact');
        break;
    }
  }

  Widget _buildNewsletterColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Restons en contact',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 20),

        Container(
          decoration: BoxDecoration(
            // R12 — withValues au lieu de withOpacity
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: AppConstants.borderRadiusPill,
          ),
          padding: EdgeInsets.all(AppConstants.spacing4),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Entrez votre email',
                    hintStyle: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: AppColors.purpleGradient,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(999),
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      child: Text(
                        'S\'inscrire',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // R11 — Vraies icônes de marque avec FontAwesome
        _buildSocialIcons(),
      ],
    );
  }

  Widget _buildSocialIcons() {
    return Row(
      children: [
        _buildSocialIcon(FontAwesomeIcons.facebookF),
        const SizedBox(width: 16),
        _buildSocialIcon(FontAwesomeIcons.instagram),
        const SizedBox(width: 16),
        _buildSocialIcon(FontAwesomeIcons.whatsapp),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            // R12 — withValues au lieu de withOpacity
            color: Colors.white.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: FaIcon(icon, color: Colors.white, size: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context, bool isMobile) {
    if (isMobile) {
      return Column(
        children: [
          // R3 — Copyright mis à jour 2025 → 2026
          Text(
            '© 2026 NASCENTIA. Tous droits réservés.',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white.withValues(alpha: 0.5),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildBottomLink('Confidentialité'),
              Text(
                ' · ',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
              ),
              _buildBottomLink('Conditions'),
            ],
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '© 2026 NASCENTIA. Tous droits réservés.',
          style: TextStyle(
            fontSize: 13,
            color: Colors.white.withValues(alpha: 0.5),
          ),
        ),
        Row(
          children: [
            _buildBottomLink('Confidentialité'),
            Text(
              ' · ',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
            ),
            _buildBottomLink('Conditions'),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomLink(String text) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {},
        child: Text(
          text,
          style: TextStyle(
            fontSize: 13,
            color: Colors.white.withValues(alpha: 0.5),
          ),
        ),
      ),
    );
  }
}
