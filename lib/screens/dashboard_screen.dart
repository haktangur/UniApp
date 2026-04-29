import 'package:flutter/material.dart';
import '../widgets/pixel_card.dart';
import '../widgets/mascot_widget.dart';
import 'pomodoro_screen.dart';
import 'gpa_screen.dart';
import 'calendar_screen.dart';
import 'stats_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cards = [
      {'title': 'GPA', 'icon': '📊', 'preview': 'Not hesapla'},
      {'title': 'Pomodoro', 'icon': '🍅', 'preview': 'Odaklan'},
      {'title': 'Takvim', 'icon': '📅', 'preview': 'Sınavların'},
      {'title': 'İstatistik', 'icon': '📈', 'preview': 'Genel bakış'},
    ];

    return Scaffold(
      body: SafeArea(
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
                      title: card['title']!,
                      icon: card['icon']!,
                      preview: card['preview']!,
                      onTap: card['title'] == 'Pomodoro'
                          ? () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const PomodoroScreen(),
                              ),
                            )
                          : card['title'] == 'GPA'
                          ? () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const GpaScreen(),
                              ),
                            )
                          : card['title'] == 'Takvim'
                          ? () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const CalendarScreen(),
                              ),
                            )
                          : card['title'] == 'İstatistik'
                          ? () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const StatsScreen(),
                              ),
                            )
                          : () {},
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
