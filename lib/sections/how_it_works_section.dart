import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_constants.dart';
import '../widgets/section_container.dart';

/// Section "Comment ça marche" - Design Premium
class HowItWorksSection extends StatefulWidget {
  const HowItWorksSection({Key? key}) : super(key: key);

  @override
  State<HowItWorksSection> createState() => _HowItWorksSectionState();
}

class _HowItWorksSectionState extends State<HowItWorksSection> {
  int? _hoveredStep;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < 900;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.purple,
            AppColors.purple.withValues(alpha: 0.95),
            AppColors.primary.withValues(alpha: 0.8),
          ],
        ),
      ),
      child: SectionContainer(
        backgroundColor: Colors.transparent,
        child: Column(
          children: [
            // Badge "Comment ça marche"
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.white.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Text(
                '🚀 COMMENT ÇA MARCHE',
                style: AppTextStyles.labelLarge(context).copyWith(
                  fontSize: 14,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Titre principal
            Text(
              'Seulement 4 étapes',
              style: AppTextStyles.displayMedium(context).copyWith(
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // Sous-titre
            Text(
              'Simple, rapide et efficace pour toute la famille',
              style: AppTextStyles.bodyLarge(context).copyWith(
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 60),
            if (isSmall)
              Column(
                children: [
                  _buildStepCard(
                    context,
                    0,
                    '1',
                    'Téléchargez',
                    'Installez NASCENTIA gratuitement sur iOS ou Android en moins de 30 secondes.',
                    Icons.download_rounded,
                    AppColors.primary,
                    isSmall,
                  ),
                  const SizedBox(height: 24),
                  _buildStepCard(
                    context,
                    1,
                    '2',
                    'Créez votre profil',
                    'Renseignez vos informations personnelles de manière sécurisée et confidentielle.',
                    Icons.person_add_rounded,
                    AppColors.secondary,
                    isSmall,
                  ),
                  const SizedBox(height: 24),
                  _buildStepCard(
                    context,
                    2,
                    '3',
                    'Définissez votre objectif',
                    'Choisissez entre détermination du sexe ou planification selon votre situation.',
                    Icons.flag_rounded,
                    AppColors.accent,
                    isSmall,
                  ),
                  const SizedBox(height: 24),
                  _buildStepCard(
                    context,
                    3,
                    '4',
                    'Accédez aux résultats',
                    'Recevez vos recommandations personnalisées basées sur notre algorithme validé.',
                    Icons.check_circle_rounded,
                    AppColors.successGreen,
                    isSmall,
                  ),
                ],
              )
            else
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildStepCard(
                          context,
                          0,
                          '1',
                          'Téléchargez',
                          'Installez NASCENTIA gratuitement sur iOS ou Android en moins de 30 secondes.',
                          Icons.download_rounded,
                          AppColors.primary,
                          isSmall,
                        ),
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child: _buildStepCard(
                          context,
                          1,
                          '2',
                          'Créez votre profil',
                          'Renseignez vos informations personnelles de manière sécurisée et confidentielle.',
                          Icons.person_add_rounded,
                          AppColors.secondary,
                          isSmall,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildStepCard(
                          context,
                          2,
                          '3',
                          'Définissez votre objectif',
                          'Choisissez entre détermination du sexe ou planification selon votre situation.',
                          Icons.flag_rounded,
                          AppColors.accent,
                          isSmall,
                        ),
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child: _buildStepCard(
                          context,
                          3,
                          '4',
                          'Accédez aux résultats',
                          'Recevez vos recommandations personnalisées basées sur notre algorithme validé.',
                          Icons.check_circle_rounded,
                          AppColors.successGreen,
                          isSmall,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepCard(
    BuildContext context,
    int index,
    String number,
    String title,
    String description,
    IconData icon,
    Color accentColor,
    bool isSmall,
  ) {
    final isHovered = _hoveredStep == index;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredStep = index),
      onExit: (_) => setState(() => _hoveredStep = null),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        transform: Matrix4.identity()..scale(isHovered ? 1.02 : 1.0),
        padding: EdgeInsets.all(isSmall ? 32 : 40),
        decoration: BoxDecoration(
          // Glassmorphism effect
          color: AppColors.white.withValues(alpha: isHovered ? 0.18 : 0.12),
          borderRadius: AppConstants.borderRadiusXLarge,
          border: Border.all(
            color: AppColors.white.withValues(alpha: isHovered ? 0.4 : 0.25),
            width: 1.5,
          ),
          boxShadow: isHovered
              ? [
                  BoxShadow(
                    color: accentColor.withValues(alpha: 0.2),
                    blurRadius: 25,
                    offset: const Offset(0, 10),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Badge numéro avec effet néon
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: isSmall ? 56 : 64,
                  height: isSmall ? 56 : 64,
                  decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: isHovered
                        ? [
                            BoxShadow(
                              color: accentColor.withValues(alpha: 0.5),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ]
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      number,
                      style: TextStyle(
                        fontSize: isSmall ? 24 : 28,
                        fontWeight: FontWeight.w900,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                // Icône flottante
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.white
                        .withValues(alpha: isHovered ? 0.25 : 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: AppColors.white,
                    size: isSmall ? 24 : 28,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppConstants.spacing32),
            // Titre
            Text(
              title,
              style: AppTextStyles.titleLarge(context).copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w900,
                fontSize: isSmall ? 22 : 26,
              ),
            ),
            const SizedBox(height: 12),
            // Description
            Text(
              description,
              style: AppTextStyles.bodyLarge(context).copyWith(
                fontSize: isSmall ? 15 : 16,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
