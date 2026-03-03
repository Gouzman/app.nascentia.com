import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_constants.dart';
import '../widgets/section_container.dart';

/// Section "Fonctionnalités Clés"
class FeaturesSection extends StatefulWidget {
  const FeaturesSection({Key? key}) : super(key: key);

  @override
  State<FeaturesSection> createState() => _FeaturesSectionState();
}

class _FeaturesSectionState extends State<FeaturesSection> {
  int? _hoveredCard;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768; // R4

    return SectionContainer(
      backgroundColor: AppColors.lightBg,
      child: Column(
        children: [
          Text(
            'Fonctionnalités clés',
            style: AppTextStyles.headlineLarge(context),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Tout ce dont vous avez besoin pour planifier sereinement',
            style: AppTextStyles.bodyLarge(context)
                .copyWith(color: AppColors.greyText),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
          if (isMobile)
            Column(
              children: [
                _buildFeatureCard(context, 0, 'Détermination du sexe',
                    'Identifiez le sexe du bébé dès la conception avec une méthode scientifique validée.',
                    Icons.baby_changing_station),
                const SizedBox(height: 30),
                _buildFeatureCard(context, 1, 'Planification du sexe',
                    'Utilisez un calendrier intelligent pour maximiser vos chances selon vos objectifs familiaux.',
                    Icons.event_available),
                const SizedBox(height: 30),
                _buildFeatureCard(context, 2, 'Suivi personnalisé',
                    'Recevez des recommandations adaptées basées sur vos données et votre cycle.',
                    Icons.insights),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildFeatureCard(context, 0, 'Détermination du sexe',
                      'Identifiez le sexe du bébé dès la conception avec une méthode scientifique validée.',
                      Icons.baby_changing_station),
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: _buildFeatureCard(context, 1, 'Planification du sexe',
                      'Utilisez un calendrier intelligent pour maximiser vos chances selon vos objectifs familiaux.',
                      Icons.event_available),
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: _buildFeatureCard(context, 2, 'Suivi personnalisé',
                      'Recevez des recommandations adaptées basées sur vos données et votre cycle.',
                      Icons.insights),
                ),
              ],
            ),
        ],
      ),
    );
  }

  /// R7 — Cartes blanches avec icône colorée (plus légères visuellement)
  Widget _buildFeatureCard(
    BuildContext context,
    int index,
    String title,
    String description,
    IconData icon,
  ) {
    final isHovered = _hoveredCard == index;
    final isMobile = MediaQuery.of(context).size.width < 768;

    // Couleur d'accent unique par carte
    final accentColors = [AppColors.primary, AppColors.purple, AppColors.secondary];
    final accent = accentColors[index];

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredCard = index),
      onExit: (_) => setState(() => _hoveredCard = null),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0.0, isHovered ? -8.0 : 0.0, 0.0),
        padding: EdgeInsets.all(
          isMobile ? AppConstants.spacing32 : AppConstants.spacing40,
        ),
        decoration: BoxDecoration(
          // R7 — Fond blanc au repos, gradient léger au hover (fini les 3 blocs rose)
          color: AppColors.white,
          borderRadius: AppConstants.borderRadiusXLarge,
          border: Border.all(
            color: isHovered
                ? accent.withValues(alpha: 0.4)
                : AppColors.greyLight.withValues(alpha: 0.3),
            width: isHovered ? 1.5 : 1,
          ),
          boxShadow: isHovered
              ? [
                  BoxShadow(
                    color: accent.withValues(alpha: 0.2),
                    blurRadius: 30,
                    offset: const Offset(0, 15),
                  ),
                ]
              : AppConstants.shadowMedium,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icône avec couleur d'accent unique par carte
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: EdgeInsets.all(AppConstants.spacing20),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: isHovered ? 0.15 : 0.08),
                borderRadius: AppConstants.borderRadiusLarge,
              ),
              child: Icon(
                icon,
                size: isMobile ? 40 : 48,
                color: accent,
              ),
            ),
            SizedBox(height: AppConstants.spacing32),
            Text(
              title,
              style: AppTextStyles.headlineSmall(context).copyWith(
                color: AppColors.darkText,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: AppTextStyles.bodyMedium(context).copyWith(
                fontSize: isMobile ? 15 : 16,
                height: 1.7,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
