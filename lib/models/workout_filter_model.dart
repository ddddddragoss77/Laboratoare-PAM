import 'package:equatable/equatable.dart';

class WorkoutFilterModel extends Equatable {
  final String id;
  final String name;
  final bool selected;
  final String? iconUrl;

  const WorkoutFilterModel({
    required this.id,
    required this.name,
    required this.selected,
    this.iconUrl,
  });

  factory WorkoutFilterModel.fromJson(
    Map<String, dynamic> json, {
    Map<String, String>? filterIconUrls,
  }) {
    final id = json['id'] ?? '';
    return WorkoutFilterModel(
      id: id,
      name: json['name'] ?? '',
      selected: json['selected'] ?? false,
      iconUrl: filterIconUrls?[id],
    );
  }

  WorkoutFilterModel copyWith({bool? selected}) {
    return WorkoutFilterModel(
      id: id,
      name: name,
      selected: selected ?? this.selected,
      iconUrl: iconUrl,
    );
  }

  @override
  List<Object?> get props => [id, name, selected, iconUrl];
}
