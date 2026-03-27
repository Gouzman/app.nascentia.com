import 'package:flutter/material.dart';

/// Widget pour charger les images de manière lazy (différée)
/// Optimise le temps de chargement initial en ne chargeant les images
/// que lorsqu'elles deviennent visibles ou après un délai
class LazyImage extends StatefulWidget {
  final String imagePath;
  final BoxFit fit;
  final int? cacheWidth;
  final int? cacheHeight;
  final BorderRadius? borderRadius;
  final Duration delay;
  final Widget? placeholder;
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;

  const LazyImage({
    super.key,
    required this.imagePath,
    this.fit = BoxFit.cover,
    this.cacheWidth,
    this.cacheHeight,
    this.borderRadius,
    this.delay = const Duration(milliseconds: 100),
    this.placeholder,
    this.errorBuilder,
  });

  @override
  State<LazyImage> createState() => _LazyImageState();
}

class _LazyImageState extends State<LazyImage> {
  bool _shouldLoad = false;

  @override
  void initState() {
    super.initState();
    // Charger l'image après le délai spécifié
    Future.delayed(widget.delay, () {
      if (mounted) {
        setState(() => _shouldLoad = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_shouldLoad) {
      // Afficher le placeholder pendant le chargement
      return widget.placeholder ??
          Container(
            color: Colors.grey.withValues(alpha: 0.1),
            child: const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                ),
              ),
            ),
          );
    }

    final image = widget.imagePath.startsWith('http')
        ? Image.network(
            widget.imagePath,
            fit: widget.fit,
            cacheWidth: widget.cacheWidth,
            cacheHeight: widget.cacheHeight,
            errorBuilder: widget.errorBuilder,
          )
        : Image.asset(
            widget.imagePath,
            fit: widget.fit,
            cacheWidth: widget.cacheWidth,
            cacheHeight: widget.cacheHeight,
            errorBuilder: widget.errorBuilder,
          );

    if (widget.borderRadius != null) {
      return ClipRRect(
        borderRadius: widget.borderRadius!,
        child: image,
      );
    }

    return image;
  }
}

/// Widget pour charger les images de manière lazy avec détection de visibilité
/// L'image ne se charge que lorsqu'elle entre dans le viewport
class LazyImageOnScroll extends StatefulWidget {
  final String imagePath;
  final BoxFit fit;
  final int? cacheWidth;
  final int? cacheHeight;
  final BorderRadius? borderRadius;
  final Widget? placeholder;
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;

  const LazyImageOnScroll({
    super.key,
    required this.imagePath,
    this.fit = BoxFit.cover,
    this.cacheWidth,
    this.cacheHeight,
    this.borderRadius,
    this.placeholder,
    this.errorBuilder,
  });

  @override
  State<LazyImageOnScroll> createState() => _LazyImageOnScrollState();
}

class _LazyImageOnScrollState extends State<LazyImageOnScroll> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.imagePath),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_isVisible) {
          setState(() => _isVisible = true);
        }
      },
      child: _isVisible
          ? _buildImage()
          : (widget.placeholder ??
              Container(
                color: Colors.grey.withValues(alpha: 0.05),
              )),
    );
  }

  Widget _buildImage() {
    final image = widget.imagePath.startsWith('http')
        ? Image.network(
            widget.imagePath,
            fit: widget.fit,
            cacheWidth: widget.cacheWidth,
            cacheHeight: widget.cacheHeight,
            errorBuilder: widget.errorBuilder,
          )
        : Image.asset(
            widget.imagePath,
            fit: widget.fit,
            cacheWidth: widget.cacheWidth,
            cacheHeight: widget.cacheHeight,
            errorBuilder: widget.errorBuilder,
          );

    if (widget.borderRadius != null) {
      return ClipRRect(
        borderRadius: widget.borderRadius!,
        child: image,
      );
    }

    return image;
  }
}

/// Détecteur de visibilité simple sans dépendance externe
class VisibilityDetector extends StatefulWidget {
  final Widget child;
  final Key key;
  final Function(VisibilityInfo) onVisibilityChanged;

  const VisibilityDetector({
    required this.key,
    required this.child,
    required this.onVisibilityChanged,
  }) : super(key: key);

  @override
  State<VisibilityDetector> createState() => _VisibilityDetectorState();
}

class _VisibilityDetectorState extends State<VisibilityDetector> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkVisibility());
  }

  void _checkVisibility() {
    if (!mounted) return;

    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.hasSize) return;

    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    final screenHeight = MediaQuery.maybeOf(context)?.size.height ?? 800;

    // Vérifie si le widget est visible dans le viewport
    final isVisible = position.dy < screenHeight && position.dy + size.height > 0;
    final visibleHeight = isVisible
        ? (size.height -
                (position.dy < 0 ? -position.dy : 0) -
                (position.dy + size.height > screenHeight
                    ? position.dy + size.height - screenHeight
                    : 0))
            .clamp(0.0, size.height)
        : 0.0;

    final visibleFraction = size.height > 0 ? visibleHeight / size.height : 0.0;

    widget.onVisibilityChanged(VisibilityInfo(visibleFraction: visibleFraction));
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class VisibilityInfo {
  final double visibleFraction;

  VisibilityInfo({required this.visibleFraction});
}
