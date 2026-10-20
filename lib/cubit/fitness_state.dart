import 'package:equatable/equatable.dart';
import '../models/header_model.dart';
import '../models/todays_challenge_model.dart';
import '../models/featured_plan_model.dart';
import '../models/workout_program_model.dart';
import '../models/workout_filter_model.dart';
import '../models/gym_model.dart';

enum SortOption {
  none,
  durationAsc,
  durationDesc,
  caloriesAsc,
  caloriesDesc,
  titleAsc,
}

abstract class FitnessState extends Equatable {
  const FitnessState();

  @override
  List<Object?> get props => [];
}

class FitnessInitial extends FitnessState {}

class FitnessLoading extends FitnessState {}

class FitnessError extends FitnessState {
  final String message;

  const FitnessError(this.message);

  @override
  List<Object?> get props => [message];
}

class FitnessEmpty extends FitnessState {
  final String message;
  final String searchQuery;
  final String selectedFilterId;

  const FitnessEmpty({
    required this.message,
    this.searchQuery = '',
    this.selectedFilterId = 'all',
  });

  @override
  List<Object?> get props => [message, searchQuery, selectedFilterId];
}

class FitnessSuccess extends FitnessState {
  final HeaderModel header;
  final TodaysChallengeModel todaysChallenge;
  final List<FeaturedPlanModel> featuredPlans;
  final List<WorkoutFilterModel> filters;
  final List<WorkoutProgramModel> workoutPrograms;
  final GymModel gym;

  final String searchQuery;
  final String selectedFilterId;
  final SortOption sortOption;
  final bool showFavoritesOnly;

  const FitnessSuccess({
    required this.header,
    required this.todaysChallenge,
    required this.featuredPlans,
    required this.filters,
    required this.workoutPrograms,
    required this.gym,
    this.searchQuery = '',
    this.selectedFilterId = 'all',
    this.sortOption = SortOption.none,
    this.showFavoritesOnly = false,
  });

  /// Computes the active displayed list based on search, category filter, favorites filter, and sorting.
  List<WorkoutProgramModel> get filteredWorkouts {
    List<WorkoutProgramModel> result = List.from(workoutPrograms);

    // Filter by Category
    if (selectedFilterId != 'all') {
      result = result.where((item) {
        final categoryLower = selectedFilterId.toLowerCase();
        final titleLower = item.title.toLowerCase();
        return titleLower.contains(categoryLower);
      }).toList();
    }

    // Filter by Search query
    if (searchQuery.trim().isNotEmpty) {
      final queryLower = searchQuery.trim().toLowerCase();
      result = result.where((item) {
        return item.title.toLowerCase().contains(queryLower);
      }).toList();
    }

    // Filter by Favorites
    if (showFavoritesOnly) {
      result = result.where((item) => item.isFavorite).toList();
    }

    // Apply Sorting
    switch (sortOption) {
      case SortOption.durationAsc:
        result.sort((a, b) => a.durationMinutes.compareTo(b.durationMinutes));
        break;
      case SortOption.durationDesc:
        result.sort((a, b) => b.durationMinutes.compareTo(a.durationMinutes));
        break;
      case SortOption.caloriesAsc:
        result.sort((a, b) => a.calories.compareTo(b.calories));
        break;
      case SortOption.caloriesDesc:
        result.sort((a, b) => b.calories.compareTo(a.calories));
        break;
      case SortOption.titleAsc:
        result.sort((a, b) => a.title.compareTo(b.title));
        break;
      case SortOption.none:
        break;
    }

    return result;
  }

  /// Get count of favorite items across workouts, plans, and gym.
  int get totalFavoritesCount {
    int count = workoutPrograms.where((w) => w.isFavorite).length;
    count += featuredPlans.where((p) => p.isFavorite).length;
    if (gym.isFavorite) count += 1;
    return count;
  }

  FitnessSuccess copyWith({
    HeaderModel? header,
    TodaysChallengeModel? todaysChallenge,
    List<FeaturedPlanModel>? featuredPlans,
    List<WorkoutFilterModel>? filters,
    List<WorkoutProgramModel>? workoutPrograms,
    GymModel? gym,
    String? searchQuery,
    String? selectedFilterId,
    SortOption? sortOption,
    bool? showFavoritesOnly,
  }) {
    return FitnessSuccess(
      header: header ?? this.header,
      todaysChallenge: todaysChallenge ?? this.todaysChallenge,
      featuredPlans: featuredPlans ?? this.featuredPlans,
      filters: filters ?? this.filters,
      workoutPrograms: workoutPrograms ?? this.workoutPrograms,
      gym: gym ?? this.gym,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedFilterId: selectedFilterId ?? this.selectedFilterId,
      sortOption: sortOption ?? this.sortOption,
      showFavoritesOnly: showFavoritesOnly ?? this.showFavoritesOnly,
    );
  }

  @override
  List<Object?> get props => [
        header,
        todaysChallenge,
        featuredPlans,
        filters,
        workoutPrograms,
        gym,
        searchQuery,
        selectedFilterId,
        sortOption,
        showFavoritesOnly,
      ];
}
