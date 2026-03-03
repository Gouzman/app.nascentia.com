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
    final isMobile = screenWidth < 768; // R4 — breakpoint unifié

    // R5 — SectionContainer gère le padding ; plus de Container dupliqué
    return SectionContainer(
      backgroundColor: AppColors.lightBg,
      child: Column(
        children: [
          _buildBadge(isMobile),
          SizedBox(height: isMobile ? 24 : 32),
          _buildTitle(context, isMobile),
          SizedBox(height: isMobile ? 16 : 24),
          _buildDescription(context, isMobile),
          SizedBox(height: isMobile ? 40 : 60),
          _buildStatsBadges(context, isMobile),
          SizedBox(height: isMobile ? 40 : 60),
          _buildPartnership(context, isMobile),
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
          Icon(Icons.verified_user_outlined,
              color: AppColors.purple, size: isMobile ? 16 : 20),
          SizedBox(width: isMobile ? 6 : 8),
          Text(
            'VALIDATION SCIENTIFIQUE',
            style: TextStyle(
              fontSize: isMobile ? 11 : 13,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: AppColors.purple,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context, bool isMobile) {
    return Text(
      'Un modèle mathématique testé et validé',
      textAlign: TextAlign.center,
      style: (isMobile
              ? AppTextStyles.headlineMedium(context)
              : AppTextStyles.displayMedium(context))
          .copyWith(color: AppColors.purple, height: 1.3),
    );
  }

  Widget _buildDescription(BuildContext context, bool isMobile) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: isMobile ? 600 : 800),
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

  Widget _buildStatsBadges(BuildContext context, bool isMobile) {
    final stats = [
      {
        'icon': Icons.analytics_outlined,
        'value': '90 %', // R1 — unifié à 90 %
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

    if (isMobile) {
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
                    isMobile,
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
                    isMobile,
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
    bool isMobile,
  ) {
    final isHovered = _hoveredStatIndex == index;

    // R10 — Gradient hover adouci : 2 couleurs
    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredStatIndex = index),
      onExit: (_) => setState(() => _hoveredStatIndex = -1),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: isHovered
              ? const LinearGradient(
                  colors: [AppColors.purple, AppColors.primary],
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
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : 32,
            vertical: isMobile ? 32 : 40,
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
              Container(
                width: isMobile ? 56 : 64,
                height: isMobile ? 56 : 64,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.purple.withValues(alpha: 0.1),
                      AppColors.primary.withValues(alpha: 0.1),
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon,
                    size: isMobile ? 28 : 32, color: AppColors.purple),
              ),
              SizedBox(height: isMobile ? 16 : 20),
              Text(
                value,
                style: AppTextStyles.displayMedium(context).copyWith(
                  color: AppColors.purple,
                  fontSize: isMobile ? 36 : 48,
                ),
              ),
              SizedBox(height: isMobile ? 8 : 12),
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

  Widget _buildPartnership(BuildContext context, bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 32),
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
              Icon(Icons.handshake_outlined,
                  color: AppColors.purple, size: isMobile ? 20 : 24),
              SizedBox(width: isMobile ? 8 : 12),
              Text(
                'PARTENARIAT OFFICIEL',
                style: TextStyle(
                  fontSize: isMobile ? 12 : 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                  color: AppColors.purple,
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 12 : 16),
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
