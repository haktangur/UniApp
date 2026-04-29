import 'package:flutter/material.dart';
import '../state/calendar_state.dart';
import '../theme/pixel_theme.dart';
import '../widgets/pixel_button.dart';

enum CalendarView { day, month, year }

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final CalendarState _state = CalendarState();
  final _controller = TextEditingController();
  late DateTime _viewMonth;
  int _viewYear = DateTime.now().year;
  CalendarView _view = CalendarView.day;

  final List<String> _months = [
    'Ocak',
    'Şubat',
    'Mart',
    'Nisan',
    'Mayıs',
    'Haziran',
    'Temmuz',
    'Ağustos',
    'Eylül',
    'Ekim',
    'Kasım',
    'Aralık',
  ];

  @override
  void initState() {
    super.initState();
    _viewMonth = DateTime(DateTime.now().year, DateTime.now().month);
    _state.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _state.dispose();
    _controller.dispose();
    super.dispose();
  }

  List<DateTime?> _buildDays() {
    final first = DateTime(_viewMonth.year, _viewMonth.month, 1);
    final last = DateTime(_viewMonth.year, _viewMonth.month + 1, 0);
    final List<DateTime?> days = [];
    for (int i = 0; i < first.weekday % 7; i++) {
      days.add(null);
    }
    for (int i = 1; i <= last.day; i++) {
      days.add(DateTime(_viewMonth.year, _viewMonth.month, i));
    }
    return days;
  }

  void _showAddEvent() {
    _controller.clear();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: PixelTheme.cardBackground,
        title: const Text(
          'Etkinlik Ekle',
          style: TextStyle(color: PixelTheme.primary, fontSize: 14),
        ),
        content: TextField(
          controller: _controller,
          autofocus: true,
          style: const TextStyle(color: PixelTheme.textPrimary, fontSize: 13),
          decoration: const InputDecoration(
            hintText: 'Etkinlik adı',
            hintStyle: TextStyle(color: PixelTheme.textSecondary),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: PixelTheme.border),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: PixelTheme.primary),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'İptal',
              style: TextStyle(color: PixelTheme.textSecondary),
            ),
          ),
          TextButton(
            onPressed: () {
              _state.addEvent(_state.selectedDay, _controller.text);
              Navigator.pop(context);
            },
            child: const Text(
              'Ekle',
              style: TextStyle(color: PixelTheme.primary),
            ),
          ),
        ],
      ),
    );
  }

  // ── GÖRÜNÜMLER ──────────────────────────────────────────

  Widget _buildYearView() {
    final now = DateTime.now();
    final years = List.generate(21, (i) => now.year - 10 + i);

    return Column(
      children: [
        const SizedBox(height: 8),
        Expanded(
          child: GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 2,
            children: years.map((y) {
              final isSelected = y == _viewYear;
              final isCurrent = y == now.year;
              return GestureDetector(
                onTap: () => setState(() {
                  _viewYear = y;
                  _view = CalendarView.month;
                }),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? PixelTheme.primary
                        : PixelTheme.cardBackground,
                    border: Border.all(
                      color: isCurrent ? PixelTheme.accent : PixelTheme.border,
                    ),
                  ),
                  child: Text(
                    '$y',
                    style: TextStyle(
                      color: isSelected
                          ? PixelTheme.background
                          : isCurrent
                          ? PixelTheme.accent
                          : PixelTheme.textPrimary,
                      fontSize: 13,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildMonthView() {
    final now = DateTime.now();
    return Column(
      children: [
        const SizedBox(height: 8),
        Expanded(
          child: GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 2,
            children: List.generate(12, (i) {
              final isSelected =
                  i + 1 == _viewMonth.month && _viewYear == _viewMonth.year;
              final isCurrent = i + 1 == now.month && _viewYear == now.year;
              return GestureDetector(
                onTap: () => setState(() {
                  _viewMonth = DateTime(_viewYear, i + 1);
                  _view = CalendarView.day;
                }),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? PixelTheme.primary
                        : PixelTheme.cardBackground,
                    border: Border.all(
                      color: isCurrent ? PixelTheme.accent : PixelTheme.border,
                    ),
                  ),
                  child: Text(
                    _months[i],
                    style: TextStyle(
                      color: isSelected
                          ? PixelTheme.background
                          : isCurrent
                          ? PixelTheme.accent
                          : PixelTheme.textPrimary,
                      fontSize: 12,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildDayView() {
    final days = _buildDays();
    final events = _state.eventsFor(_state.selectedDay);

    return Column(
      children: [
        // Gün başlıkları
        Row(
          children: ['Pz', 'Pt', 'Sa', 'Ça', 'Pe', 'Cu', 'Ct']
              .map(
                (d) => Expanded(
                  child: Center(
                    child: Text(
                      d,
                      style: const TextStyle(
                        color: PixelTheme.textSecondary,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 8),
        // Takvim grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
          ),
          itemCount: days.length,
          itemBuilder: (context, i) {
            final day = days[i];
            if (day == null) return const SizedBox();
            final isSelected =
                day.day == _state.selectedDay.day &&
                day.month == _state.selectedDay.month &&
                day.year == _state.selectedDay.year;
            final isToday =
                day.day == DateTime.now().day &&
                day.month == DateTime.now().month &&
                day.year == DateTime.now().year;
            final hasEvent = _state.hasEvents(day);

            return GestureDetector(
              onTap: () => _state.selectDay(day),
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected
                      ? PixelTheme.primary
                      : PixelTheme.cardBackground,
                  border: Border.all(
                    color: isToday ? PixelTheme.accent : PixelTheme.border,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${day.day}',
                      style: TextStyle(
                        color: isSelected
                            ? PixelTheme.background
                            : PixelTheme.textPrimary,
                        fontSize: 11,
                      ),
                    ),
                    if (hasEvent)
                      Container(
                        width: 4,
                        height: 4,
                        color: isSelected
                            ? PixelTheme.background
                            : PixelTheme.accent,
                      ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        // Etkinlik başlığı
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${_state.selectedDay.day} ${_months[_state.selectedDay.month - 1]}',
              style: const TextStyle(
                color: PixelTheme.textSecondary,
                fontSize: 12,
              ),
            ),
            PixelButton(label: '+ ETKİNLİK', onTap: _showAddEvent),
          ],
        ),
        const SizedBox(height: 8),
        // Etkinlik listesi
        Expanded(
          child: events.isEmpty
              ? const Center(
                  child: Text(
                    'Etkinlik yok',
                    style: TextStyle(
                      color: PixelTheme.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, i) => Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: PixelTheme.cardBackground,
                      border: Border.all(color: PixelTheme.border),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          events[i],
                          style: const TextStyle(
                            color: PixelTheme.textPrimary,
                            fontSize: 13,
                          ),
                        ),
                        GestureDetector(
                          onTap: () =>
                              _state.removeEvent(_state.selectedDay, i),
                          child: const Icon(
                            Icons.close,
                            color: PixelTheme.danger,
                            size: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  // ── BAŞLIK ───────────────────────────────────────────────

  Widget _buildHeader() {
    String title;
    if (_view == CalendarView.day) {
      title = '${_months[_viewMonth.month - 1]} ${_viewMonth.year}';
    } else if (_view == CalendarView.month) {
      title = '$_viewYear';
    } else {
      title = 'Yıl Seç';
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (_view == CalendarView.day)
          GestureDetector(
            onTap: () => setState(
              () =>
                  _viewMonth = DateTime(_viewMonth.year, _viewMonth.month - 1),
            ),
            child: const Icon(Icons.chevron_left, color: PixelTheme.primary),
          )
        else
          const SizedBox(width: 24),
        GestureDetector(
          onTap: () => setState(() {
            if (_view == CalendarView.day) {
              _viewYear = _viewMonth.year;
              _view = CalendarView.month;
            } else if (_view == CalendarView.month) {
              _view = CalendarView.year;
            }
          }),
          child: Text(
            title,
            style: const TextStyle(
              color: PixelTheme.primary,
              fontSize: 14,
              letterSpacing: 1,
              decoration: TextDecoration.underline,
              decorationColor: PixelTheme.primary,
            ),
          ),
        ),
        if (_view == CalendarView.day)
          GestureDetector(
            onTap: () => setState(
              () =>
                  _viewMonth = DateTime(_viewMonth.year, _viewMonth.month + 1),
            ),
            child: const Icon(Icons.chevron_right, color: PixelTheme.primary),
          )
        else
          const SizedBox(width: 24),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PixelTheme.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: PixelTheme.primary),
          onPressed: () {
            if (_view != CalendarView.day) {
              setState(
                () => _view = _view == CalendarView.year
                    ? CalendarView.month
                    : CalendarView.day,
              );
            } else {
              Navigator.pop(context);
            }
          },
        ),
        title: const Text(
          '> TAKVİM',
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
          children: [
            _buildHeader(),
            const SizedBox(height: 12),
            Expanded(
              child: _view == CalendarView.day
                  ? _buildDayView()
                  : _view == CalendarView.month
                  ? _buildMonthView()
                  : _buildYearView(),
            ),
          ],
        ),
      ),
    );
  }
}
