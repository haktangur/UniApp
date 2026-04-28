import 'package:flutter/material.dart';
import '../theme/pixel_theme.dart';

class PixelProgressBar extends StatelessWidget {
  final double progress; // 0.0 - 1.0

  const PixelProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final totalBlocks = 20;
        final filledBlocks = (progress * totalBlocks).round();
        return Row(
          children: List.generate(totalBlocks, (i) {
            return Expanded(
              child: Container(
                height: 16,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                color: i < filledBlocks
                    ? PixelTheme.primary
                    : PixelTheme.border,
              ),
            );
          }),
        );
      },
    );
  }
}
