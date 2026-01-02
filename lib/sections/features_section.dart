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
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;

    return SectionContainer(
      backgroundColor: AppColors.lightBg,
      child: Column(
        children: [
          // Titre section
          Text(
            'Fonctionnalités clés',
            style: AppTextStyles.headlineLarge(context).copyWith(
              fontWeight: FontWeight.w900,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          // Sous-titre
          Text(
            'Tout ce dont vous avez besoin pour planifier sereinement',
            style: AppTextStyles.bodyLarge(context).copyWith(
              color: AppColors.greyText,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
          if (isSmall)
            Column(
              children: [
                _buildFeatureCard(
                  context,
                  0,
                  'Détermination du sexe',
                  'Identifiez le sexe du bébé dès la conception avec une méthode scientifique validée.',
                  Icons.baby_changing_station,
                  isTablet,
                ),
                const SizedBox(height: 30),
                _buildFeatureCard(
                  context,
                  1,
                  'Planification du sexe',
                  'Utilisez un calendrier intelligent pour maximiser vos chances selon vos objectifs familiaux.',
                  Icons.event_available,
                  isTablet,
                ),
                const SizedBox(height: 30),
                _buildFeatureCard(
                  context,
                  2,
                  'Suivi personnalisé',
                  'Recevez des recommandations adaptées basées sur vos données et votre cycle.',
                  Icons.insights,
                  isTablet,
                ),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildFeatureCard(
                    context,
                    0,
                    'Détermination du sexe',
                    'Identifiez le sexe du bébé dès la conception avec une méthode scientifique validée.',
                    Icons.baby_changing_station,
                    isTablet,
                  ),
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: _buildFeatureCard(
                    context,
                    1,
                    'Planification du sexe',
                    'Utilisez un calendrier intelligent pour maximiser vos chances selon vos objectifs familiaux.',
                    Icons.event_available,
                    isTablet,
                  ),
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: _buildFeatureCard(
                    context,
                    2,
                    'Suivi personnalisé',
                    'Recevez des recommandations adaptées basées sur vos données et votre cycle.',
                    Icons.insights,
                    isTablet,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    int index,
    String title,
    String description,
    IconData icon,
    bool isTablet,
  ) {
    final isHovered = _hoveredCard == index;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredCard = index),
      onExit: (_) => setState(() => _hoveredCard = null),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        transform: Matrix4.identity()
          ..translate(0.0, isHovered ? -8.0 : 0.0), // Lift effect
        padding: EdgeInsets.all(
          isMobile ? AppConstants.spacing32 : AppConstants.spacing48,
        ),
        decoration: BoxDecoration(
          gradient:
              AppColors.primaryGradient, // Gradient rose au lieu de rose clair
          borderRadius: AppConstants.borderRadiusXLarge,
          boxShadow: isHovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 30,
                    offset: const Offset(0, 15),
                  ),
                ]
              : AppConstants.shadowLarge,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icône avec animation
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: EdgeInsets.all(AppConstants.spacing20),
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: isHovered ? 0.3 : 0.2),
                borderRadius: AppConstants.borderRadiusLarge,
              ),
              child: Icon(
                icon,
                size: isMobile ? 40 : 48,
                color: AppColors.white,
              ),
            ),
            SizedBox(height: AppConstants.spacing32),
            // Titre
            Text(
              title,
              style: AppTextStyles.headlineSmall(context).copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 16),
            // Description
            Text(
              description,
              style: AppTextStyles.bodyLarge(context).copyWith(
                fontSize: isMobile ? 15 : 17,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
