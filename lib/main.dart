import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme/pixel_theme.dart';
import 'screens/dashboard_screen.dart';
import 'storage/storage_service.dart';
import 'storage/app_loader.dart';

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
      home: const _AppEntry(),
    );
  }
}

class _AppEntry extends ConsumerWidget {
  const _AppEntry();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loader = ref.watch(appLoaderProvider);

    return loader.when(
      loading: () => const Scaffold(
        body: Center(
          child: Text(
            '> Yükleniyor...',
            style: TextStyle(
              color: Color(0xFF00FF94),
              fontFamily: 'Courier',
              fontSize: 16,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
      error: (e, _) => Scaffold(
        body: Center(
          child: Text(
            '> Hata: $e',
            style: const TextStyle(
              color: Color(0xFFFF4444),
              fontFamily: 'Courier',
              fontSize: 13,
            ),
          ),
        ),
      ),
      data: (_) => const DashboardScreen(),
    );
  }
}
