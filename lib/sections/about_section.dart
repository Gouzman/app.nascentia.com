import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/section_container.dart';

/// Section "À propos de NASCENTIA"
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
    final isSmall = screenWidth < 600;
    final isMedium = screenWidth < 1024;

    return SectionContainer(
      backgroundColor: AppColors.lightBg,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1400),
        padding: EdgeInsets.symmetric(
          horizontal: isSmall ? 20 : (isMedium ? 40 : 80),
          vertical: isSmall ? 60 : 100,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.white,
              AppColors.lightBg,
              AppColors.white,
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: Column(
          children: [
            // Badge "Notre Histoire"
            _buildBadge(isSmall),
            SizedBox(height: isSmall ? 24 : 32),

            // Titre avec gradient text
            _buildGradientTitle(context, isSmall),
            SizedBox(height: isSmall ? 16 : 24),

            // Description principale
            _buildDescription(context, isSmall, isMedium),
            SizedBox(height: isSmall ? 40 : 60),

            // Timeline
            _buildTimeline(context, isSmall, isMedium),
            SizedBox(height: isSmall ? 40 : 60),

            // Valeurs clés avec cartes
            _buildValueCards(context, isSmall, isMedium),
          ],
        ),
      ),
    );
  }

  // Badge "Notre Histoire"
  Widget _buildBadge(bool isSmall) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 16 : 24,
        vertical: isSmall ? 8 : 12,
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
          Icon(
            Icons.auto_stories_outlined,
            color: AppColors.primary,
            size: isSmall ? 16 : 20,
          ),
          SizedBox(width: isSmall ? 6 : 8),
          Text(
            'NOTRE HISTOIRE',
            style: TextStyle(
              fontSize: isSmall ? 11 : 13,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  // Titre avec gradient text
  Widget _buildGradientTitle(BuildContext context, bool isSmall) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [
          AppColors.primary,
          AppColors.secondary,
        ],
      ).createShader(bounds),
      child: Text(
        'Une expertise scientifique au service des familles',
        textAlign: TextAlign.center,
        style: (isSmall
                ? AppTextStyles.headlineMedium(context)
                : AppTextStyles.displayMedium(context))
            .copyWith(
          color: AppColors.white,
          height: 1.3,
        ),
      ),
    );
  }

  // Description principale
  Widget _buildDescription(BuildContext context, bool isSmall, bool isMedium) {
    return Container(
      constraints: BoxConstraints(maxWidth: isMedium ? 700 : 900),
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

  // Timeline
  Widget _buildTimeline(BuildContext context, bool isSmall, bool isMedium) {
    return Container(
      constraints: BoxConstraints(maxWidth: isMedium ? 600 : 800),
      child: Row(
        children: [
          _buildTimelinePoint('Mars 2022', 'Création de\nNASCENTIA', isSmall),
          Expanded(
            child: Container(
              height: 2,
              margin: EdgeInsets.symmetric(horizontal: isSmall ? 12 : 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.secondary,
                  ],
                ),
              ),
            ),
          ),
          _buildTimelinePoint('Aujourd\'hui', '10,000+\nFamilles', isSmall),
        ],
      ),
    );
  }

  Widget _buildTimelinePoint(String date, String label, bool isSmall) {
    return Column(
      children: [
        Container(
          width: isSmall ? 16 : 20,
          height: isSmall ? 16 : 20,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.secondary],
            ),
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
        SizedBox(height: isSmall ? 12 : 16),
        Text(
          date,
          style: TextStyle(
            fontSize: isSmall ? 13 : 15,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: isSmall ? 4 : 6),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isSmall ? 11 : 13,
            color: AppColors.greyText,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  // Cartes de valeurs avec hover
  Widget _buildValueCards(BuildContext context, bool isSmall, bool isMedium) {
    final values = [
      {
        'icon': Icons.verified_outlined,
        'title': 'Fiabilité',
        'description': 'Méthode scientifiquement validée avec 95% de précision',
      },
      {
        'icon': Icons.favorite_outline,
        'title': 'Éthique',
        'description':
            'Respect des valeurs familiales et accompagnement responsable',
      },
      {
        'icon': Icons.lightbulb_outline,
        'title': 'Innovation',
        'description':
            'Technologie de pointe au service de la santé reproductive',
      },
    ];

    if (isSmall || isMedium) {
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
                    isSmall,
                    isMedium,
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
                    isSmall,
                    isMedium,
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
    bool isSmall,
    bool isMedium,
  ) {
    final isHovered = _hoveredValueIndex == index;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredValueIndex = index),
      onExit: (_) => setState(() => _hoveredValueIndex = -1),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: isHovered
              ? LinearGradient(
                  colors: [
                    AppColors.purple,
                    AppColors.primary,
                    AppColors.secondary,
                    AppColors.purple,
                  ],
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
        transform: Matrix4.identity()..translate(0.0, isHovered ? -6.0 : 0.0),
        child: Container(
          padding: EdgeInsets.all(isSmall ? 24 : 32),
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
              // Icône avec gradient
              Container(
                width: isSmall ? 56 : 64,
                height: isSmall ? 56 : 64,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.1),
                      AppColors.secondary.withValues(alpha: 0.1),
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: isSmall ? 28 : 32,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: isSmall ? 16 : 20),

              // Titre
              Text(
                title,
                style: AppTextStyles.headlineSmall(context).copyWith(
                  color: AppColors.darkText,
                ),
              ),
              SizedBox(height: isSmall ? 8 : 12),

              // Description
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
