import 'package:flutter/material.dart';
import '../models/workout_program_model.dart';

class AddWorkoutDialog extends StatefulWidget {
  final ValueChanged<WorkoutProgramModel> onAdd;

  const AddWorkoutDialog({super.key, required this.onAdd});

  @override
  State<AddWorkoutDialog> createState() => _AddWorkoutDialogState();
}

class _AddWorkoutDialogState extends State<AddWorkoutDialog> {
  final _titleController = TextEditingController();
  final _caloriesController = TextEditingController(text: '200');
  final _durationController = TextEditingController(text: '45');
  bool _isPro = false;

  @override
  void dispose() {
    _titleController.dispose();
    _caloriesController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF1E222B),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      title: const Text(
        'Adaugă Antrenament Nou',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Titlu antrenament',
                labelStyle: TextStyle(color: Color(0xFF808A9B)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white24),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF20C766)),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _caloriesController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Calorii (kcal)',
                labelStyle: TextStyle(color: Color(0xFF808A9B)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white24),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF20C766)),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _durationController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Durată (minute)',
                labelStyle: TextStyle(color: Color(0xFF808A9B)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white24),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF20C766)),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              activeColor: const Color(0xFF20C766),
              title: const Text('Antrenament PRO', style: TextStyle(color: Colors.white)),
              value: _isPro,
              onChanged: (val) => setState(() => _isPro = val),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Anulează', style: TextStyle(color: Colors.grey)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF20C766),
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: () {
            final title = _titleController.text.trim();
            if (title.isEmpty) return;

            final calories = int.tryParse(_caloriesController.text) ?? 200;
            final duration = int.tryParse(_durationController.text) ?? 45;

            final newWorkout = WorkoutProgramModel(
              id: 'custom_${DateTime.now().millisecondsSinceEpoch}',
              title: title,
              calories: calories,
              durationMinutes: duration,
              isPro: _isPro,
              imageUrl: 'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?auto=format&fit=crop&w=600&q=85',
              icons: const WorkoutIcons(
                caloriesIconUrl: '',
                durationIconUrl: '',
              ),
            );

            widget.onAdd(newWorkout);
            Navigator.pop(context);
          },
          child: const Text('Adaugă', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
