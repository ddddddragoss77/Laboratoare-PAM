import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/fitness_repository.dart';
import '../models/workout_program_model.dart';
import 'fitness_state.dart';

class FitnessCubit extends Cubit<FitnessState> {
  final FitnessRepository _repository;

  FitnessCubit(this._repository) : super(FitnessInitial());

  /// Loads data asynchronously from JSON repository.
  Future<void> fetchFitnessData({
    bool simulateError = false,
    bool simulateEmpty = false,
  }) async {
    emit(FitnessLoading());
    try {
      if (simulateEmpty) {
        await Future.delayed(const Duration(milliseconds: 600));
        emit(const FitnessEmpty(message: 'Nu există date disponibile în aplicație.'));
        return;
      }

      final data = await _repository.loadFitnessData(simulateError: simulateError);

      emit(FitnessSuccess(
        header: data.header,
        todaysChallenge: data.todaysChallenge,
        featuredPlans: data.featuredPlans,
        filters: data.filters,
        workoutPrograms: data.workoutPrograms,
        gym: data.gym,
      ));
    } catch (e) {
      emit(FitnessError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  /// Updates search query and recalculates filtered list or empty state.
  void updateSearchQuery(String query) {
    final currentState = state;
    if (currentState is FitnessSuccess) {
      final newState = currentState.copyWith(searchQuery: query);
      if (newState.filteredWorkouts.isEmpty && query.isNotEmpty) {
        // Keep Success state with query so UI can show "No results found for X"
        emit(newState);
      } else {
        emit(newState);
      }
    }
  }

  /// Selects category filter (All, Pilates, Cardio, Boxing, Yoga).
  void selectFilter(String filterId) {
    final currentState = state;
    if (currentState is FitnessSuccess) {
      final updatedFilters = currentState.filters.map((f) {
        return f.copyWith(selected: f.id == filterId);
      }).toList();

      emit(currentState.copyWith(
        selectedFilterId: filterId,
        filters: updatedFilters,
      ));
    }
  }

  /// Updates current sorting option.
  void updateSortOption(SortOption option) {
    final currentState = state;
    if (currentState is FitnessSuccess) {
      emit(currentState.copyWith(sortOption: option));
    }
  }

  /// Toggles favorite state of a workout program item.
  void toggleFavoriteWorkout(String workoutId) {
    final currentState = state;
    if (currentState is FitnessSuccess) {
      final updatedPrograms = currentState.workoutPrograms.map((workout) {
        if (workout.id == workoutId) {
          return workout.copyWith(isFavorite: !workout.isFavorite);
        }
        return workout;
      }).toList();

      emit(currentState.copyWith(workoutPrograms: updatedPrograms));
    }
  }

  /// Toggles favorite state of a featured plan.
  void toggleFavoritePlan(String planId) {
    final currentState = state;
    if (currentState is FitnessSuccess) {
      final updatedPlans = currentState.featuredPlans.map((plan) {
        if (plan.id == planId) {
          return plan.copyWith(isFavorite: !plan.isFavorite);
        }
        return plan;
      }).toList();

      emit(currentState.copyWith(featuredPlans: updatedPlans));
    }
  }

  /// Toggles favorite state of the Gym.
  void toggleFavoriteGym() {
    final currentState = state;
    if (currentState is FitnessSuccess) {
      final updatedGym = currentState.gym.copyWith(
        isFavorite: !currentState.gym.isFavorite,
      );
      emit(currentState.copyWith(gym: updatedGym));
    }
  }

  /// Toggles expandable description for Gym details.
  void toggleGymDescription() {
    final currentState = state;
    if (currentState is FitnessSuccess) {
      final updatedGym = currentState.gym.copyWith(
        descriptionExpanded: !currentState.gym.descriptionExpanded,
      );
      emit(currentState.copyWith(gym: updatedGym));
    }
  }

  /// Toggles showing favorites only.
  void toggleFavoritesFilter() {
    final currentState = state;
    if (currentState is FitnessSuccess) {
      emit(currentState.copyWith(
        showFavoritesOnly: !currentState.showFavoritesOnly,
      ));
    }
  }

  /// Adds a new workout program to the list (allows full CRUD demonstration).
  void addWorkoutProgram(WorkoutProgramModel newWorkout) {
    final currentState = state;
    if (currentState is FitnessSuccess) {
      final updated = List<WorkoutProgramModel>.from(currentState.workoutPrograms)
        ..insert(0, newWorkout);
      emit(currentState.copyWith(workoutPrograms: updated));
    }
  }

  /// Removes a workout program from the list.
  void removeWorkoutProgram(String workoutId) {
    final currentState = state;
    if (currentState is FitnessSuccess) {
      final updated = currentState.workoutPrograms.where((w) => w.id != workoutId).toList();
      emit(currentState.copyWith(workoutPrograms: updated));
    }
  }
}
