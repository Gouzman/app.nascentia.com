import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_constants.dart';
import '../widgets/primary_button.dart';
import '../widgets/top_navigation_bar.dart';
import '../widgets/app_footer.dart';

/// Page 404 - Page non trouvée
class NotFoundPage extends StatelessWidget {
  NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.maybeOf(context)?.size ?? const Size(1024, 800);
    final isMobile = size.width < AppConstants.breakpointMobile;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopNavigationBar(),

            // Contenu 404
            Container(
              constraints: BoxConstraints(
                minHeight: size.height * 0.7,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? AppConstants.spacing24 : AppConstants.spacing48,
                vertical: isMobile ? AppConstants.spacing64 : AppConstants.spacing80,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Code 404 avec gradient
                    ShaderMask(
                      shaderCallback: (bounds) => AppColors.primaryGradient.createShader(bounds),
                      child: Text(
                        '404',
                        style: TextStyle(
                          fontSize: isMobile ? 120 : 180,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1,
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Titre
                    Text(
                      'Page non trouvée',
                      style: AppTextStyles.displayMedium(context),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 16),

                    // Description
                    Container(
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: Text(
                        'Désolé, la page que vous recherchez n\'existe pas ou a été déplacée. Retournez à l\'accueil pour découvrir NASCENTIA.',
                        style: AppTextStyles.bodyLarge(context).copyWith(
                          color: AppColors.greyText,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    const SizedBox(height: 48),

                    // Boutons d'action
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      alignment: WrapAlignment.center,
                      children: [
                        PrimaryButton(
                          text: 'Retour à l\'accueil',
                          onPressed: () => Navigator.pushReplacementNamed(context, '/'),
                        ),
                        OutlinedButton(
                          onPressed: () => Navigator.pushNamed(context, '/download'),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: isMobile ? 24 : 32,
                              vertical: isMobile ? 14 : 16,
                            ),
                            side: BorderSide(color: AppColors.primaryPink, width: 2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                            ),
                          ),
                          child: Text(
                            'Télécharger l\'app',
                            style: AppTextStyles.bodyMedium(context).copyWith(
                              color: AppColors.primaryPink,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 64),

                    // Liens utiles
                    Container(
                      constraints: const BoxConstraints(maxWidth: 500),
                      child: Column(
                        children: [
                          Text(
                            'Liens utiles',
                            style: AppTextStyles.titleMedium(context),
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 24,
                            runSpacing: 12,
                            alignment: WrapAlignment.center,
                            children: [
                              _buildLink(context, 'Accueil', '/'),
                              _buildLink(context, 'Téléchargement', '/download'),
                              _buildLink(context, 'Mentions légales', '/mentions-legales'),
                              _buildLink(context, 'Contact', '/', argument: 'Contact'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const AppFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildLink(BuildContext context, String text, String route, {String? argument}) {
    return InkWell(
      onTap: () {
        if (argument != null) {
          Navigator.pushReplacementNamed(context, route, arguments: argument);
        } else {
          Navigator.pushNamed(context, route);
        }
      },
      child: Text(
        text,
        style: AppTextStyles.bodyMedium(context).copyWith(
          color: AppColors.primaryPink,
          decoration: TextDecoration.underline,
          decorationColor: AppColors.primaryPink,
        ),
      ),
    );
  }
}
