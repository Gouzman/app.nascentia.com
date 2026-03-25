import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_constants.dart';
import '../widgets/top_navigation_bar.dart';
import '../widgets/app_footer.dart';
import '../content/legal_content.dart';

/// Page légale générique pour mentions légales, confidentialité, CGU
class LegalPage extends StatelessWidget {
  final String contentType; // 'mentions', 'privacy', 'terms'

  const LegalPage({
    Key? key,
    required this.contentType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final content = LegalContent.getContent(contentType);
    final isMobile = MediaQuery.of(context).size.width < AppConstants.breakpointMobile;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TopNavigationBar(),

            // Contenu principal
            Container(
              constraints: const BoxConstraints(maxWidth: 900),
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? AppConstants.spacing24 : AppConstants.spacing48,
                vertical: isMobile ? AppConstants.spacing40 : AppConstants.spacing64,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // En-tête
                  Text(
                    content['title']!,
                    style: AppTextStyles.displayLarge(context),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    content['lastUpdate']!,
                    style: AppTextStyles.bodySmall(context).copyWith(
                      color: AppColors.greyText,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Contenu HTML
                  _buildHtmlContent(context, content['body']!),

                  const SizedBox(height: 40),

                  // Bouton retour
                  Center(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        side: BorderSide(color: AppColors.primaryPink, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                        ),
                      ),
                      child: Text(
                        'Retour à l\'accueil',
                        style: AppTextStyles.bodyMedium(context).copyWith(
                          color: AppColors.primaryPink,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const AppFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHtmlContent(BuildContext context, String htmlContent) {
    // Parser simple pour sections HTML
    final sections = htmlContent.split('<h2>');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: sections.map((section) {
        if (section.trim().isEmpty) return const SizedBox.shrink();

        final parts = section.split('</h2>');
        if (parts.length < 2) {
          // Pas de titre, juste du contenu
          return _buildParagraph(context, section);
        }

        final title = parts[0].trim();
        final content = parts[1].trim();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            Text(
              title,
              style: AppTextStyles.headlineMedium(context),
            ),
            const SizedBox(height: 16),
            _buildParagraph(context, content),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildParagraph(BuildContext context, String content) {
    // Traiter les listes <ul><li>
    if (content.contains('<ul>')) {
      final items = content
          .replaceAll('<ul>', '')
          .replaceAll('</ul>', '')
          .split('<li>')
          .where((item) => item.trim().isNotEmpty)
          .map((item) => item.replaceAll('</li>', '').trim())
          .toList();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.map((item) {
          return Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('• ', style: AppTextStyles.bodyMedium(context)),
                Expanded(
                  child: Text(
                    item,
                    style: AppTextStyles.bodyMedium(context),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      );
    }

    // Paragraphes normaux
    final paragraphs = content
        .replaceAll('<p>', '')
        .split('</p>')
        .where((p) => p.trim().isNotEmpty)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: paragraphs.map((p) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(
            p.trim(),
            style: AppTextStyles.bodyMedium(context).copyWith(height: 1.6),
          ),
        );
      }).toList(),
    );
  }
}
