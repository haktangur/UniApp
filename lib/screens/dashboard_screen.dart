import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/pixel_theme.dart';
import '../widgets/pixel_card.dart';
import '../widgets/mascot_widget.dart';
import 'gpa_screen.dart';
import 'pomodoro_screen.dart';
import 'calendar_screen.dart';
import 'stats_screen.dart';

class MainShell extends ConsumerStatefulWidget {
  const MainShell({super.key});

  @override
  ConsumerState<MainShell> createState() => _MainShellState();
}

class _MainShellState extends ConsumerState<MainShell> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    _HomeTab(),
    PomodoroScreen(),
    CalendarScreen(),
    StatsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: PixelTheme.border)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          backgroundColor: PixelTheme.background,
          selectedItemColor: PixelTheme.primary,
          unselectedItemColor: PixelTheme.textSecondary,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 20),
              label: 'Ana Sayfa',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timer, size: 20),
              label: 'Pomodoro',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month, size: 20),
              label: 'Takvim',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart, size: 20),
              label: 'İstatistik',
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeTab extends ConsumerWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cards = [
      {
        'title': 'GPA',
        'icon': '📊',
        'preview': 'Not hesapla',
        'screen': const GpaScreen(),
      },
      {
        'title': 'Pomodoro',
        'icon': '🍅',
        'preview': 'Odaklan',
        'screen': const PomodoroScreen(),
      },
      {
        'title': 'Takvim',
        'icon': '📅',
        'preview': 'Sınavların',
        'screen': const CalendarScreen(),
      },
      {
        'title': 'İstatistik',
        'icon': '📈',
        'preview': 'Genel bakış',
        'screen': const StatsScreen(),
      },
    ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const MascotWidget(),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: cards.map((card) {
                  return PixelCard(
                    title: card['title'] as String,
                    icon: card['icon'] as String,
                    preview: card['preview'] as String,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => card['screen'] as Widget,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainShell();
  }
}
