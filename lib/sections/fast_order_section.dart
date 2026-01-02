import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_constants.dart';
import '../theme/app_text_styles.dart';

/// Section "Problème & Solution" - Design Premium
class FastOrderSection extends StatefulWidget {
  const FastOrderSection({Key? key}) : super(key: key);

  @override
  State<FastOrderSection> createState() => _FastOrderSectionState();
}

class _FastOrderSectionState extends State<FastOrderSection> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 768 && size.width < 1024;
    final isMobile = size.width < 768;

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
                    const Color(0xFF7B3AA0), // Violet plus clair
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

  /// Layout Desktop et Tablet
  Widget _buildDesktopLayout(BuildContext context, bool isTablet) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Mockups téléphones (gauche)
        Flexible(
          flex: 5,
          child: _buildPhoneMockups(isTablet),
        ),

        SizedBox(width: isTablet ? 40 : 60),

        // Texte (droite)
        Flexible(
          flex: 5,
          child: _buildTextContent(context),
        ),
      ],
    );
  }

  /// Layout Mobile
  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Texte en premier sur mobile
        _buildTextContent(context),

        const SizedBox(height: 40),

        // Mockups en dessous
        Center(child: _buildPhoneMockups(false)),
      ],
    );
  }

  /// Mockups téléphones (Stack de 2 téléphones superposés)
  Widget _buildPhoneMockups(bool isTablet) {
    final phoneHeight = isTablet ? 380.0 : 420.0;
    final phoneWidth = phoneHeight * 0.47; // Ratio typique téléphone

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
        transform: Matrix4.identity()..rotateY(_isHovered ? -0.05 : 0.0),
        height: phoneHeight,
        width: phoneWidth * 1.65,
        child: Stack(
          children: [
            // Téléphone arrière (gauche)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOut,
              left: _isHovered ? -10 : 0,
              top: _isHovered ? 30 : 25,
              child: _buildPhoneMockup(
                phoneWidth,
                phoneHeight,
                AppColors.lightBg,
              ),
            ),

            // Téléphone avant (droite)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOut,
              left: _isHovered ? phoneWidth * 0.75 : phoneWidth * 0.65,
              top: _isHovered ? -5 : 0,
              child: _buildPhoneMockup(
                phoneWidth,
                phoneHeight,
                Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Un mockup de téléphone individuel
  Widget _buildPhoneMockup(double width, double height, Color bgColor) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 30,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Column(
        children: [
          // Notch / barre du haut
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: width * 0.35,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Contenu factice du téléphone
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: bgColor == Colors.white
                    ? const Color(0xFFF5F5F5)
                    : Colors.white.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: width * 0.2,
                    color: AppColors.purple.withValues(alpha: 0.4),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: width * 0.6,
                    height: 3,
                    decoration: BoxDecoration(
                      color: AppColors.purple.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    width: width * 0.5,
                    height: 3,
                    decoration: BoxDecoration(
                      color: AppColors.purple.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Contenu texte (droite)
  Widget _buildTextContent(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Badge "Problème & Solution"
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
              const Icon(
                Icons.lightbulb_outline,
                color: AppColors.white,
                size: 16,
              ),
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

        // Titre impact
        Text(
          'Un besoin réel,',
          style: AppTextStyles.displayMedium(context).copyWith(
            fontSize: isMobile ? 32 : 40,
            fontWeight: FontWeight.w900,
          ),
        ),
        Text(
          'une solution scientifique',
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

        // Description enrichie
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Text(
            'Des milliers de couples vivent avec incertitude et stress concernant '
            'le sexe de leur futur enfant. NASCENTIA apporte une réponse claire et scientifique, '
            'basée sur un algorithme fiable validé en clinique.',
            style: AppTextStyles.bodyLarge(context).copyWith(
              fontSize: isMobile ? 15 : 17,
              height: 1.7,
            ),
          ),
        ),

        const SizedBox(height: 32),

        // Points clés avec icônes
        Wrap(
          spacing: 24,
          runSpacing: 16,
          children: [
            _buildFeaturePoint(
              Icons.psychology_outlined,
              'Méthode scientifique',
            ),
            _buildFeaturePoint(
              Icons.verified_user_outlined,
              'Testé en clinique',
            ),
            _buildFeaturePoint(
              Icons.favorite_outline,
              'Approche éthique',
            ),
          ],
        ),
      ],
    );
  }

  /// Point clé avec icône
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
          child: Icon(
            icon,
            color: AppColors.white,
            size: 18,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppColors.white.withValues(alpha: 0.95),
          ),
        ),
      ],
    );
  }
}
