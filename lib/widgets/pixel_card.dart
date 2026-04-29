import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/pixel_theme.dart';

class PixelCard extends StatefulWidget {
  final String title;
  final String icon;
  final String preview;
  final VoidCallback onTap;

  const PixelCard({
    super.key,
    required this.title,
    required this.icon,
    required this.preview,
    required this.onTap,
  });

  @override
  State<PixelCard> createState() => _PixelCardState();
}

class _PixelCardState extends State<PixelCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  late Animation<Color?> _borderColor;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scale = Tween<double>(
      begin: 1.0,
      end: 0.96,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _borderColor = ColorTween(
      begin: PixelTheme.border,
      end: PixelTheme.primary,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) {
    HapticFeedback.selectionClick();
    _controller.forward();
  }

  void _onTapUp(TapUpDetails _) {
    _controller.reverse();
    widget.onTap();
  }

  void _onTapCancel() => _controller.reverse();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(
        scale: _scale,
        child: AnimatedBuilder(
          animation: _borderColor,
          builder: (context, child) => Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: PixelTheme.cardBackground,
              border: Border.all(
                color: _borderColor.value ?? PixelTheme.border,
                width: 1,
              ),
            ),
            child: child,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.icon, style: const TextStyle(fontSize: 22)),
              const SizedBox(height: 10),
              Text(
                widget.title,
                style: const TextStyle(
                  color: PixelTheme.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              const Spacer(),
              Container(
                width: double.infinity,
                height: 1,
                color: PixelTheme.border,
              ),
              const SizedBox(height: 6),
              Text(
                widget.preview,
                style: const TextStyle(
                  color: PixelTheme.textSecondary,
                  fontSize: 10,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
