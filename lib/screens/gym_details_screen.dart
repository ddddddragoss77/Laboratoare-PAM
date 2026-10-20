import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/fitness_cubit.dart';
import '../cubit/fitness_state.dart';
import '../models/gym_model.dart';
import '../widgets/favorite_button.dart';
import '../widgets/svg_icon_widget.dart';

class GymDetailsScreen extends StatelessWidget {
  final GymModel gym;

  const GymDetailsScreen({super.key, required this.gym});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FitnessCubit, FitnessState>(
      builder: (context, state) {
        // Use updated gym from state if available
        final currentGym = (state is FitnessSuccess) ? state.gym : gym;
        final cubit = context.read<FitnessCubit>();

        return Scaffold(
          backgroundColor: const Color(0xFF101115),
          body: Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    // Hero App Bar
                    SliverAppBar(
                      expandedHeight: 280,
                      pinned: true,
                      backgroundColor: const Color(0xFF101115),
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.black.withOpacity(0.5),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: FavoriteButton(
                            isFavorite: currentGym.isFavorite,
                            onTap: () => cubit.toggleFavoriteGym(),
                          ),
                        ),
                      ],
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              currentGym.heroImageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                color: const Color(0xFF1E222B),
                                child: const Icon(Icons.fitness_center, size: 60, color: Colors.grey),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    const Color(0xFF101115).withOpacity(0.9),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Gym Details Info
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Rating & Review Badge
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFB52E).withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.star_rounded, color: Color(0xFFFFB52E), size: 18),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${currentGym.rating}',
                                        style: const TextStyle(
                                          color: Color(0xFFFFB52E),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  '(${currentGym.reviewCount} recenzii)',
                                  style: const TextStyle(
                                    color: Color(0xFF808A9B),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),

                            // Gym Name
                            Text(
                              currentGym.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),

                            // Location
                            Row(
                              children: [
                                const Icon(Icons.location_on, color: Color(0xFF20C766), size: 18),
                                const SizedBox(width: 4),
                                Text(
                                  currentGym.location,
                                  style: const TextStyle(
                                    color: Color(0xFF808A9B),
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),

                            // Description Section with Expand / Collapse state
                            const Text(
                              'Despre Sala de Sport',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            AnimatedCrossFade(
                              firstChild: Text(
                                currentGym.description,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Color(0xFF808A9B),
                                  fontSize: 14,
                                  height: 1.5,
                                ),
                              ),
                              secondChild: Text(
                                '${currentGym.description}\n\nSala noastra oferă echipamente de ultimă generație, antrenori personali certificați și programe personalizate de wellness pentru performanță maximă.',
                                style: const TextStyle(
                                  color: Color(0xFF808A9B),
                                  fontSize: 14,
                                  height: 1.5,
                                ),
                              ),
                              crossFadeState: currentGym.descriptionExpanded
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                              duration: const Duration(milliseconds: 250),
                            ),
                            GestureDetector(
                              onTap: () => cubit.toggleGymDescription(),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  currentGym.descriptionExpanded ? 'Citește mai puțin' : 'Citește mai mult...',
                                  style: const TextStyle(
                                    color: Color(0xFF20C766),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Amenities Section
                            const Text(
                              'Facilități',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: currentGym.amenities.map((amenity) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 12),
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1E222B),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(color: Colors.white10),
                                  ),
                                  child: Row(
                                    children: [
                                      SvgIconWidget(
                                        url: amenity.iconUrl,
                                        size: 22,
                                        color: const Color(0xFF20C766),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        amenity.name,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Bottom Fixed Booking Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                decoration: const BoxDecoration(
                  color: Color(0xFF1E222B),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 10,
                      offset: Offset(0, -4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Preț abonament',
                          style: TextStyle(
                            color: Color(0xFF808A9B),
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          currentGym.pricing.formatted,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            backgroundColor: const Color(0xFF1E222B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            title: const Row(
                              children: [
                                Icon(Icons.check_circle, color: Color(0xFF20C766)),
                                SizedBox(width: 8),
                                Text(
                                  'Rezervare Confirmată!',
                                  style: TextStyle(color: Colors.white, fontSize: 18),
                                ),
                              ],
                            ),
                            content: Text(
                              'Abonamentul la ${currentGym.name} (${currentGym.pricing.formatted}) a fost rezervat cu succes!',
                              style: const TextStyle(color: Color(0xFF808A9B)),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text(
                                  'Închide',
                                  style: TextStyle(
                                    color: Color(0xFF20C766),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF20C766),
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Rezervă Acum',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
