import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

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
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < 900;

    if (isSmall) {
      return _buildMobileLayout(context);
    }

    return _buildDesktopLayout(context);
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        gradient: gradient ?? AppColors.blueCardGradient,
        color: backgroundColor,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: (gradient != null || backgroundColor == null)
                ? AppColors.blue.withOpacity(0.2)
                : Colors.black.withOpacity(0.05),
            blurRadius: 40,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildTextContent(context, true),
          if (phone != null) ...[
            const SizedBox(height: 40),
            phone!,
          ],
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 60),
      decoration: BoxDecoration(
        gradient: gradient ?? AppColors.blueCardGradient,
        color: backgroundColor,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: (gradient != null || backgroundColor == null)
                ? AppColors.blue.withOpacity(0.2)
                : Colors.black.withOpacity(0.05),
            blurRadius: 40,
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
                  const SizedBox(width: 80),
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
                  const SizedBox(width: 80),
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
        hasGradient ? AppColors.white.withOpacity(0.95) : AppColors.greyText;

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
        const SizedBox(height: 24),
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
