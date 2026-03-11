import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_constants.dart';
import '../theme/app_text_styles.dart';

/// Section "Problème & Solution" — angle simplicité et accessibilité
class FastOrderSection extends StatelessWidget {
  const FastOrderSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768; // R4 — breakpoint unifié
    final isTablet = size.width >= 768 && size.width < 1024;

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? AppConstants.spacing40 : AppConstants.spacing80,
        horizontal: isMobile ? AppConstants.spacing20 : AppConstants.spacing40,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: ClipRRect(
            borderRadius: AppConstants.borderRadiusXLarge,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.purple,
                    AppColors.purple.withValues(alpha: 0.92),
                    const Color(0xFF7B3AA0),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.purple.withValues(alpha: 0.3),
                    blurRadius: 40,
                    offset: const Offset(0, 20),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(
                horizontal:
                    isMobile ? AppConstants.spacing32 : AppConstants.spacing64,
                vertical:
                    isMobile ? AppConstants.spacing32 : AppConstants.spacing48,
              ),
              child: isMobile
                  ? _buildMobileLayout(context)
                  : _buildDesktopLayout(context, isTablet),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, bool isTablet) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(flex: 5, child: _buildImage(isTablet)),
        SizedBox(width: isTablet ? 40 : 60),
        Flexible(flex: 5, child: _buildTextContent(context)),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextContent(context),
        const SizedBox(height: 40),
        Center(child: _buildImage(false)),
      ],
    );
  }

  Widget _buildImage(bool isTablet) {
    final imageHeight = isTablet ? 380.0 : 420.0;

    return Center(
      child: Container(
        height: imageHeight,
        constraints: BoxConstraints(maxWidth: isTablet ? 320.0 : 360.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 40,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Image.asset(
            'assets/images/image_section2.png',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: const Center(
                  child: Icon(
                    Icons.phone_iphone,
                    size: 80,
                    color: AppColors.white,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  /// R13 — Focus sur simplicité et accessibilité (pas "méthode scientifique")
  Widget _buildTextContent(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.white.withValues(alpha: 0.3),
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.lightbulb_outline, color: AppColors.white, size: 16),
              const SizedBox(width: 6),
              Text(
                'NOTRE MISSION',
                style: AppTextStyles.labelSmall(context).copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // R13 — Titre axé sur le problème des familles, pas la répétition scientifique
        Text(
          'Des milliers de familles',
          style: AppTextStyles.displayMedium(context).copyWith(
            fontSize: isMobile ? 32 : 40,
            fontWeight: FontWeight.w900,
          ),
        ),
        Text(
          'méritent une réponse claire',
          style: AppTextStyles.displayMedium(context).copyWith(
            fontSize: isMobile ? 32 : 40,
            fontWeight: FontWeight.w900,
            shadows: [
              Shadow(
                color: Colors.black.withValues(alpha: 0.1),
                offset: const Offset(0, 2),
                blurRadius: 4,
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Text(
            'Des milliers de couples vivent avec incertitude et stress concernant '
            'le sexe de leur futur enfant. NASCENTIA apporte une réponse claire, '
            'disponible partout et protégée par une confidentialité totale.',
            style: AppTextStyles.bodyLarge(context).copyWith(
              fontSize: isMobile ? 15 : 17,
              height: 1.7,
            ),
          ),
        ),

        const SizedBox(height: 32),

        // R13 — Points clés : simplicité, accessibilité, confidentialité
        Wrap(
          spacing: 24,
          runSpacing: 16,
          children: [
            _buildFeaturePoint(Icons.speed, 'Résultat en quelques secondes'),
            _buildFeaturePoint(Icons.phone_android, 'iOS & Android'),
            _buildFeaturePoint(Icons.lock_outline, 'Données confidentielles'),
          ],
        ),
      ],
    );
  }

  Widget _buildFeaturePoint(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.white, size: 18),
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}
