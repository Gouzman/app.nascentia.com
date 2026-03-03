import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'dart:math' as math;

/// Hero Section NASCENTIA - Design Premium Pixel Perfect
class HeroSection extends StatefulWidget {
  const HeroSection({Key? key}) : super(key: key);

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-0.3, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 1024;
    final isMobile = size.width < 768;

    return Container(
      constraints: BoxConstraints(
        minHeight: size.height * 0.7,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 20,
        vertical: isMobile ? 0 : 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryPink.withValues(alpha: 0.2),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.heroGradient,
          ),
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 32 : (size.width < 1024 ? 50 : 80),
                  vertical: isMobile ? 50 : 60,
                ),
                child: isMobile
                    ? _buildMobileLayout(context)
                    : _buildDesktopLayout(context, isDesktop),
              ),

              if (!isMobile)
                Positioned.fill(
                  child: _buildPhoneMockups(context, isDesktop),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, bool isDesktop) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: isDesktop ? 5 : 6,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: _buildTextContent(context, false),
            ),
          ),
        ),
        Expanded(
          flex: isDesktop ? 5 : 4,
          child: const SizedBox(),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FadeTransition(
          opacity: _fadeAnimation,
          child: _buildTextContent(context, true),
        ),
        const SizedBox(height: 60),
        _buildPhoneMockups(context, false),
      ],
    );
  }

  Widget _buildTextContent(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Titre principal avec ligne décorative
        Row(
          mainAxisSize: isMobile ? MainAxisSize.min : MainAxisSize.max,
          children: [
            Flexible(
              child: Text(
                'NASCENTIA',
                style: AppTextStyles.displayLarge(context),
                textAlign: isMobile ? TextAlign.center : TextAlign.left,
              ),
            ),
            if (!isMobile) ...[
              const SizedBox(width: 24),
              Container(
                width: 60,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ],
        ),

        const SizedBox(height: 24),

        Text(
          'Une application scientifique innovante permettant de déterminer le sexe du bébé dès la conception '
          'ou de planifier le sexe avant la grossesse grâce à un modèle validé.',
          style: AppTextStyles.bodyLarge(context).copyWith(height: 1.7),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ),

        const SizedBox(height: 36),

        // R2 — Bouton CTA solide blanc (plus visible sur fond rose)
        _buildPrimaryButton(isMobile),

        if (!isMobile) ...[
          const SizedBox(height: 60),
          _buildSocialIcons(),
        ],
      ],
    );
  }

  /// R2 — Bouton blanc plein avec icône download (remplace le ghost button)
  Widget _buildPrimaryButton(bool isMobile) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/download'),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 32 : 40,
            vertical: isMobile ? 16 : 20,
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(999),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.download_rounded,
                color: AppColors.primary,
                size: isMobile ? 20 : 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Télécharger l\'application',
                style: TextStyle(
                  fontSize: isMobile ? 15 : 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// R11 — Icônes sociales avec vrais logos FontAwesome
  Widget _buildSocialIcons() {
    return Row(
      children: [
        _buildSocialIcon(FontAwesomeIcons.telegram),
        const SizedBox(width: 20),
        _buildSocialIcon(FontAwesomeIcons.facebookF),
        const SizedBox(width: 20),
        _buildSocialIcon(FontAwesomeIcons.instagram),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: FaIcon(icon, color: AppColors.white, size: 18),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneMockups(BuildContext context, bool isDesktop) {
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        Positioned(
          right: isDesktop ? 100 : 50,
          bottom: 30,
          child: _AnimatedPhone(
            imagePath: 'lib/assets/images/image_header-1.png',
            rotation: -8 * math.pi / 180,
            delay: 200,
            scale: isDesktop ? 0.9 : 0.75,
          ),
        ),
        Positioned(
          right: isDesktop ? 280 : 180,
          top: 70,
          child: _AnimatedPhone(
            imagePath: 'lib/assets/images/image_header-2.png',
            rotation: 6 * math.pi / 180,
            delay: 400,
            scale: isDesktop ? 0.9 : 0.75,
          ),
        ),
      ],
    );
  }
}

/// Widget Téléphone avec animation
class _AnimatedPhone extends StatefulWidget {
  final String imagePath;
  final double rotation;
  final int delay;
  final double scale;

  const _AnimatedPhone({
    required this.imagePath,
    required this.rotation,
    required this.delay,
    this.scale = 1.0,
  });

  @override
  State<_AnimatedPhone> createState() => _AnimatedPhoneState();
}

class _AnimatedPhoneState extends State<_AnimatedPhone>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Transform.rotate(
          angle: widget.rotation,
          child: Transform.scale(
            scale: widget.scale,
            child: Container(
              width: 280,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.18),
                    blurRadius: 24,
                    offset: const Offset(0, 14),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  widget.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 280,
                      height: 560,
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Icon(Icons.phone_iphone,
                            size: 80, color: AppColors.white),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
