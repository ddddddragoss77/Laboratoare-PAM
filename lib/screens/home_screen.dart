import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/fitness_cubit.dart';
import '../cubit/fitness_state.dart';
import '../widgets/app_search_bar.dart';
import '../widgets/category_filter_bar.dart';
import '../widgets/todays_challenge_card.dart';
import '../widgets/featured_plan_card.dart';
import '../widgets/workout_card.dart';
import '../widgets/state_views.dart';
import '../widgets/sort_bottom_sheet.dart';
import '../widgets/add_workout_dialog.dart';
import 'gym_details_screen.dart';
import 'workout_details_screen.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101115),
      body: SafeArea(
        child: BlocBuilder<FitnessCubit, FitnessState>(
          builder: (context, state) {
            if (state is FitnessInitial || state is FitnessLoading) {
              return const LoadingStateView();
            }

            if (state is FitnessError) {
              return ErrorStateView(
                message: state.message,
                onRetry: () => context.read<FitnessCubit>().fetchFitnessData(),
              );
            }

            if (state is FitnessEmpty) {
              return EmptyStateView(
                message: state.message,
                actionLabel: 'Reîncarcă datele',
                onAction: () => context.read<FitnessCubit>().fetchFitnessData(),
              );
            }

            if (state is FitnessSuccess) {
              return _buildHomeContent(context, state);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildHomeContent(BuildContext context, FitnessSuccess state) {
    final cubit = context.read<FitnessCubit>();
    final filteredWorkouts = state.filteredWorkouts;

    return RefreshIndicator(
      color: const Color(0xFF20C766),
      backgroundColor: const Color(0xFF1E222B),
      onRefresh: () => cubit.fetchFitnessData(),
      child: CustomScrollView(
        slivers: [
          // App Bar Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.header.date.toUpperCase(),
                        style: const TextStyle(
                          color: Color(0xFF808A9B),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        state.header.greeting,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      // Favorites Button with counter badge
                      Stack(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.favorite_rounded,
                                color: Color(0xFFFF4D4D), size: 28),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                    value: cubit,
                                    child: const FavoritesScreen(),
                                  ),
                                ),
                              );
                            },
                          ),
                          if (state.totalFavoritesCount > 0)
                            Positioned(
                              right: 6,
                              top: 6,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Color(0xFF20C766),
                                  shape: BoxShape.circle,
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 18,
                                  minHeight: 18,
                                ),
                                child: Text(
                                  '${state.totalFavoritesCount}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(width: 4),

                      // Popup Menu to simulate all Lab core states (Loading, Error, Empty, Success)
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.tune_sharp, color: Colors.white70),
                        tooltip: 'Testare Stări Aplicație',
                        color: const Color(0xFF1E222B),
                        onSelected: (value) {
                          if (value == 'loading') {
                            cubit.fetchFitnessData();
                          } else if (value == 'error') {
                            cubit.fetchFitnessData(simulateError: true);
                          } else if (value == 'empty') {
                            cubit.fetchFitnessData(simulateEmpty: true);
                          } else if (value == 'add') {
                            showDialog(
                              context: context,
                              builder: (_) => AddWorkoutDialog(
                                onAdd: (workout) => cubit.addWorkoutProgram(workout),
                              ),
                            );
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'loading',
                            child: Row(
                              children: [
                                Icon(Icons.refresh, color: Color(0xFF20C766)),
                                SizedBox(width: 8),
                                Text('Simulează Loading',
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'error',
                            child: Row(
                              children: [
                                Icon(Icons.error_outline, color: Colors.redAccent),
                                SizedBox(width: 8),
                                Text('Simulează Error',
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'empty',
                            child: Row(
                              children: [
                                Icon(Icons.inbox, color: Colors.orangeAccent),
                                SizedBox(width: 8),
                                Text('Simulează Empty',
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                          const PopupMenuDivider(height: 1),
                          const PopupMenuItem(
                            value: 'add',
                            child: Row(
                              children: [
                                Icon(Icons.add_circle_outline, color: Color(0xFF20C766)),
                                SizedBox(width: 8),
                                Text('Adaugă Antrenament',
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Search Bar
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: AppSearchBar(
                controller: _searchController,
                onChanged: (query) => cubit.updateSearchQuery(query),
                onClear: () => cubit.updateSearchQuery(''),
                onFilterTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (_) => SortBottomSheet(
                      currentOption: state.sortOption,
                      onOptionSelected: (option) => cubit.updateSortOption(option),
                    ),
                  );
                },
              ),
            ),
          ),

          // Today's Challenge Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              child: TodaysChallengeCard(challenge: state.todaysChallenge),
            ),
          ),

          // Gym Banner Quick Access
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: cubit,
                        child: GymDetailsScreen(gym: state.gym),
                      ),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(20),
                child: Container(
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
                          errorBuilder: (_, __, ___) => Container(
                            color: Colors.grey,
                            width: 60,
                            height: 60,
                            child: const Icon(Icons.fitness_center),
                          ),
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
                            Row(
                              children: [
                                const Icon(Icons.location_on, size: 14, color: Color(0xFF808A9B)),
                                const SizedBox(width: 2),
                                Expanded(
                                  child: Text(
                                    state.gym.location,
                                    style: const TextStyle(
                                      color: Color(0xFF808A9B),
                                      fontSize: 13,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios_rounded,
                          color: Color(0xFF20C766), size: 18),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Featured Plans Title
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
              child: Text(
                'Planuri Recomandate',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Featured Plans Horizontal List
          SliverToBoxAdapter(
            child: SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: state.featuredPlans.length,
                itemBuilder: (context, index) {
                  final plan = state.featuredPlans[index];
                  return FeaturedPlanCard(
                    plan: plan,
                    onActionTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Planul "${plan.title}" a fost inițiat!'),
                          backgroundColor: const Color(0xFF20C766),
                        ),
                      );
                    },
                    onFavoriteTap: () => cubit.toggleFavoritePlan(plan.id),
                  );
                },
              ),
            ),
          ),

          // Workout Programs Title & Sorting header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Programe de Antrenament',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (_) => SortBottomSheet(
                          currentOption: state.sortOption,
                          onOptionSelected: (option) => cubit.updateSortOption(option),
                        ),
                      );
                    },
                    icon: const Icon(Icons.sort_rounded, color: Color(0xFF20C766), size: 18),
                    label: const Text(
                      'Sortează',
                      style: TextStyle(
                        color: Color(0xFF20C766),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Category Filters Chips
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: CategoryFilterBar(
                filters: state.filters,
                selectedFilterId: state.selectedFilterId,
                onSelected: (filterId) => cubit.selectFilter(filterId),
              ),
            ),
          ),

          // Workout Programs List or Empty Filter View
          if (filteredWorkouts.isEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: EmptyStateView(
                  message: state.searchQuery.isNotEmpty
                      ? 'Niciun rezultat pentru "${state.searchQuery}"'
                      : 'Niciun antrenament găsit în această categorie.',
                  actionLabel: 'Resetează filtrele',
                  onAction: () {
                    _searchController.clear();
                    cubit.updateSearchQuery('');
                    cubit.selectFilter('all');
                  },
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final workout = filteredWorkouts[index];
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
                      onDeleteTap: () => cubit.removeWorkoutProgram(workout.id),
                    );
                  },
                  childCount: filteredWorkouts.length,
                ),
              ),
            ),

          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }
}
