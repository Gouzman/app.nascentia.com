import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_constants.dart';

/// Bouton principal NASCENTIA - Material Design 3
/// Respecte les standards Material avec feedback visuel optimal
class PrimaryButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool outlined;
  final double? width;
  final bool fullWidth;

  const PrimaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.outlined = false,
    this.width,
    this.fullWidth = false,
  }) : super(key: key);

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    if (widget.outlined) {
      return _buildOutlinedButton();
    }
    return _buildFilledButton();
  }

  /// Bouton outline (bordure blanche)
  Widget _buildOutlinedButton() {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: AppConstants.animationFast,
        curve: AppConstants.animationCurve,
        width: widget.fullWidth ? double.infinity : widget.width,
        height: AppConstants.buttonHeightMedium,
        decoration: BoxDecoration(
          color: _isHovered
              ? AppColors.white.withValues(alpha: 0.1)
              : Colors.transparent,
          border: Border.all(
            color: AppColors.white,
            width: 2,
          ),
          borderRadius: AppConstants.borderRadiusPill,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onPressed,
            borderRadius: AppConstants.borderRadiusPill,
            child: Center(
              child: Text(
                widget.text,
                style: AppTextStyles.labelLarge(context),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Bouton filled (dégradé)
  Widget _buildFilledButton() {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.02 : 1.0,
        duration: AppConstants.animationFast,
        curve: AppConstants.animationCurve,
        child: Container(
          width: widget.fullWidth ? double.infinity : widget.width,
          height: AppConstants.buttonHeightMedium,
          decoration: BoxDecoration(
            gradient: AppColors.buttonGradient,
            borderRadius: AppConstants.borderRadiusPill,
            boxShadow: _isHovered
                ? AppConstants.shadowLarge
                : AppConstants.shadowMedium,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onPressed,
              borderRadius: AppConstants.borderRadiusPill,
              child: Center(
                child: Text(
                  widget.text,
                  style: AppTextStyles.labelLarge(context),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
