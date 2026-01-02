import 'package:flutter/material.dart';

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
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < 600;
    final isMedium = screenWidth >= 600 && screenWidth < 1024;

    double horizontalPadding;
    if (isSmall) {
      horizontalPadding = 20;
    } else if (isMedium) {
      horizontalPadding = 40;
    } else {
      horizontalPadding = 80;
    }

    return Container(
      width: double.infinity,
      color: backgroundColor,
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: isSmall ? 60 : 100,
          ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: child,
        ),
      ),
    );
  }
}
