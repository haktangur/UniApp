import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/app_state.dart';
import '../state/pomodoro_state.dart';
import '../widgets/pixel_button.dart';
import '../widgets/pixel_progress_bar.dart';
import '../theme/pixel_theme.dart';

class PomodoroScreen extends ConsumerWidget {
  const PomodoroScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pomodoroProvider);
    final isFocus = state.mode == PomodoroMode.focus;
    final bgColor = isFocus ? PixelTheme.background : const Color(0xFF0D1A0D);
    final accentColor = isFocus ? PixelTheme.primary : PixelTheme.secondary;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: accentColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isFocus ? '> ODAK' : '> MOLA',
          style: TextStyle(color: accentColor, letterSpacing: 2, fontSize: 14),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              state.timeString,
              style: TextStyle(
                color: accentColor,
                fontSize: 72,
                fontWeight: FontWeight.bold,
                letterSpacing: 4,
              ),
            ),
            const SizedBox(height: 32),
            PixelProgressBar(progress: state.progress),
            const SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PixelButton(
                  label: state.isRunning ? 'DURDUR' : 'BAŞLAT',
                  color: accentColor,
                  onTap: state.isRunning ? state.pause : state.start,
                ),
                const SizedBox(width: 16),
                PixelButton(
                  label: 'SIFIRLA',
                  color: PixelTheme.textSecondary,
                  onTap: state.reset,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
