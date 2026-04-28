import 'package:flutter/material.dart';
import 'theme/pixel_theme.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(const UniApp());
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
