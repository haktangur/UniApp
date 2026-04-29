import 'package:flutter/material.dart';
import '../theme/pixel_theme.dart';

class PixelProgressBar extends StatelessWidget {
  final double progress;

  const PixelProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    const totalBlocks = 20;
    final filledBlocks = (progress * totalBlocks).clamp(0, totalBlocks).round();

    return Row(
      children: List.generate(totalBlocks, (i) {
        final filled = i < filledBlocks;
        return Expanded(
          child: Container(
            height: 14,
            margin: const EdgeInsets.symmetric(horizontal: 1.5),
            color: filled ? PixelTheme.primary : PixelTheme.border,
          ),
        );
      }),
    );
  }
}
