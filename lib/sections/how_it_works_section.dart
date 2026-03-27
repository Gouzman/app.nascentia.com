import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/section_container.dart';

class _StepData {
  final String number;
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const _StepData({
    required this.number,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}

const List<_StepData> _steps = [
  _StepData(
    number: '1',
    title: 'Téléchargez',
    description:
        'Installez NASCENTIA gratuitement sur iOS ou Android en moins de 30 secondes.',
    icon: Icons.download_rounded,
    color: AppColors.primary,
  ),
  _StepData(
    number: '2',
    title: 'Autorisez les sources inconnues',
    description:
        'Pour installer NASCENTIA sur Android en dehors du Play Store, activez l\u2019option "Sources inconnues" dans les param\u00e8tres de s\u00e9curit\u00e9 de votre t\u00e9l\u00e9phone.',
    icon: Icons.security_rounded,
    color: AppColors.warningOrange,
  ),
  _StepData(
    number: '3',
    title: 'Créez votre profil',
    description:
        'Renseignez vos informations personnelles de manière sécurisée et confidentielle.',
    icon: Icons.person_add_rounded,
    color: AppColors.secondary,
  ),
  _StepData(
    number: '4',
    title: 'Définissez votre objectif',
    description:
        'Choisissez entre détermination du sexe ou planification selon votre situation.',
    icon: Icons.flag_rounded,
    color: AppColors.accent,
  ),
  _StepData(
    number: '5',
    title: 'Accédez aux résultats',
    description:
        'Recevez vos recommandations personnalisées basées sur notre algorithme validé.',
    icon: Icons.check_circle_rounded,
    color: AppColors.successGreen,
  ),
];

/// Section "Comment ça marche" — Timeline
class HowItWorksSection extends StatefulWidget {
  HowItWorksSection({Key? key}) : super(key: key);

  @override
  State<HowItWorksSection> createState() => _HowItWorksSectionState();
}

class _HowItWorksSectionState extends State<HowItWorksSection> {
  int? _hoveredStep;

  @override
  Widget build(BuildContext context) {
    final isMobile = (MediaQuery.maybeOf(context)?.size.width ?? 1024) < 768;

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
            // Badge
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.white.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Text(
                ' COMMENT ÇA MARCHE',
                style: AppTextStyles.labelLarge(context).copyWith(
                  fontSize: 14,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Seulement 5 étapes',
              style: AppTextStyles.displayMedium(context)
                  .copyWith(fontWeight: FontWeight.w800),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Simple, rapide et efficace pour toute la famille',
              style: AppTextStyles.bodyLarge(context).copyWith(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 60),
            isMobile
                ? _buildMobileTimeline(context)
                : _buildDesktopTimeline(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopTimeline(BuildContext context) {
    return Stack(
      children: [
        // Horizontal connecting line at center of circles (circle h=64, center at 32)
        Positioned(
          top: 31,
          left: 0,
          right: 0,
          child: Container(
            height: 2,
            color: AppColors.white.withValues(alpha: 0.3),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            _steps.length,
            (i) => Expanded(child: _buildDesktopStep(context, i)),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopStep(BuildContext context, int index) {
    final step = _steps[index];
    final isHovered = _hoveredStep == index;
    final dimmed = _hoveredStep != null && !isHovered;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredStep = index),
      onExit: (_) => setState(() => _hoveredStep = null),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: dimmed ? 0.65 : 1.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              // Numbered circle
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: step.color,
                  boxShadow: [
                    BoxShadow(
                      color: step.color.withValues(alpha: 0.45),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    step.number,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Icon(
                step.icon,
                color: AppColors.white.withValues(alpha: 0.85),
                size: 28,
              ),
              const SizedBox(height: 16),
              Text(
                step.title,
                style: AppTextStyles.titleLarge(context).copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                step.description,
                style: AppTextStyles.bodySmall(context).copyWith(
                  color: AppColors.white.withValues(alpha: 0.8),
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileTimeline(BuildContext context) {
    return Column(
      children: List.generate(_steps.length, (i) {
        return _buildMobileStep(context, i, i == _steps.length - 1);
      }),
    );
  }

  Widget _buildMobileStep(BuildContext context, int index, bool isLast) {
    final step = _steps[index];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left column: circle + vertical connector
        Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: step.color,
                boxShadow: [
                  BoxShadow(
                    color: step.color.withValues(alpha: 0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  step.number,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 88,
                color: AppColors.white.withValues(alpha: 0.3),
              ),
          ],
        ),
        const SizedBox(width: 20),
        // Right: title + icon + description
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        step.title,
                        style: AppTextStyles.titleMedium(context).copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      step.icon,
                      color: AppColors.white.withValues(alpha: 0.85),
                      size: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  step.description,
                  style: AppTextStyles.bodySmall(context).copyWith(
                    color: AppColors.white.withValues(alpha: 0.8),
                    height: 1.6,
                  ),
                ),
                if (!isLast) const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
