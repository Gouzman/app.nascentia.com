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
    final isMobile = (MediaQuery.maybeOf(context)?.size.width ?? 1024) < 768;
    return Container(
      width: double.infinity,
      color: backgroundColor,
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: isMobile ? 20.0 : 40.0,
            vertical: isMobile ? 56.0 : 80.0,
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
