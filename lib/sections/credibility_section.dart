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
  int _hoveredLogoIndex = -1;

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
        'value': '+13 ans',
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
    const logos = [
      (
        path: 'lib/assets/images/Logo_DEPPS.jpeg',
        name: 'DEPPS',
        fullName: 'Direction des Établissements Privés\net Professions Sanitaires',
      ),
      (
        path: 'lib/assets/images/Logo_OIPI.png',
        name: 'OIPI',
        fullName: 'Organisation Ivoirienne\nde la Propriété Intellectuelle',
      ),
      (
        path: 'lib/assets/images/Logo_ONMCI.jpg',
        name: 'ONMCI',
        fullName: 'Ordre National\ndes Médecins de Côte d\'Ivoire',
      ),
      (
        path: 'lib/assets/images/Logo_UNAMEPCI.jpeg',
        name: 'UNAMEPCI',
        fullName: 'Union Nationale des Médecins\nPrivés de Côte d\'Ivoire',
      ),
    ];

    const validatedGreen = Color(0xFF16A34A);

    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 40),
      decoration: BoxDecoration(
        color: AppColors.purple.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.purple.withValues(alpha: 0.12),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // En-tête — texte en vert
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.verified_rounded,
                  color: validatedGreen, size: isMobile ? 18 : 22),
              SizedBox(width: isMobile ? 8 : 10),
              Text(
                'VALIDÉ PAR CES INSTITUTIONS',
                style: TextStyle(
                  fontSize: isMobile ? 11 : 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.3,
                  color: validatedGreen,
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 8 : 12),
          Text(
            'Ces organismes ont étudié et approuvé notre approche scientifique',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall(context).copyWith(
              color: AppColors.greyText,
              fontSize: isMobile ? 13 : 14,
            ),
          ),
          SizedBox(height: isMobile ? 28 : 36),

          // Grille des logos avec nom complet
          Wrap(
            spacing: isMobile ? 16 : 24,
            runSpacing: isMobile ? 20 : 28,
            alignment: WrapAlignment.center,
            children: logos.asMap().entries.map((entry) {
              final i = entry.key;
              final logo = entry.value;
              final isHovered = _hoveredLogoIndex == i;

              return MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: (_) => setState(() => _hoveredLogoIndex = i),
                onExit: (_) => setState(() => _hoveredLogoIndex = -1),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOutCubic,
                  transform: Matrix4.translationValues(
                      0.0, isHovered ? -6.0 : 0.0, 0.0),
                  width: isMobile ? 140 : 170,
                  child: Column(
                    children: [
                      // Carte logo
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeOutCubic,
                        width: isMobile ? 140 : 170,
                        height: isMobile ? 90 : 110,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: isHovered
                                  ? AppColors.purple.withValues(alpha: 0.18)
                                  : Colors.black.withValues(alpha: 0.07),
                              blurRadius: isHovered ? 20 : 10,
                              offset: Offset(0, isHovered ? 8 : 3),
                            ),
                          ],
                          border: Border.all(
                            color: isHovered
                                ? AppColors.purple.withValues(alpha: 0.30)
                                : AppColors.greyLight.withValues(alpha: 0.15),
                            width: 1.5,
                          ),
                        ),
                        padding: const EdgeInsets.all(14),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            logo.path,
                            fit: BoxFit.contain,
                            cacheWidth: 200,
                            errorBuilder: (_, __, ___) => Center(
                              child: Text(
                                logo.name,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.purple,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Sigle en gras
                      Text(
                        logo.name,
                        style: TextStyle(
                          fontSize: isMobile ? 12 : 13,
                          fontWeight: FontWeight.w800,
                          color: AppColors.purple,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      // Nom complet
                      Text(
                        logo.fullName,
                        style: TextStyle(
                          fontSize: isMobile ? 10 : 11,
                          fontWeight: FontWeight.w400,
                          color: AppColors.greyText,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
