import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_constants.dart';
import '../theme/app_text_styles.dart';

/// Section NASCENTIA TV — Podcast officiel de la marque
class PodcastSection extends StatefulWidget {
  const PodcastSection({Key? key}) : super(key: key);

  @override
  State<PodcastSection> createState() => _PodcastSectionState();
}

class _PodcastSectionState extends State<PodcastSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _outerAnim;
  late Animation<double> _middleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400), // Réduit de 2200ms pour fluidité
      vsync: this,
    )..repeat(reverse: true);

    _outerAnim = Tween<double>(begin: 0.92, end: 1.08).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _middleAnim = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF140826),
            Color(0xFF2A0D52),
            Color(0xFF3D1060),
          ],
          stops: [0.0, 0.55, 1.0],
        ),
      ),
      child: Stack(
        children: [
          // Orbes décoratifs statiques
          Positioned(
            top: -60,
            right: -40,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final size = MediaQuery.of(context).size;
                final orbSize = size.width < 600 ? size.width * 0.6 : 300.0;
                return Container(
                  width: orbSize,
                  height: orbSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.primary.withValues(alpha: 0.12),
                        AppColors.primary.withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: -80,
            left: -60,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final size = MediaQuery.of(context).size;
                final orbSize = size.width < 600 ? size.width * 0.7 : 350.0;
                return Container(
                  width: orbSize,
                  height: orbSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.purple.withValues(alpha: 0.20),
                        AppColors.purple.withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Contenu principal
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile
                      ? AppConstants.spacing24
                      : AppConstants.spacing64,
                  vertical: isMobile
                      ? AppConstants.spacing48
                      : AppConstants.spacing80,
                ),
                child: isMobile
                    ? _buildMobileLayout(context)
                    : _buildDesktopLayout(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 6, child: _buildTextContent(context, false)),
        const SizedBox(width: 80),
        Expanded(flex: 4, child: _buildVisual()),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildTextContent(context, true),
        const SizedBox(height: 48),
        _buildVisual(),
      ],
    );
  }

  Widget _buildTextContent(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.45),
                blurRadius: 18,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.podcasts_rounded, color: Colors.white, size: 14),
              const SizedBox(width: 7),
              Text(
                'PODCAST OFFICIEL',
                style: AppTextStyles.labelSmall(context).copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.3,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 28),

        // Titre
        ShaderMask(
          shaderCallback: (rect) => const LinearGradient(
            colors: [Colors.white, Color(0xFFFCADA3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(rect),
          child: Text(
            'NASCENTIA TV',
            style: AppTextStyles.headlineLarge(context).copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: isMobile ? 40 : 58,
              letterSpacing: -1.2,
              height: 1.0,
            ),
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          'Votre santé féminine, enfin à voix haute',
          style: AppTextStyles.titleMedium(context).copyWith(
            color: AppColors.accent.withValues(alpha: 0.85),
            fontWeight: FontWeight.w500,
            fontSize: isMobile ? 17 : 21,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ),

        const SizedBox(height: 24),

        // Description
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 540),
          child: Text(
            'Chaque épisode, des experts bienveillants vous accompagnent sur les '
            'sujets qui vous touchent vraiment — hormones, fertilité, maternité, '
            'santé mentale, nutrition. Un espace de confiance, ancré dans la science, '
            'conçu pour toutes les femmes.',
            style: AppTextStyles.bodyMedium(context).copyWith(
              color: Colors.white.withValues(alpha: 0.68),
              height: 1.75,
              fontSize: isMobile ? 15 : 16,
            ),
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
          ),
        ),

        const SizedBox(height: 28),

        // Thématiques — texte uniquement
        Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: const [
            _TopicChip(label: 'Hormones'),
            _TopicChip(label: 'Fertilité'),
            _TopicChip(label: 'Maternité'),
            _TopicChip(label: 'Bien-être'),
            _TopicChip(label: 'Nutrition'),
            _TopicChip(label: 'Santé mentale'),
          ],
        ),

        const SizedBox(height: 40),

        // CTA — bouton unique
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 28 : 34,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(AppConstants.radiusPill),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.45),
                    blurRadius: 22,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.play_circle_filled_rounded,
                      color: Colors.white, size: 20),
                  const SizedBox(width: 10),
                  Text(
                    'Écouter maintenant',
                    style: AppTextStyles.labelLarge(context).copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVisual() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = MediaQuery.of(context).size;
        final visualSize = size.width < 600 ? size.width * 0.7 : 300.0;
        return Center(
          child: SizedBox(
            width: visualSize,
            height: visualSize,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    // Anneau externe — pulse lent
                    Transform.scale(
                      scale: _outerAnim.value,
                      child: Container(
                        width: 290,
                        height: 290,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary.withValues(alpha: 0.06),
                        ),
                      ),
                    ),
                    // Anneau intermédiaire — pulse légèrement décalé
                    Transform.scale(
                      scale: _middleAnim.value,
                      child: Container(
                        width: 215,
                        height: 215,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary.withValues(alpha: 0.11),
                        ),
                      ),
                    ),
                    // Cercle central statique avec micro
                    Container(
                      width: 148,
                      height: 148,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF5C1A88), Color(0xFF3D1060)],
                        ),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.55),
                          width: 2.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.40),
                            blurRadius: 36,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.mic_rounded,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}

/// Chip de thématique — texte uniquement
class _TopicChip extends StatelessWidget {
  final String label;

  const _TopicChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.14),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Colors.white70,
        ),
      ),
    );
  }
}
