import 'package:flutter/material.dart';
import '../theme/pixel_theme.dart';

class PixelCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: PixelTheme.cardBackground,
          border: Border.all(color: PixelTheme.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(icon, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: PixelTheme.primary,
                fontSize: 13,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            const Spacer(),
            Text(
              preview,
              style: const TextStyle(
                color: PixelTheme.textSecondary,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
