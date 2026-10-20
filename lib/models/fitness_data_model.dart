import 'header_model.dart';
import 'todays_challenge_model.dart';
import 'featured_plan_model.dart';
import 'workout_program_model.dart';
import 'workout_filter_model.dart';
import 'gym_model.dart';

class FitnessDataModel {
  final HeaderModel header;
  final TodaysChallengeModel todaysChallenge;
  final List<FeaturedPlanModel> featuredPlans;
  final List<WorkoutFilterModel> filters;
  final List<WorkoutProgramModel> workoutPrograms;
  final GymModel gym;

  FitnessDataModel({
    required this.header,
    required this.todaysChallenge,
    required this.featuredPlans,
    required this.filters,
    required this.workoutPrograms,
    required this.gym,
  });

  factory FitnessDataModel.fromJson(Map<String, dynamic> json) {
    final homePage = json['fitnessHomePage'] ?? {};
    final gymDetails = json['fitnessGymDetailsPage'] ?? {};

    // Header
    final header = HeaderModel.fromJson(homePage['header'] ?? {});

    // Today's challenge
    final todaysChallenge = TodaysChallengeModel.fromJson(homePage['todaysChallenge'] ?? {});

    // Featured plans
    final featuredPlansJson = homePage['featuredPlans'] as List<dynamic>? ?? [];
    final featuredPlans = featuredPlansJson.map((e) => FeaturedPlanModel.fromJson(e)).toList();

    // Workouts & filters
    final wpSection = homePage['workoutPrograms'] ?? {};
    final filterIconUrlsRaw = wpSection['filterIconUrls'] as Map<String, dynamic>? ?? {};
    final Map<String, String> filterIconUrls = filterIconUrlsRaw.map((k, v) => MapEntry(k, v.toString()));

    final filtersJson = wpSection['filters'] as List<dynamic>? ?? [];
    final filters = filtersJson
        .map((e) => WorkoutFilterModel.fromJson(e, filterIconUrls: filterIconUrls))
        .toList();

    final wpItemsJson = wpSection['items'] as List<dynamic>? ?? [];
    final workoutPrograms = wpItemsJson.map((e) => WorkoutProgramModel.fromJson(e)).toList();

    // Gym details
    final gym = GymModel.fromJson(gymDetails['gym'] ?? {});

    return FitnessDataModel(
      header: header,
      todaysChallenge: todaysChallenge,
      featuredPlans: featuredPlans,
      filters: filters,
      workoutPrograms: workoutPrograms,
      gym: gym,
    );
  }
}
