import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/fitness_cubit.dart';
import '../cubit/fitness_state.dart';
import '../models/workout_program_model.dart';
import '../widgets/favorite_button.dart';

class WorkoutDetailsScreen extends StatelessWidget {
  final WorkoutProgramModel workout;

  const WorkoutDetailsScreen({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FitnessCubit, FitnessState>(
      builder: (context, state) {
        WorkoutProgramModel currentWorkout = workout;
        if (state is FitnessSuccess) {
          currentWorkout = state.workoutPrograms.firstWhere(
            (w) => w.id == workout.id,
            orElse: () => workout,
          );
        }

        final cubit = context.read<FitnessCubit>();

        return Scaffold(
          backgroundColor: const Color(0xFF101115),
          body: Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      expandedHeight: 280,
                      pinned: true,
                      backgroundColor: const Color(0xFF101115),
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.black.withOpacity(0.5),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: FavoriteButton(
                            isFavorite: currentWorkout.isFavorite,
                            onTap: () => cubit.toggleFavoriteWorkout(currentWorkout.id),
                          ),
                        ),
                      ],
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              currentWorkout.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                color: const Color(0xFF1E222B),
                                child: const Icon(Icons.fitness_center, size: 60, color: Colors.grey),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    const Color(0xFF101115).withOpacity(0.9),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (currentWorkout.isPro)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF20C766),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.workspace_premium, size: 16, color: Colors.black),
                                    SizedBox(width: 4),
                                    Text(
                                      'MEMBRU PRO',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            const SizedBox(height: 12),
                            Text(
                              currentWorkout.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Metric Cards
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF1E222B),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: Colors.white10),
                                    ),
                                    child: Column(
                                      children: [
                                        const Icon(Icons.local_fire_department_rounded,
                                            color: Color(0xFFFF6B6B), size: 28),
                                        const SizedBox(height: 6),
                                        Text(
                                          '${currentWorkout.calories} kcal',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        const Text(
                                          'Calorii arse',
                                          style: TextStyle(
                                              color: Color(0xFF808A9B), fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF1E222B),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: Colors.white10),
                                    ),
                                    child: Column(
                                      children: [
                                        const Icon(Icons.access_time_rounded,
                                            color: Color(0xFF4D96FF), size: 28),
                                        const SizedBox(height: 6),
                                        Text(
                                          '${currentWorkout.durationMinutes} min',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        const Text(
                                          'Durată',
                                          style: TextStyle(
                                              color: Color(0xFF808A9B), fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 28),

                            const Text(
                              'Etapele Antrenamentului',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),

                            _buildExerciseStepTile('1', 'Încălzire și Stretches', '5 minute'),
                            _buildExerciseStepTile('2', 'Setul Principal de Exerciții', '${currentWorkout.durationMinutes - 10} minute'),
                            _buildExerciseStepTile('3', 'Relaxare și Recompresie', '5 minute'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Fixed Bottom Button
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xFF1E222B),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Sesiunea "${currentWorkout.title}" a început! Spor la mișcare!'),
                          backgroundColor: const Color(0xFF20C766),
                        ),
                      );
                    },
                    icon: const Icon(Icons.play_arrow_rounded, color: Colors.black, size: 28),
                    label: const Text(
                      'Începe Antrenamentul',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF20C766),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildExerciseStepTile(String index, String title, String duration) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1E222B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFF20C766).withOpacity(0.15),
            child: Text(
              index,
              style: const TextStyle(
                color: Color(0xFF20C766),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  duration,
                  style: const TextStyle(
                    color: Color(0xFF808A9B),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.check_circle_outline, color: Colors.white30),
        ],
      ),
    );
  }
}
