import 'package:flutter/material.dart';

/// Révèle son enfant avec une animation fade + slide vers le haut
/// dès que le widget entre dans le viewport lors du scroll.
class ScrollReveal extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;

  const ScrollReveal({
    Key? key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 650),
  }) : super(key: key);

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;

  bool _triggered = false;
  ScrollPosition? _scrollPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    final curve = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(curve);
    _slide = Tween<Offset>(
      begin: const Offset(0.0, 0.08),
      end: Offset.zero,
    ).animate(curve);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollPosition?.removeListener(_check);
    _scrollPosition = Scrollable.maybeOf(context)?.position;
    _scrollPosition?.addListener(_check);
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
  }

  @override
  void dispose() {
    _scrollPosition?.removeListener(_check);
    _controller.dispose();
    super.dispose();
  }

  void _check() {
    if (!mounted || _triggered) return;
    final RenderBox? box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.attached) return;

    final double screenHeight = MediaQuery.maybeOf(context)?.size.height ?? 800;
    final Offset position = box.localToGlobal(Offset.zero);

    // Déclenche quand le haut du widget est à 105 % de la hauteur de l'écran
    // (légèrement avant qu'il soit visible, pour une transition fluide).
    if (position.dy < screenHeight * 1.05) {
      _triggered = true;
      _scrollPosition?.removeListener(_check);
      if (widget.delay == Duration.zero) {
        _controller.forward();
      } else {
        Future.delayed(widget.delay, () {
          if (mounted) _controller.forward();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(
        position: _slide,
        child: widget.child,
      ),
    );
  }
}
