import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_constants.dart';

/// Footer NASCENTIA - Design Premium
class AppFooter extends StatelessWidget {
  const AppFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 768 && size.width < 1024;
    final isMobile = size.width < 768;

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
          // Ligne principale avec 4 colonnes
          isMobile
              ? _buildMobileLayout(context)
              : isTablet
                  ? _buildTabletLayout(context)
                  : _buildDesktopLayout(context),

          const SizedBox(height: 50),

          // Séparateur
          Divider(
            color: Colors.white.withOpacity(0.1),
            thickness: 1,
          ),

          const SizedBox(height: 24),

          // Barre inférieure
          _buildBottomBar(context, isMobile),
        ],
      ),
    );
  }

  /// Layout Desktop - 4 colonnes
  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Colonne 1 - Message principal
        Expanded(
          flex: 3,
          child: _buildBrandColumn(),
        ),

        const SizedBox(width: 60),

        // Colonne 2 - Contact
        Expanded(
          flex: 2,
          child: _buildContactColumn(),
        ),

        const SizedBox(width: 60),

        // Colonne 3 - Liens
        Expanded(
          flex: 2,
          child: _buildLinksColumn(),
        ),

        const SizedBox(width: 60),

        // Colonne 4 - Newsletter
        Expanded(
          flex: 3,
          child: _buildNewsletterColumn(),
        ),
      ],
    );
  }

  /// Layout Tablet - 2×2
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
            Expanded(child: _buildLinksColumn()),
            const SizedBox(width: 40),
            Expanded(child: _buildNewsletterColumn()),
          ],
        ),
      ],
    );
  }

  /// Layout Mobile - Colonne unique
  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBrandColumn(),
        const SizedBox(height: 40),
        _buildContactColumn(),
        const SizedBox(height: 40),
        _buildLinksColumn(),
        const SizedBox(height: 40),
        _buildNewsletterColumn(),
      ],
    );
  }

  /// Colonne 1 - Message principal
  Widget _buildBrandColumn() {
    return Column(
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
        const SizedBox(height: 16),
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

  /// Colonne 2 - Contact
  Widget _buildContactColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
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
        Icon(
          icon,
          color: Colors.white70,
          size: 18,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white70,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  /// Colonne 3 - Liens
  Widget _buildLinksColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'NASCENTIA',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        _buildLink('Fonctionnalités'),
        _buildLink('Comment ça marche'),
        _buildLink('Téléchargement'),
        _buildLink('Contact'),
      ],
    );
  }

  Widget _buildLink(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            // TODO: Navigation
          },
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white70,
              height: 1.5,
            ),
          ),
        ),
      ),
    );
  }

  /// Colonne 4 - Newsletter
  Widget _buildNewsletterColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Restons en contact',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),

        // Champ email + bouton
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: AppConstants.borderRadiusPill,
          ),
          padding: EdgeInsets.all(AppConstants.spacing4),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  style: TextStyle(color: Colors.white, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Entrez votre email',
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.5),
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
                    onTap: () {
                      // TODO: Action inscription
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
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

        // Icônes sociales
        _buildSocialIcons(),
      ],
    );
  }

  /// Icônes sociales
  Widget _buildSocialIcons() {
    return Row(
      children: [
        _buildSocialIcon(Icons.facebook),
        const SizedBox(width: 16),
        _buildSocialIcon(Icons.camera_alt), // Instagram
        const SizedBox(width: 16),
        _buildSocialIcon(Icons.chat), // WhatsApp
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          // TODO: Liens sociaux
        },
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 18,
          ),
        ),
      ),
    );
  }

  /// Barre inférieure - Copyright
  Widget _buildBottomBar(BuildContext context, bool isMobile) {
    if (isMobile) {
      return Column(
        children: [
          Text(
            '© 2025 NASCENTIA. Tous droits réservés.',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white.withOpacity(0.5),
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
                style: TextStyle(color: Colors.white.withOpacity(0.5)),
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
          '© 2025 NASCENTIA. Tous droits réservés.',
          style: TextStyle(
            fontSize: 13,
            color: Colors.white.withOpacity(0.5),
          ),
        ),
        Row(
          children: [
            _buildBottomLink('Confidentialité'),
            Text(
              ' · ',
              style: TextStyle(color: Colors.white.withOpacity(0.5)),
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
        onTap: () {
          // TODO: Navigation
        },
        child: Text(
          text,
          style: TextStyle(
            fontSize: 13,
            color: Colors.white.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
