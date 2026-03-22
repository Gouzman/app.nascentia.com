import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_constants.dart';

/// Carte de fonctionnalité moderne avec gradient - Style Make Market
class FeatureCardModern extends StatelessWidget {
  final String title;
  final String description;
  final Widget? phone;
  final bool reverseLayout;
  final Color? backgroundColor;
  final Gradient? gradient;

  const FeatureCardModern({
    Key? key,
    required this.title,
    required this.description,
    this.phone,
    this.reverseLayout = false,
    this.backgroundColor,
    this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = AppConstants.isMobile(context);

    if (isMobile) {
      return _buildMobileLayout(context);
    }

    return _buildDesktopLayout(context);
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppConstants.spacing40),
      decoration: BoxDecoration(
        gradient: gradient ?? AppColors.blueCardGradient,
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppConstants.spacing40),
        boxShadow: [
          BoxShadow(
            color: (gradient != null || backgroundColor == null)
                ? AppColors.blue.withValues(alpha: 0.2)
                : Colors.black.withValues(alpha: 0.05),
            blurRadius: AppConstants.spacing40,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildTextContent(context, true),
          if (phone != null) ...[
            SizedBox(height: AppConstants.spacing40),
            phone!,
          ],
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.spacing60,
        vertical: AppConstants.spacing60,
      ),
      decoration: BoxDecoration(
        gradient: gradient ?? AppColors.blueCardGradient,
        color: backgroundColor,
        borderRadius: BorderRadius.circular(50), // 50 pour garder l'effet arrondi
        boxShadow: [
          BoxShadow(
            color: (gradient != null || backgroundColor == null)
                ? AppColors.blue.withValues(alpha: 0.2)
                : Colors.black.withValues(alpha: 0.05),
            blurRadius: AppConstants.spacing40,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: reverseLayout
            ? [
                if (phone != null) ...[
                  Expanded(
                    flex: 2,
                    child: phone!,
                  ),
                  SizedBox(width: AppConstants.spacing80),
                ],
                Expanded(
                  flex: 3,
                  child: _buildTextContent(context, false),
                ),
              ]
            : [
                Expanded(
                  flex: 3,
                  child: _buildTextContent(context, false),
                ),
                if (phone != null) ...[
                  SizedBox(width: AppConstants.spacing80),
                  Expanded(
                    flex: 2,
                    child: phone!,
                  ),
                ],
              ],
      ),
    );
  }

  Widget _buildTextContent(BuildContext context, bool isSmall) {
    final hasGradient = gradient != null || backgroundColor == null;
    final textColor = hasGradient ? AppColors.white : AppColors.darkText;
    final descColor =
        hasGradient ? AppColors.white.withValues(alpha: 0.95) : AppColors.greyText;

    return Column(
      crossAxisAlignment:
          isSmall ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.sectionSubtitle(context).copyWith(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: isSmall ? 24 : 32,
          ),
          textAlign: isSmall ? TextAlign.center : TextAlign.left,
        ),
        SizedBox(height: AppConstants.spacing24),
        Text(
          description,
          style: AppTextStyles.bodyText(context).copyWith(
            color: descColor,
            fontSize: isSmall ? 16 : 18,
            height: 1.7,
          ),
          textAlign: isSmall ? TextAlign.center : TextAlign.left,
        ),
      ],
    );
  }
}
