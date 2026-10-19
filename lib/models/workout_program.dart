class FeaturedPlan {
  final String id;
  final String title;
  final String duration;
  final String frequency;
  final String imageUrl;

  const FeaturedPlan({
    required this.id,
    required this.title,
    required this.duration,
    required this.frequency,
    required this.imageUrl,
  });
}

class WorkoutProgram {
  final String id;
  final String title;
  final String category;
  final int calories;
  final int durationMinutes;
  final String imageUrl;
  final bool isPro;
  final String location;
  final double rating;
  final int reviewCount;
  final double pricePerWeek;
  final String description;

  const WorkoutProgram({
    required this.id,
    required this.title,
    required this.category,
    required this.calories,
    required this.durationMinutes,
    required this.imageUrl,
    this.isPro = false,
    this.location = 'California, New York',
    this.rating = 4.5,
    this.reviewCount = 1232,
    this.pricePerWeek = 69.00,
    this.description =
        'Lorem ipsum dolor sit amet consectetur. Blandit vitae aliquet eros laoreet quam sollicitudin. Duis non eu habitant id vel nisi eget amet tellus...',
  });
}

class Amenity {
  final String title;
  final String iconType;

  const Amenity({
    required this.title,
    required this.iconType,
  });
}
