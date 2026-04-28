import 'package:flutter/material.dart';
import '../theme/pixel_theme.dart';

class MascotWidget extends StatelessWidget {
  const MascotWidget({super.key});

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return '> Günaydın!';
    if (hour < 18) return '> İyi günler!';
    return '> İyi akşamlar!';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          '(^_^)',
          style: TextStyle(color: PixelTheme.primary, fontSize: 32),
        ),
        const SizedBox(height: 8),
        Text(
          _greeting(),
          style: const TextStyle(
            color: PixelTheme.textSecondary,
            fontSize: 14,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}
