import 'package:flutter/material.dart';
import '../theme/pixel_theme.dart';

class PixelButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: color ?? PixelTheme.primary),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: color ?? PixelTheme.primary,
            fontSize: 13,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
