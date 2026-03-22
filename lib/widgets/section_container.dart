import 'package:flutter/material.dart';
import '../theme/app_constants.dart';

/// Container pour les sections avec responsive
class SectionContainer extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final EdgeInsets? padding;

  const SectionContainer({
    Key? key,
    required this.child,
    this.backgroundColor,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Utilisation des helpers centralisés pour la cohérence
    final isMobile = AppConstants.isMobile(context);

    return Container(
      width: double.infinity,
      color: backgroundColor,
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: AppConstants.responsiveHorizontalPadding(context),
            vertical: AppConstants.responsiveVerticalPadding(context),
          ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppConstants.maxContentWidth,
          ),
          child: child,
        ),
      ),
    );
  }
}
