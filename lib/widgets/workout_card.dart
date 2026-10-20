import 'package:flutter/material.dart';
import '../models/workout_program_model.dart';
import 'favorite_button.dart';

class WorkoutCard extends StatelessWidget {
  final WorkoutProgramModel workout;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;
  final VoidCallback? onDeleteTap;

  const WorkoutCard({
    super.key,
    required this.workout,
    required this.onTap,
    required this.onFavoriteTap,
    this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E222B),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Image container with Pro badge
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  width: 90,
                  height: 90,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          workout.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: const Color(0xFF2C313E),
                            child: const Icon(Icons.fitness_center, color: Colors.grey),
                          ),
                        ),
                      ),
                      if (workout.isPro)
                        Positioned(
                          top: 6,
                          left: 6,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFF20C766),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.workspace_premium, size: 12, color: Colors.black),
                                SizedBox(width: 2),
                                Text(
                                  'PRO',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 14),

              // Title and metrics
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      workout.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.local_fire_department_rounded,
                            size: 16, color: Color(0xFFFF6B6B)),
                        const SizedBox(width: 4),
                        Text(
                          '${workout.calories} kcal',
                          style: const TextStyle(color: Color(0xFF808A9B), fontSize: 13),
                        ),
                        const SizedBox(width: 14),
                        const Icon(Icons.access_time_rounded,
                            size: 16, color: Color(0xFF4D96FF)),
                        const SizedBox(width: 4),
                        Text(
                          '${workout.durationMinutes} min',
                          style: const TextStyle(color: Color(0xFF808A9B), fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Actions: Favorite + optional Delete
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FavoriteButton(
                    isFavorite: workout.isFavorite,
                    onTap: onFavoriteTap,
                    size: 20,
                  ),
                  if (onDeleteTap != null) ...[
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: onDeleteTap,
                      child: const Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(Icons.delete_outline_rounded,
                            color: Colors.white38, size: 20),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
