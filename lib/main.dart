import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme/pixel_theme.dart';
import 'screens/dashboard_screen.dart';
import 'storage/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
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
