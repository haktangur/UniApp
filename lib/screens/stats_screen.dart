import 'package:flutter/material.dart';
import '../state/stats_state.dart';
import '../theme/pixel_theme.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = StatsState();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: PixelTheme.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: PixelTheme.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '> İSTATİSTİK',
          style: TextStyle(
            color: PixelTheme.primary,
            letterSpacing: 2,
            fontSize: 14,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Özet kartlar
            Row(
              children: [
                _StatCard(
                  label: 'Seri',
                  value: '${state.streak} gün',
                  color: PixelTheme.accent,
                ),
                const SizedBox(width: 12),
                _StatCard(
                  label: 'Toplam',
                  value: state.totalFormatted,
                  color: PixelTheme.secondary,
                ),
                const SizedBox(width: 12),
                _StatCard(
                  label: 'Seans',
                  value:
                      '${state.weeklyData.where((d) => d.minutes > 0).length}',
                  color: PixelTheme.primary,
                ),
              ],
            ),
            const SizedBox(height: 28),
            const Text(
              'Bu Hafta',
              style: TextStyle(
                color: PixelTheme.textSecondary,
                fontSize: 12,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 12),
            // Bar chart
            _PixelBarChart(
              data: state.weeklyData,
              maxMinutes: state.maxMinutes,
            ),
            const SizedBox(height: 28),
            // Günlük detay listesi
            const Text(
              'Günlük Detay',
              style: TextStyle(
                color: PixelTheme.textSecondary,
                fontSize: 12,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: state.weeklyData.length,
                itemBuilder: (context, i) {
                  final d = state.weeklyData[i];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: PixelTheme.cardBackground,
                      border: Border.all(color: PixelTheme.border),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          d.label,
                          style: const TextStyle(
                            color: PixelTheme.textSecondary,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          d.minutes == 0
                              ? '-'
                              : '${d.minutes ~/ 60 > 0 ? "${d.minutes ~/ 60}s " : ""}${d.minutes % 60}dk',
                          style: TextStyle(
                            color: d.minutes > 0
                                ? PixelTheme.primary
                                : PixelTheme.border,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        decoration: BoxDecoration(
          color: PixelTheme.cardBackground,
          border: Border.all(color: color),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: PixelTheme.textSecondary,
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PixelBarChart extends StatelessWidget {
  final List<DayStats> data;
  final int maxMinutes;

  const _PixelBarChart({required this.data, required this.maxMinutes});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: data.map((d) {
          final ratio = maxMinutes == 0 ? 0.0 : d.minutes / maxMinutes;
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (d.minutes > 0)
                    Text(
                      '${d.minutes}',
                      style: const TextStyle(
                        color: PixelTheme.textSecondary,
                        fontSize: 9,
                      ),
                    ),
                  const SizedBox(height: 2),
                  _PixelBar(ratio: ratio),
                  const SizedBox(height: 4),
                  Text(
                    d.label,
                    style: const TextStyle(
                      color: PixelTheme.textSecondary,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _PixelBar extends StatelessWidget {
  final double ratio;

  const _PixelBar({required this.ratio});

  @override
  Widget build(BuildContext context) {
    const double blockHeight = 10;
    const double blockSpacing = 2;
    const double maxBarHeight = 100;

    final barHeight = (ratio * maxBarHeight).clamp(0.0, maxBarHeight);

    return SizedBox(
      height: maxBarHeight,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            (barHeight / (blockHeight + blockSpacing)).round(),
            (_) => Container(
              height: blockHeight,
              margin: const EdgeInsets.only(bottom: blockSpacing),
              color: PixelTheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}
