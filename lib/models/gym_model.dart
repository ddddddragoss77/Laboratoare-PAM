import 'package:equatable/equatable.dart';

class AmenityModel extends Equatable {
  final String id;
  final String name;
  final String iconUrl;

  const AmenityModel({
    required this.id,
    required this.name,
    required this.iconUrl,
  });

  factory AmenityModel.fromJson(Map<String, dynamic> json) {
    return AmenityModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      iconUrl: json['iconUrl'] ?? '',
    );
  }

  @override
  List<Object?> get props => [id, name, iconUrl];
}

class PricingModel extends Equatable {
  final double amount;
  final String currency;
  final String period;
  final String formatted;

  const PricingModel({
    required this.amount,
    required this.currency,
    required this.period,
    required this.formatted,
  });

  factory PricingModel.fromJson(Map<String, dynamic> json) {
    return PricingModel(
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      currency: json['currency'] ?? '',
      period: json['period'] ?? '',
      formatted: json['formatted'] ?? '',
    );
  }

  @override
  List<Object?> get props => [amount, currency, period, formatted];
}

class GymModel extends Equatable {
  final String id;
  final String name;
  final String location;
  final String heroImageUrl;
  final double rating;
  final int reviewCount;
  final String description;
  final bool descriptionExpanded;
  final List<AmenityModel> amenities;
  final PricingModel pricing;
  final bool isFavorite;

  const GymModel({
    required this.id,
    required this.name,
    required this.location,
    required this.heroImageUrl,
    required this.rating,
    required this.reviewCount,
    required this.description,
    required this.descriptionExpanded,
    required this.amenities,
    required this.pricing,
    this.isFavorite = false,
  });

  factory GymModel.fromJson(Map<String, dynamic> json) {
    final amenitiesJson = json['amenities'] as List<dynamic>? ?? [];
    return GymModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      heroImageUrl: json['heroImageUrl'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: json['reviewCount'] ?? 0,
      description: json['description'] ?? '',
      descriptionExpanded: json['descriptionExpanded'] ?? false,
      amenities: amenitiesJson.map((e) => AmenityModel.fromJson(e)).toList(),
      pricing: PricingModel.fromJson(json['pricing'] ?? {}),
      isFavorite: false,
    );
  }

  GymModel copyWith({
    bool? descriptionExpanded,
    bool? isFavorite,
  }) {
    return GymModel(
      id: id,
      name: name,
      location: location,
      heroImageUrl: heroImageUrl,
      rating: rating,
      reviewCount: reviewCount,
      description: description,
      descriptionExpanded: descriptionExpanded ?? this.descriptionExpanded,
      amenities: amenities,
      pricing: pricing,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        location,
        heroImageUrl,
        rating,
        reviewCount,
        description,
        descriptionExpanded,
        amenities,
        pricing,
        isFavorite,
      ];
}
