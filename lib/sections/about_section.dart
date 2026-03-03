import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/section_container.dart';

/// Section "À propos de NASCENTIA" — angle histoire et mission
class AboutSection extends StatefulWidget {
  const AboutSection({Key? key}) : super(key: key);

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  int _hoveredValueIndex = -1;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768; // R4 — breakpoint unifié

    // R5 — SectionContainer gère déjà le padding ; pas de Container interne dupliqué
    return SectionContainer(
      backgroundColor: AppColors.lightBg,
      child: Column(
        children: [
          _buildBadge(isMobile),
          SizedBox(height: isMobile ? 24 : 32),
          _buildGradientTitle(context, isMobile),
          SizedBox(height: isMobile ? 16 : 24),
          _buildDescription(context, isMobile),
          SizedBox(height: isMobile ? 40 : 60),
          _buildTimeline(context, isMobile),
          SizedBox(height: isMobile ? 40 : 60),
          _buildValueCards(context, isMobile),
        ],
      ),
    );
  }

  Widget _buildBadge(bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 24,
        vertical: isMobile ? 8 : 12,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.1),
            AppColors.secondary.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.auto_stories_outlined,
              color: AppColors.primary, size: isMobile ? 16 : 20),
          SizedBox(width: isMobile ? 6 : 8),
          Text(
            'NOTRE HISTOIRE',
            style: TextStyle(
              fontSize: isMobile ? 11 : 13,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradientTitle(BuildContext context, bool isMobile) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [AppColors.primary, AppColors.secondary],
      ).createShader(bounds),
      child: Text(
        'Une expertise scientifique au service des familles',
        textAlign: TextAlign.center,
        style: (isMobile
                ? AppTextStyles.headlineMedium(context)
                : AppTextStyles.displayMedium(context))
            .copyWith(color: AppColors.white, height: 1.3),
      ),
    );
  }

  Widget _buildDescription(BuildContext context, bool isMobile) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 800),
      child: Text(
        'Créée en mars 2022, NASCENTIA est une start-up spécialisée dans l\'expertise scientifique, '
        'technologique et informatique appliquée à la santé reproductive. Elle accompagne les couples '
        'à travers une solution fiable, éthique et innovante, capable de répondre à une problématique '
        'universelle : le désir de choisir ou de connaître le sexe de son futur enfant.',
        textAlign: TextAlign.center,
        style: AppTextStyles.bodyLarge(context).copyWith(
          color: AppColors.greyText,
          height: 1.8,
        ),
      ),
    );
  }

  Widget _buildTimeline(BuildContext context, bool isMobile) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: isMobile ? 600 : 800),
      child: Row(
        children: [
          _buildTimelinePoint('Mars 2022', 'Création de\nNASCENTIA', isMobile),
          Expanded(
            child: Container(
              height: 2,
              margin: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.secondary],
                ),
              ),
            ),
          ),
          _buildTimelinePoint('Aujourd\'hui', '10 000+\nFamilles', isMobile),
        ],
      ),
    );
  }

  Widget _buildTimelinePoint(String date, String label, bool isMobile) {
    return Column(
      children: [
        Container(
          width: isMobile ? 16 : 20,
          height: isMobile ? 16 : 20,
          decoration: BoxDecoration(
            gradient:
                const LinearGradient(colors: [AppColors.primary, AppColors.secondary]),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.3),
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
        ),
        SizedBox(height: isMobile ? 12 : 16),
        Text(
          date,
          style: TextStyle(
            fontSize: isMobile ? 13 : 15,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: isMobile ? 4 : 6),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isMobile ? 11 : 13,
            color: AppColors.greyText,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildValueCards(BuildContext context, bool isMobile) {
    final values = [
      {
        'icon': Icons.verified_outlined,
        'title': 'Fiabilité',
        'description': 'Méthode scientifiquement validée avec 90 % de précision',
      },
      {
        'icon': Icons.favorite_outline,
        'title': 'Éthique',
        'description': 'Respect des valeurs familiales et accompagnement responsable',
      },
      {
        'icon': Icons.lightbulb_outline,
        'title': 'Innovation',
        'description': 'Technologie de pointe au service de la santé reproductive',
      },
    ];

    if (isMobile) {
      return Column(
        children: values
            .asMap()
            .entries
            .map((entry) => Padding(
                  padding: EdgeInsets.only(
                    bottom: entry.key < values.length - 1 ? 20 : 0,
                  ),
                  child: _buildValueCard(
                    entry.value['icon'] as IconData,
                    entry.value['title'] as String,
                    entry.value['description'] as String,
                    entry.key,
                    isMobile,
                  ),
                ))
            .toList(),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: values
          .asMap()
          .entries
          .map((entry) => Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: entry.key == 1 ? 16 : 8,
                  ),
                  child: _buildValueCard(
                    entry.value['icon'] as IconData,
                    entry.value['title'] as String,
                    entry.value['description'] as String,
                    entry.key,
                    isMobile,
                  ),
                ),
              ))
          .toList(),
    );
  }

  Widget _buildValueCard(
    IconData icon,
    String title,
    String description,
    int index,
    bool isMobile,
  ) {
    final isHovered = _hoveredValueIndex == index;

    // R10 — Gradient hover adouci : 2 couleurs au lieu de 4
    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredValueIndex = index),
      onExit: (_) => setState(() => _hoveredValueIndex = -1),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: isHovered
              ? const LinearGradient(
                  colors: [AppColors.primary, AppColors.purple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: EdgeInsets.all(isHovered ? 2 : 1),
        transform: Matrix4.translationValues(0.0, isHovered ? -6.0 : 0.0, 0.0),
        child: Container(
          padding: EdgeInsets.all(isMobile ? 24 : 32),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(18),
            border: !isHovered
                ? Border.all(
                    color: AppColors.greyLight.withValues(alpha: 0.3),
                    width: 1,
                  )
                : null,
          ),
          child: Column(
            children: [
              Container(
                width: isMobile ? 56 : 64,
                height: isMobile ? 56 : 64,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0x1AE95263),
                      Color(0x1AF43666),
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon,
                    size: isMobile ? 28 : 32, color: AppColors.primary),
              ),
              SizedBox(height: isMobile ? 16 : 20),
              Text(
                title,
                style: AppTextStyles.headlineSmall(context)
                    .copyWith(color: AppColors.darkText),
              ),
              SizedBox(height: isMobile ? 8 : 12),
              Text(
                description,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium(context).copyWith(
                  color: AppColors.greyText,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
