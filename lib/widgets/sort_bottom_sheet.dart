import 'package:flutter/material.dart';
import '../cubit/fitness_state.dart';

class SortBottomSheet extends StatelessWidget {
  final SortOption currentOption;
  final ValueChanged<SortOption> onOptionSelected;

  const SortBottomSheet({
    super.key,
    required this.currentOption,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Color(0xFF1E222B),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Sortează antrenamentele',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white60),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildOptionTile(
            context: context,
            title: 'Fără sortare (Implicit)',
            option: SortOption.none,
            icon: Icons.refresh_rounded,
          ),
          _buildOptionTile(
            context: context,
            title: 'Durată: Scurt la Lung',
            option: SortOption.durationAsc,
            icon: Icons.timer_outlined,
          ),
          _buildOptionTile(
            context: context,
            title: 'Durată: Lung la Scurt',
            option: SortOption.durationDesc,
            icon: Icons.timer,
          ),
          _buildOptionTile(
            context: context,
            title: 'Calorii: Crescător',
            option: SortOption.caloriesAsc,
            icon: Icons.local_fire_department_outlined,
          ),
          _buildOptionTile(
            context: context,
            title: 'Calorii: Descrescător',
            option: SortOption.caloriesDesc,
            icon: Icons.local_fire_department,
          ),
          _buildOptionTile(
            context: context,
            title: 'Nume: A - Z',
            option: SortOption.titleAsc,
            icon: Icons.sort_by_alpha,
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildOptionTile({
    required BuildContext context,
    required String title,
    required SortOption option,
    required IconData icon,
  }) {
    final isSelected = currentOption == option;
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? const Color(0xFF20C766) : const Color(0xFF808A9B),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? const Color(0xFF20C766) : Colors.white,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: isSelected
          ? const Icon(Icons.check_circle, color: Color(0xFF20C766))
          : null,
      onTap: () {
        onOptionSelected(option);
        Navigator.pop(context);
      },
    );
  }
}
