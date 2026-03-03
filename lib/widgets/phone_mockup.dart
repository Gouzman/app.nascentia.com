import 'package:flutter/material.dart';

/// Widget pour afficher un mockup de téléphone avec animation
class PhoneMockup extends StatefulWidget {
  final String imagePath;
  final double rotation;
  final Offset offset;
  final double scale;

  const PhoneMockup({
    Key? key,
    required this.imagePath,
    this.rotation = 0,
    this.offset = Offset.zero,
    this.scale = 1.0,
  }) : super(key: key);

  @override
  State<PhoneMockup> createState() => _PhoneMockupState();
}

class _PhoneMockupState extends State<PhoneMockup>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            widget.offset.dx,
            widget.offset.dy + (50 * (1 - _animation.value)),
          ),
          child: Transform.rotate(
            angle: widget.rotation,
            child: Transform.scale(
              scale: widget.scale * _animation.value,
              child: Opacity(
                opacity: _animation.value,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 40,
                        offset: const Offset(0, 20),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      widget.imagePath,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        // Placeholder si l'image n'existe pas encore
                        return Container(
                          width: 250,
                          height: 500,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: const Center(
                            child: Icon(Icons.phone_android,
                                size: 60, color: Colors.grey),
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
      },
    );
  }
}
