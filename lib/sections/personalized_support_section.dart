import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_constants.dart';
import '../theme/app_text_styles.dart';

/// Section 2 - Expertise & Crédibilité NASCENTIA
class PersonalizedSupportSection extends StatefulWidget {
  const PersonalizedSupportSection({Key? key}) : super(key: key);

  @override
  State<PersonalizedSupportSection> createState() =>
      _PersonalizedSupportSectionState();
}

class _PersonalizedSupportSectionState
    extends State<PersonalizedSupportSection> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 1024;
    final isMobile = size.width < 768; // R4 — breakpoint unifié

    // R8 — Center wrapper pour centrer sur les grands écrans
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        margin: EdgeInsets.symmetric(
          horizontal: isMobile ? AppConstants.spacing20 : AppConstants.spacing40,
          vertical: isMobile ? AppConstants.spacing40 : 60,
        ),
        child: ClipRRect(
          borderRadius: AppConstants.borderRadiusXLarge,
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, AppColors.lightBg, Colors.white],
                stops: [0.0, 0.5, 1.0],
              ),
              borderRadius: AppConstants.borderRadiusXLarge,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(
              horizontal: isMobile
                  ? AppConstants.spacing32
                  : (size.width < 1024
                      ? AppConstants.spacing48
                      : AppConstants.spacing64),
              vertical:
                  isMobile ? AppConstants.spacing40 : AppConstants.spacing48,
            ),
            child: isMobile
                ? _buildMobileLayout(context)
                : _buildDesktopLayout(context, isDesktop),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, bool isDesktop) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 6, child: _buildTextContent(context, false)),
        const SizedBox(width: 60),
        Expanded(flex: 4, child: _buildPhoneMockup(isDesktop)),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildTextContent(context, true),
        const SizedBox(height: 40),
        _buildPhoneMockup(false),
      ],
    );
  }

  Widget _buildTextContent(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.verified, color: AppColors.white, size: 16),
              const SizedBox(width: 6),
              Text(
                'EXPERTISE SCIENTIFIQUE',
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

        Column(
          crossAxisAlignment:
              isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            Text(
              'Une méthode',
              style: AppTextStyles.headlineLarge(context)
                  .copyWith(fontWeight: FontWeight.w900),
              textAlign: isMobile ? TextAlign.center : TextAlign.left,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'scientifique validée',
                  style: AppTextStyles.headlineLarge(context).copyWith(
                    foreground: Paint()
                      ..shader = AppColors.primaryGradient.createShader(
                        const Rect.fromLTWH(0, 0, 400, 100),
                      ),
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: isMobile ? TextAlign.center : TextAlign.left,
                ),
                const SizedBox(width: 12),
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.auto_awesome,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 24),

        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 550),
          child: Text(
            'NASCENTIA utilise un algorithme scientifique testé en clinique '
            'pour vous accompagner dans la détermination et la planification du sexe de votre enfant. '
            'Une approche rigoureuse, éthique et fiable pour toute la famille.',
            style: AppTextStyles.bodyLarge(context).copyWith(
              color: AppColors.greyText,
              fontSize: isMobile ? 16 : 17,
            ),
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
          ),
        ),

        const SizedBox(height: 32),

        // R1 — Statistiques unifiées à 90 %
        Wrap(
          spacing: isMobile ? 16 : 24,
          runSpacing: 16,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            _buildStatBadge(
                context, Icons.science_outlined, '90%', 'Fiabilité', isMobile),
            _buildStatBadge(
                context, Icons.verified_user_outlined, '10k+', 'Familles', isMobile),
            _buildStatBadge(
                context, Icons.star_outline, '4.8/5', 'Satisfaction', isMobile),
          ],
        ),
      ],
    );
  }

  Widget _buildStatBadge(
    BuildContext context,
    IconData icon,
    String value,
    String label,
    bool isMobile,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 20,
        vertical: isMobile ? 12 : 14,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.15),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.primary, size: isMobile ? 20 : 24),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: isMobile ? 16 : 18,
                  fontWeight: FontWeight.w900,
                  color: AppColors.darkText,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: isMobile ? 11 : 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.greyText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneMockup(bool isDesktop) {
    return Center(
      child: Container(
        height: isDesktop ? 420 : 360,
        constraints: const BoxConstraints(maxWidth: 240),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 20,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Image.asset(
            'lib/assets/images/image_section1.png',
            fit: BoxFit.cover,
            cacheWidth: 800,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.lightCream,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Center(
                  child: Icon(
                    Icons.phone_iphone,
                    size: 60,
                    color: AppColors.primaryPink,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
