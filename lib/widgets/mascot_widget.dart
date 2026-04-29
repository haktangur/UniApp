import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/app_state.dart';
import '../theme/pixel_theme.dart';

class MascotWidget extends ConsumerStatefulWidget {
  const MascotWidget({super.key});

  @override
  ConsumerState<MascotWidget> createState() => _MascotWidgetState();
}

class _MascotWidgetState extends ConsumerState<MascotWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounce;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _bounce = Tween<double>(
      begin: 0,
      end: 6,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  (String, String, Color) _moodData(MascotMood mood) {
    switch (mood) {
      case MascotMood.focusing:
        return ('(-_-)', '> Odaklanıyorum...', PixelTheme.secondary);
      case MascotMood.happy:
        return ('(^o^)', '> Harika gidiyorsun!', PixelTheme.accent);
      case MascotMood.sad:
        return ('(T_T)', '> Çalışmaya başla!', PixelTheme.danger);
      case MascotMood.idle:
        return ('(^_^)', _greeting(), PixelTheme.primary);
      case MascotMood.resting:
        return ('(ᴗ˳ᴗ)', '> Mola zamanı~', PixelTheme.secondary);
    }
  }

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return '> Günaydın!';
    if (hour < 18) return '> İyi günler!';
    return '> İyi akşamlar!';
  }

  @override
  Widget build(BuildContext context) {
    final mood = ref.watch(mascotMoodProvider);
    final (face, text, color) = _moodData(mood);

    return AnimatedBuilder(
      animation: _bounce,
      builder: (context, child) {
        final shouldBounce =
            mood == MascotMood.happy || mood == MascotMood.focusing;
        return Transform.translate(
          offset: Offset(0, shouldBounce ? -_bounce.value : 0),
          child: child,
        );
      },
      child: Column(
        children: [
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 400),
            style: TextStyle(color: color, fontSize: 32, fontFamily: 'Courier'),
            child: Text(face),
          ),
          const SizedBox(height: 8),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 400),
            style: TextStyle(
              color: color.withOpacity(0.8),
              fontSize: 13,
              fontFamily: 'Courier',
              letterSpacing: 1,
            ),
            child: Text(text),
          ),
        ],
      ),
    );
  }
}
