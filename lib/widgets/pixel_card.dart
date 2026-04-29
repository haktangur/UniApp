import 'package:flutter/material.dart';
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

class _PixelCardState extends State<PixelCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: PixelTheme.cardBackground,
          border: Border.all(
            color: _pressed ? PixelTheme.primary : PixelTheme.border,
            width: 1,
          ),
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
    );
  }
}
