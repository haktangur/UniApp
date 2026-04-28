import 'package:flutter/material.dart';
import 'theme/pixel_theme.dart';

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
      home: Scaffold(
        body: Center(
          child: Text(
            '> UniApp <',
            style: Theme.of(
              context,
            ).textTheme.displayLarge?.copyWith(color: PixelTheme.primary),
          ),
        ),
      ),
    );
  }
}
