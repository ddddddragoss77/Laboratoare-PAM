import 'package:flutter/material.dart';
import '../models/workout_filter_model.dart';

class CategoryFilterBar extends StatelessWidget {
  final List<WorkoutFilterModel> filters;
  final String selectedFilterId;
  final ValueChanged<String> onSelected;

  const CategoryFilterBar({
    super.key,
    required this.filters,
    required this.selectedFilterId,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = filter.id == selectedFilterId;

          return InkWell(
            onTap: () => onSelected(filter.id),
            borderRadius: BorderRadius.circular(24),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF20C766) : const Color(0xFF1E222B),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isSelected ? const Color(0xFF20C766) : Colors.white10,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    _getCategoryIcon(filter.id),
                    size: 18,
                    color: isSelected ? Colors.black : const Color(0xFF808A9B),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    filter.name,
                    style: TextStyle(
                      color: isSelected ? Colors.black : Colors.white,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  IconData _getCategoryIcon(String id) {
    switch (id) {
      case 'all':
        return Icons.grid_view_rounded;
      case 'pilates':
        return Icons.self_improvement_rounded;
      case 'cardio':
        return Icons.favorite_rounded;
      case 'boxing':
        return Icons.sports_mma_rounded;
      case 'yoga':
        return Icons.nature_people_rounded;
      default:
        return Icons.fitness_center_rounded;
    }
  }
}
