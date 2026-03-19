import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../services/navigation_service.dart';

/// Section "CTA Téléchargement" - NASCENTIA
class AppSection extends StatefulWidget {
  const AppSection({Key? key}) : super(key: key);

  @override
  State<AppSection> createState() => _AppSectionState();
}

class _AppSectionState extends State<AppSection> {
  String? _hoveredButton;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768; // R4

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: AppColors.heroGradient,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 60,
        vertical: isMobile ? 60 : 100,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: AppColors.white.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.download_rounded,
                        color: AppColors.white, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      'TÉLÉCHARGEMENT',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              Text(
                'Prêt à commencer ?',
                style: isMobile
                    ? AppTextStyles.displayMedium(context)
                    : AppTextStyles.displayLarge(context)
                        .copyWith(fontSize: 56),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              Text(
                'Téléchargez NASCENTIA maintenant et découvrez votre avenir.',
                style: AppTextStyles.bodyLarge(context),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 32),

              // R1 — Statistiques unifiées à 90 %
              Wrap(
                spacing: isMobile ? 16 : 32,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: [
                  _buildStat(Icons.star, '4.8/5', 'Note moyenne', isMobile),
                  _buildStat(Icons.download, '10k+', 'Téléchargements', isMobile),
                  _buildStat(Icons.verified, '90 %', 'Fiabilité', isMobile),
                ],
              ),

              const SizedBox(height: 40),

              Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  _buildButton(
                      'android', 'Télécharger Android', Icons.android,
                      true, isMobile),
                  // R3 — Bouton "Contactez-nous" navigue vers la section Contact
                  _buildButton(
                      'contact', 'Contactez-nous', Icons.email_outlined,
                      false, isMobile),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
      String id, String text, IconData icon, bool isPrimary, bool isMobile) {
    final isHovered = _hoveredButton == id;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hoveredButton = id),
      onExit: (_) => setState(() => _hoveredButton = null),
      child: GestureDetector(
        onTap: () async {
          if (id == 'android') {
            // Télécharger directement l'APK
            try {
              // Construire l'URL dynamiquement basée sur le domaine courant
              final apkUrl = Uri.base.resolve('/downloads/nascentia.apk');
              if (await canLaunchUrl(apkUrl)) {
                await launchUrl(apkUrl, mode: LaunchMode.externalApplication);
              }
            } catch (e) {
              print('Erreur téléchargement APK: $e');
            }
          } else if (id == 'contact') {
            // R3 — Navigation fonctionnelle vers la section Contact
            NavigationService.scrollToSectionByName('Contact');
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          transform: Matrix4.diagonal3Values(
            isHovered ? 1.08 : 1.0, isHovered ? 1.08 : 1.0, 1.0,
          )..setTranslationRaw(0.0, isHovered ? -4.0 : 0.0, 0.0),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 28 : 36,
            vertical: isMobile ? 16 : 20,
          ),
          decoration: BoxDecoration(
            color: isPrimary ? AppColors.white : Colors.transparent,
            border: Border.all(color: AppColors.white, width: 2),
            borderRadius: BorderRadius.circular(999),
            boxShadow: isHovered
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isPrimary ? AppColors.purple : AppColors.white,
                size: isMobile ? 20 : 24,
              ),
              const SizedBox(width: 12),
              Text(
                text,
                style: AppTextStyles.labelLarge(context).copyWith(
                  color: isPrimary ? AppColors.purple : AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(
      IconData icon, String value, String label, bool isMobile) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppColors.white, size: isMobile ? 20 : 24),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: isMobile ? 18 : 22,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: isMobile ? 11 : 12,
                color: AppColors.white.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
