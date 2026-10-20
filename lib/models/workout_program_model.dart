import 'package:equatable/equatable.dart';

class WorkoutIcons extends Equatable {
  final String caloriesIconUrl;
  final String durationIconUrl;
  final String? proIconUrl;

  const WorkoutIcons({
    required this.caloriesIconUrl,
    required this.durationIconUrl,
    this.proIconUrl,
  });

  factory WorkoutIcons.fromJson(Map<String, dynamic> json) {
    return WorkoutIcons(
      caloriesIconUrl: json['caloriesIconUrl'] ?? '',
      durationIconUrl: json['durationIconUrl'] ?? '',
      proIconUrl: json['proIconUrl'],
    );
  }

  @override
  List<Object?> get props => [caloriesIconUrl, durationIconUrl, proIconUrl];
}

class WorkoutProgramModel extends Equatable {
  final String id;
  final String title;
  final int calories;
  final int durationMinutes;
  final bool isPro;
  final String imageUrl;
  final WorkoutIcons icons;
  final bool isFavorite;

  const WorkoutProgramModel({
    required this.id,
    required this.title,
    required this.calories,
    required this.durationMinutes,
    required this.isPro,
    required this.imageUrl,
    required this.icons,
    this.isFavorite = false,
  });

  factory WorkoutProgramModel.fromJson(Map<String, dynamic> json) {
    return WorkoutProgramModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      calories: json['calories'] ?? 0,
      durationMinutes: json['durationMinutes'] ?? 0,
      isPro: json['isPro'] ?? false,
      imageUrl: json['imageUrl'] ?? '',
      icons: WorkoutIcons.fromJson(json['icons'] ?? {}),
      isFavorite: false,
    );
  }

  WorkoutProgramModel copyWith({bool? isFavorite}) {
    return WorkoutProgramModel(
      id: id,
      title: title,
      calories: calories,
      durationMinutes: durationMinutes,
      isPro: isPro,
      imageUrl: imageUrl,
      icons: icons,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        calories,
        durationMinutes,
        isPro,
        imageUrl,
        icons,
        isFavorite,
      ];
}
