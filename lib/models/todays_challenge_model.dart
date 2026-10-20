import 'package:equatable/equatable.dart';

class TodaysChallengeModel extends Equatable {
  final String title;
  final String activity;
  final int completed;
  final int total;
  final double progress;
  final String iconUrl;

  const TodaysChallengeModel({
    required this.title,
    required this.activity,
    required this.completed,
    required this.total,
    required this.progress,
    required this.iconUrl,
  });

  factory TodaysChallengeModel.fromJson(Map<String, dynamic> json) {
    return TodaysChallengeModel(
      title: json['title'] ?? '',
      activity: json['activity'] ?? '',
      completed: json['completed'] ?? 0,
      total: json['total'] ?? 0,
      progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
      iconUrl: json['iconUrl'] ?? '',
    );
  }

  @override
  List<Object?> get props => [
        title,
        activity,
        completed,
        total,
        progress,
        iconUrl,
      ];
}
