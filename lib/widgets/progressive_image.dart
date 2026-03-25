import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

/// Widget pour chargement progressif d'images avec BlurHash placeholder
///
/// Effet "Facebook-style":
/// 1. BlurHash placeholder s'affiche instantanément (<50ms)
/// 2. Image réelle se charge en arrière-plan
/// 3. Transition smooth (fade) entre placeholder et image finale
///
/// Améliore la perception de vitesse même sur connexions lentes
class ProgressiveImage extends StatefulWidget {
  /// URL de l'image (HTTP/HTTPS ou asset local)
  final String imageUrl;

  /// BlurHash string (généré depuis l'image originale)
  /// Format: chaîne de 20-30 caractères représentant l'image floue
  /// Génération: https://blurha.sh/ ou blurhash CLI
  final String blurHash;

  /// Mode d'ajustement de l'image (cover, contain, fill, etc.)
  final BoxFit fit;

  /// Largeur de cache pour optimiser la mémoire
  final int? cacheWidth;

  /// Hauteur de cache pour optimiser la mémoire
  final int? cacheHeight;

  /// Bordures arrondies optionnelles
  final BorderRadius? borderRadius;

  /// Durée de la transition fade entre placeholder et image
  final Duration fadeDuration;

  /// Widget affiché en cas d'erreur de chargement
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;

  const ProgressiveImage({
    super.key,
    required this.imageUrl,
    required this.blurHash,
    this.fit = BoxFit.cover,
    this.cacheWidth,
    this.cacheHeight,
    this.borderRadius,
    this.fadeDuration = const Duration(milliseconds: 500),
    this.errorBuilder,
  });

  @override
  State<ProgressiveImage> createState() => _ProgressiveImageState();
}

class _ProgressiveImageState extends State<ProgressiveImage> {
  bool _imageLoaded = false;
  bool _hasError = false;
  Object? _error;
  StackTrace? _stackTrace;

  @override
  Widget build(BuildContext context) {
    // Approche simple sans Stack pour éviter les problèmes de layout
    Widget content;

    if (_hasError && widget.errorBuilder != null) {
      // Afficher le widget d'erreur si disponible
      content = widget.errorBuilder!(context, _error!, _stackTrace);
    } else if (!_imageLoaded) {
      // Afficher uniquement BlurHash pendant le chargement
      content = BlurHash(
        hash: widget.blurHash,
        imageFit: widget.fit,
        curve: Curves.easeOut,
      );
    } else {
      // Afficher l'image avec fade-in par-dessus BlurHash
      content = Stack(
        children: [
          BlurHash(
            hash: widget.blurHash,
            imageFit: widget.fit,
            curve: Curves.easeOut,
          ),
          Positioned.fill(
            child: AnimatedOpacity(
              opacity: 1.0,
              duration: widget.fadeDuration,
              curve: Curves.easeInOut,
              child: widget.imageUrl.startsWith('http')
                  ? Image.network(
                      widget.imageUrl,
                      fit: widget.fit,
                      cacheWidth: widget.cacheWidth,
                      cacheHeight: widget.cacheHeight,
                      errorBuilder: (context, error, stackTrace) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (mounted) {
                            setState(() {
                              _hasError = true;
                              _error = error;
                              _stackTrace = stackTrace;
                            });
                          }
                        });
                        return const SizedBox.shrink();
                      },
                    )
                  : Image.asset(
                      widget.imageUrl,
                      fit: widget.fit,
                      cacheWidth: widget.cacheWidth,
                      cacheHeight: widget.cacheHeight,
                      errorBuilder: (context, error, stackTrace) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (mounted) {
                            setState(() {
                              _hasError = true;
                              _error = error;
                              _stackTrace = stackTrace;
                            });
                          }
                        });
                        return const SizedBox.shrink();
                      },
                    ),
            ),
          ),
        ],
      );
    }

    // Charger l'image en arrière-plan dès le premier build
    if (!_imageLoaded && !_hasError) {
      _loadImage();
    }

    // Appliquer borderRadius si spécifié
    // Charger l'image en arrière-plan dès le premier build
    if (!_imageLoaded && !_hasError) {
      _loadImage();
    }

    // Appliquer borderRadius si spécifié
    if (widget.borderRadius != null) {
      return ClipRRect(
        borderRadius: widget.borderRadius!,
        child: content,
      );
    }

    return content;
  }

  /// Charge l'image en arrière-plan pour déterminer quand elle est prête
  void _loadImage() {
    if (widget.imageUrl.startsWith('http')) {
      // Image réseau
      final image = NetworkImage(widget.imageUrl);
      final stream = image.resolve(const ImageConfiguration());

      stream.addListener(ImageStreamListener(
        (info, synchronousCall) {
          if (mounted && !_imageLoaded) {
            setState(() => _imageLoaded = true);
          }
        },
        onError: (error, stackTrace) {
          if (mounted) {
            setState(() {
              _hasError = true;
              _error = error;
              _stackTrace = stackTrace;
            });
          }
        },
      ));
    } else {
      // Image asset - assume rapide, charge après un court délai
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted && !_imageLoaded) {
          setState(() => _imageLoaded = true);
        }
      });
    }
  }
}
