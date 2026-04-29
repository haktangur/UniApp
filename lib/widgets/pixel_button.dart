import 'package:flutter/material.dart';
import '../theme/pixel_theme.dart';

class PixelButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final Color? color;

  const PixelButton({
    super.key,
    required this.label,
    required this.onTap,
    this.color,
  });

  @override
  State<PixelButton> createState() => _PixelButtonState();
}

class _PixelButtonState extends State<PixelButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? PixelTheme.primary;

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 60),
        transform: Matrix4.translationValues(
          _pressed ? 1 : 0,
          _pressed ? 1 : 0,
          0,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: color, width: 1),
        ),
        child: Text(
          widget.label,
          style: TextStyle(
            color: color,
            fontSize: 12,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
