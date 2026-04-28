import 'package:flutter/material.dart';
import '../state/gpa_state.dart';
import '../theme/pixel_theme.dart';
import '../widgets/pixel_button.dart';

class GpaScreen extends StatefulWidget {
  const GpaScreen({super.key});

  @override
  State<GpaScreen> createState() => _GpaScreenState();
}

class _GpaScreenState extends State<GpaScreen> {
  final GpaState _state = GpaState();

  @override
  void initState() {
    super.initState();
    _state.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PixelTheme.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: PixelTheme.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '> GPA',
          style: TextStyle(
            color: PixelTheme.primary,
            letterSpacing: 2,
            fontSize: 14,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _state.courses.length,
              itemBuilder: (context, i) => _CourseRow(
                course: _state.courses[i],
                onNameChanged: (v) => _state.updateName(i, v),
                onGradeChanged: (v) => _state.updateGrade(i, v!),
                onCreditChanged: (v) =>
                    _state.updateCredit(i, int.tryParse(v) ?? 3),
                onRemove: () => _state.removeCourse(i),
              ),
            ),
          ),
          _BottomBar(gpa: _state.gpa, onAdd: _state.addCourse),
        ],
      ),
    );
  }
}

class _CourseRow extends StatelessWidget {
  final Course course;
  final ValueChanged<String> onNameChanged;
  final ValueChanged<String?> onGradeChanged;
  final ValueChanged<String> onCreditChanged;
  final VoidCallback onRemove;

  const _CourseRow({
    required this.course,
    required this.onNameChanged,
    required this.onGradeChanged,
    required this.onCreditChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: PixelTheme.cardBackground,
        border: Border.all(color: PixelTheme.border),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: TextField(
              onChanged: onNameChanged,
              style: const TextStyle(
                color: PixelTheme.textPrimary,
                fontSize: 13,
              ),
              decoration: const InputDecoration(
                hintText: 'Ders adı',
                hintStyle: TextStyle(
                  color: PixelTheme.textSecondary,
                  fontSize: 12,
                ),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          const SizedBox(width: 8),
          DropdownButton<String>(
            value: course.grade,
            dropdownColor: PixelTheme.cardBackground,
            style: const TextStyle(color: PixelTheme.primary, fontSize: 13),
            underline: const SizedBox(),
            items: gradePoints.keys
                .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                .toList(),
            onChanged: onGradeChanged,
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 36,
            child: TextField(
              onChanged: onCreditChanged,
              keyboardType: TextInputType.number,
              style: const TextStyle(
                color: PixelTheme.textPrimary,
                fontSize: 13,
              ),
              decoration: const InputDecoration(
                hintText: 'Kr',
                hintStyle: TextStyle(
                  color: PixelTheme.textSecondary,
                  fontSize: 12,
                ),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onRemove,
            child: const Icon(Icons.close, color: PixelTheme.danger, size: 16),
          ),
        ],
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  final double gpa;
  final VoidCallback onAdd;

  const _BottomBar({required this.gpa, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: PixelTheme.border)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'GPA: ${gpa.toStringAsFixed(2)}',
            style: const TextStyle(
              color: PixelTheme.accent,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          PixelButton(label: '+ DERS', onTap: onAdd),
        ],
      ),
    );
  }
}
