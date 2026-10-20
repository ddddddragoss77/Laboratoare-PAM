import 'package:equatable/equatable.dart';

class FeaturedPlanMetaIcons extends Equatable {
  final String durationIconUrl;
  final String frequencyIconUrl;

  const FeaturedPlanMetaIcons({
    required this.durationIconUrl,
    required this.frequencyIconUrl,
  });

  factory FeaturedPlanMetaIcons.fromJson(Map<String, dynamic> json) {
    return FeaturedPlanMetaIcons(
      durationIconUrl: json['durationIconUrl'] ?? '',
      frequencyIconUrl: json['frequencyIconUrl'] ?? '',
    );
  }

  @override
  List<Object?> get props => [durationIconUrl, frequencyIconUrl];
}

class FeaturedPlanModel extends Equatable {
  final String id;
  final String title;
  final String duration;
  final String frequency;
  final String actionLabel;
  final String imageUrl;
  final FeaturedPlanMetaIcons metaIcons;
  final bool isFavorite;

  const FeaturedPlanModel({
    required this.id,
    required this.title,
    required this.duration,
    required this.frequency,
    required this.actionLabel,
    required this.imageUrl,
    required this.metaIcons,
    this.isFavorite = false,
  });

  factory FeaturedPlanModel.fromJson(Map<String, dynamic> json) {
    return FeaturedPlanModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      duration: json['duration'] ?? '',
      frequency: json['frequency'] ?? '',
      actionLabel: json['actionLabel'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      metaIcons: FeaturedPlanMetaIcons.fromJson(json['metaIcons'] ?? {}),
      isFavorite: false,
    );
  }

  FeaturedPlanModel copyWith({bool? isFavorite}) {
    return FeaturedPlanModel(
      id: id,
      title: title,
      duration: duration,
      frequency: frequency,
      actionLabel: actionLabel,
      imageUrl: imageUrl,
      metaIcons: metaIcons,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        duration,
        frequency,
        actionLabel,
        imageUrl,
        metaIcons,
        isFavorite,
      ];
}
