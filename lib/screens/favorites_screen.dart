import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/fitness_cubit.dart';
import '../cubit/fitness_state.dart';
import '../widgets/workout_card.dart';
import '../widgets/featured_plan_card.dart';
import '../widgets/state_views.dart';
import 'workout_details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101115),
      appBar: AppBar(
        backgroundColor: const Color(0xFF101115),
        elevation: 0,
        title: const Text(
          'Elemente Favorite',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<FitnessCubit, FitnessState>(
        builder: (context, state) {
          if (state is! FitnessSuccess) {
            return const LoadingStateView();
          }

          final cubit = context.read<FitnessCubit>();
          final favWorkouts = state.workoutPrograms.where((w) => w.isFavorite).toList();
          final favPlans = state.featuredPlans.where((p) => p.isFavorite).toList();
          final isGymFav = state.gym.isFavorite;

          if (favWorkouts.isEmpty && favPlans.isEmpty && !isGymFav) {
            return const EmptyStateView(
              message: 'Nu ai adăugat încă niciun element la favorite.',
            );
          }

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              if (isGymFav) ...[
                const Text(
                  'Sală de sport favorită',
                  style: TextStyle(
                    color: Color(0xFF808A9B),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E222B),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          state.gym.heroImageUrl,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.gym.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              state.gym.location,
                              style: const TextStyle(
                                color: Color(0xFF808A9B),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.favorite, color: Color(0xFFFF4D4D)),
                        onPressed: () => cubit.toggleFavoriteGym(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],

              if (favPlans.isNotEmpty) ...[
                const Text(
                  'Planuri Recomandate Favorite',
                  style: TextStyle(
                    color: Color(0xFF808A9B),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 220,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: favPlans.length,
                    itemBuilder: (context, index) {
                      final plan = favPlans[index];
                      return FeaturedPlanCard(
                        plan: plan,
                        onActionTap: () {},
                        onFavoriteTap: () => cubit.toggleFavoritePlan(plan.id),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
              ],

              if (favWorkouts.isNotEmpty) ...[
                const Text(
                  'Programe de Antrenament Favorite',
                  style: TextStyle(
                    color: Color(0xFF808A9B),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 10),
                ...favWorkouts.map((workout) {
                  return WorkoutCard(
                    workout: workout,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: cubit,
                            child: WorkoutDetailsScreen(workout: workout),
                          ),
                        ),
                      );
                    },
                    onFavoriteTap: () => cubit.toggleFavoriteWorkout(workout.id),
                  );
                }),
              ],
            ],
          );
        },
      ),
    );
  }
}
