import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme/pixel_theme.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(const ProviderScope(child: UniApp()));
}

class UniApp extends StatelessWidget {
  const UniApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniApp',
      debugShowCheckedModeBanner: false,
      theme: PixelTheme.theme,
      home: const DashboardScreen(),
    );
  }
}
