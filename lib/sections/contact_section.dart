import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/section_container.dart';

/// Section "Contact"
class ContactSection extends StatelessWidget {
  const ContactSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < 600;

    return SectionContainer(
      backgroundColor: Colors.grey.shade50,
      child: Container(
        padding: EdgeInsets.all(isSmall ? 30 : 60),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact',
              style: AppTextStyles.sectionTitle(context),
            ),
            const SizedBox(height: 16),
            Text(
              'Pour toute question ou partenariat',
              style: AppTextStyles.bodyText(context),
            ),
            const SizedBox(height: 40),
            _buildContactItem(
              context,
              Icons.phone,
              'Téléphone',
              '(+225) 07 78 68 33 53',
            ),
            const SizedBox(height: 20),
            _buildContactItem(
              context,
              Icons.email,
              'Email',
              'doumbiabonmanin@gmail.com',
            ),
            const SizedBox(height: 20),
            _buildContactItem(
              context,
              Icons.location_on,
              'Localisation',
              'Cocody, Côte d\'Ivoire',
            ),
            const SizedBox(height: 40),
            const Divider(),
            const SizedBox(height: 20),
            Center(
              child: Text(
                '© 2025 NASCENTIA. Tous droits réservés.',
                style: AppTextStyles.cardText(context),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.white, size: 24),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.cardText(context).copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkText,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                value,
                style: AppTextStyles.cardText(context),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
