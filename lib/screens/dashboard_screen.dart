import 'package:flutter/material.dart';
import '../widgets/pixel_card.dart';
import '../widgets/mascot_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                      onTap: () {},
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
