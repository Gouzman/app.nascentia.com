import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_constants.dart';
import '../widgets/section_container.dart';
import '../widgets/contact_form.dart';

/// Section "Contact" avec formulaire fonctionnel et informations de contact
class ContactSection extends StatelessWidget {
  const ContactSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = AppConstants.isMobile(context);
    final size = MediaQuery.of(context).size;

    return SectionContainer(
      backgroundColor: Colors.grey.shade50,
      child: Container(
        padding: EdgeInsets.all(isMobile ? 24 : 48),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              // En-tête
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'CONTACTEZ-NOUS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  SizedBox(height: isMobile ? 16 : 24),
                  Text(
                    'Une question? Parlons-en',
                    style: AppTextStyles.sectionTitle(context),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: isMobile ? 12 : 16),
                  Text(
                    'Notre équipe vous répond sous 24-48h',
                    style: AppTextStyles.bodyText(context).copyWith(
                      color: AppColors.greyText,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              SizedBox(height: isMobile ? 40 : 60),

              // Contenu principal: formulaire + infos de contact
              size.width >= 900
                  ? _buildDesktopLayout()
                  : _buildMobileLayout(isMobile),

              SizedBox(height: isMobile ? 40 : 60),
            ],
          ),
        ),
      ),
    );
  }

  /// Layout desktop (formulaire à gauche, infos à droite)
  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Formulaire (60%)
        Expanded(
          flex: 6,
          child: _buildFormCard(),
        ),
        const SizedBox(width: 40),
        // Informations de contact (40%)
        Expanded(
          flex: 4,
          child: _buildContactInfo(),
        ),
      ],
    );
  }

  /// Layout mobile (formulaire en haut, infos en bas)
  Widget _buildMobileLayout(bool isMobile) {
    return Column(
      children: [
        _buildFormCard(),
        SizedBox(height: isMobile ? 32 : 40),
        _buildContactInfo(),
      ],
    );
  }

  /// Carte contenant le formulaire
  Widget _buildFormCard() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: const ContactForm(),
    );
  }

  /// Informations de contact
  Widget _buildContactInfo() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFF8F9FA),
            Color(0xFFFFFFFF),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informations de contact',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.greyText,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Vous pouvez aussi nous joindre directement',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.greyText,
            ),
          ),
          const SizedBox(height: 32),

          // Téléphone
          _buildContactItem(
            icon: Icons.phone_rounded,
            label: 'Téléphone',
            value: '(+225) 07 78 68 33 53',
            gradient: AppColors.primaryGradient,
          ),

          const SizedBox(height: 24),

          // Email
          _buildContactItem(
            icon: Icons.email_rounded,
            label: 'Email',
            value: 'contact@nascentia-tech.com',
            gradient: const LinearGradient(
              colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
            ),
          ),

          const SizedBox(height: 24),

          // Localisation
          _buildContactItem(
            icon: Icons.location_on_rounded,
            label: 'Localisation',
            value: 'Cocody, Abidjan\nCôte d\'Ivoire',
            gradient: const LinearGradient(
              colors: [Color(0xFF28A745), Color(0xFF1E7E34)],
            ),
          ),

          const SizedBox(height: 32),

          // Horaires
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.lightCream,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.accent.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.access_time_rounded,
                  color: AppColors.primary,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Horaires de réponse',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.greyText,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Lun - Ven: 9h00 - 18h00\nSam: 9h00 - 13h00',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.greyText,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String label,
    required String value,
    required Gradient gradient,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.greyText,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                value,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.greyText,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
