import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/section_container.dart';

/// Section "Crédibilité Scientifique"
class CredibilitySection extends StatefulWidget {
  const CredibilitySection({Key? key}) : super(key: key);

  @override
  State<CredibilitySection> createState() => _CredibilitySectionState();
}

class _CredibilitySectionState extends State<CredibilitySection> {
  int _hoveredStatIndex = -1;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < 600;
    final isMedium = screenWidth >= 600 && screenWidth < 1024;

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
            // Badge "Validation Scientifique"
            _buildBadge(isSmall),
            SizedBox(height: isSmall ? 24 : 32),

            // Titre avec gradient text
            _buildGradientTitle(context, isSmall),
            SizedBox(height: isSmall ? 16 : 24),

            // Description
            _buildDescription(context, isSmall, isMedium),
            SizedBox(height: isSmall ? 40 : 60),

            // Stats badges
            _buildStatsBadges(context, isSmall, isMedium),
            SizedBox(height: isSmall ? 40 : 60),

            // Partenariat
            _buildPartnership(context, isSmall),
          ],
        ),
      ),
    );
  }

  // Badge "Validation Scientifique"
  Widget _buildBadge(bool isSmall) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 16 : 24,
        vertical: isSmall ? 8 : 12,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.purple.withValues(alpha: 0.1),
            AppColors.primary.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: AppColors.purple.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.verified_user_outlined,
            color: AppColors.purple,
            size: isSmall ? 16 : 20,
          ),
          SizedBox(width: isSmall ? 6 : 8),
          Text(
            'VALIDATION SCIENTIFIQUE',
            style: TextStyle(
              fontSize: isSmall ? 11 : 13,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: AppColors.purple,
            ),
          ),
        ],
      ),
    );
  }

  // Titre avec couleur unique
  Widget _buildGradientTitle(BuildContext context, bool isSmall) {
    return Text(
      'Un modèle mathématique testé et validé',
      textAlign: TextAlign.center,
      style: (isSmall
              ? AppTextStyles.headlineMedium(context)
              : AppTextStyles.displayMedium(context))
          .copyWith(
        color: AppColors.purple,
        height: 1.3,
      ),
    );
  }

  // Description
  Widget _buildDescription(BuildContext context, bool isSmall, bool isMedium) {
    return Container(
      constraints: BoxConstraints(maxWidth: isMedium ? 700 : 900),
      child: Text(
        'Le modèle NASCENTIA est le fruit de plusieurs années de recherches menées avec '
        'des professionnels de santé et des experts scientifiques. Notre approche combine '
        'rigueur mathématique et validation clinique pour garantir des résultats fiables.',
        textAlign: TextAlign.center,
        style: AppTextStyles.bodyLarge(context).copyWith(
          color: AppColors.greyText,
          height: 1.8,
        ),
      ),
    );
  }

  // Stats badges
  Widget _buildStatsBadges(BuildContext context, bool isSmall, bool isMedium) {
    final stats = [
      {
        'icon': Icons.analytics_outlined,
        'value': '90%',
        'label': 'Taux de\nFiabilité',
      },
      {
        'icon': Icons.science_outlined,
        'value': '+5 ans',
        'label': 'Recherche &\nDéveloppement',
      },
      {
        'icon': Icons.verified_outlined,
        'value': 'Validé',
        'label': 'Études\nCliniques',
      },
    ];

    if (isSmall || isMedium) {
      return Column(
        children: stats
            .asMap()
            .entries
            .map((entry) => Padding(
                  padding: EdgeInsets.only(
                    bottom: entry.key < stats.length - 1 ? 20 : 0,
                  ),
                  child: _buildStatCard(
                    entry.value['icon'] as IconData,
                    entry.value['value'] as String,
                    entry.value['label'] as String,
                    entry.key,
                    isSmall,
                  ),
                ))
            .toList(),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: stats
          .asMap()
          .entries
          .map((entry) => Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: entry.key == 1 ? 16 : 8,
                  ),
                  child: _buildStatCard(
                    entry.value['icon'] as IconData,
                    entry.value['value'] as String,
                    entry.value['label'] as String,
                    entry.key,
                    isSmall,
                  ),
                ),
              ))
          .toList(),
    );
  }

  Widget _buildStatCard(
    IconData icon,
    String value,
    String label,
    int index,
    bool isSmall,
  ) {
    final isHovered = _hoveredStatIndex == index;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredStatIndex = index),
      onExit: (_) => setState(() => _hoveredStatIndex = -1),
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
          padding: EdgeInsets.symmetric(
            horizontal: isSmall ? 20 : 32,
            vertical: isSmall ? 32 : 40,
          ),
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
              // Icône
              Container(
                width: isSmall ? 56 : 64,
                height: isSmall ? 56 : 64,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.purple.withValues(alpha: 0.1),
                      AppColors.primary.withValues(alpha: 0.1),
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: isSmall ? 28 : 32,
                  color: AppColors.purple,
                ),
              ),
              SizedBox(height: isSmall ? 16 : 20),

              // Valeur
              Text(
                value,
                style: AppTextStyles.displayMedium(context).copyWith(
                  color: AppColors.purple,
                  fontSize: isSmall ? 36 : 48,
                ),
              ),
              SizedBox(height: isSmall ? 8 : 12),

              // Label
              Text(
                label,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium(context).copyWith(
                  color: AppColors.greyText,
                  height: 1.4,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Partenariat
  Widget _buildPartnership(BuildContext context, bool isSmall) {
    return Container(
      padding: EdgeInsets.all(isSmall ? 24 : 32),
      decoration: BoxDecoration(
        color: AppColors.purple.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.purple.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.handshake_outlined,
                color: AppColors.purple,
                size: isSmall ? 20 : 24,
              ),
              SizedBox(width: isSmall ? 8 : 12),
              Text(
                'PARTENARIAT OFFICIEL',
                style: TextStyle(
                  fontSize: isSmall ? 12 : 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                  color: AppColors.purple,
                ),
              ),
            ],
          ),
          SizedBox(height: isSmall ? 12 : 16),
          Text(
            'Syndicat National des Médecins Privés de Côte d\'Ivoire',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium(context).copyWith(
              color: AppColors.greyText,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
