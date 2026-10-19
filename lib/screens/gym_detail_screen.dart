import 'package:flutter/material.dart';
import '../models/workout_program.dart';
import '../widgets/amenity_chip.dart';

class GymDetailScreen extends StatefulWidget {
  final WorkoutProgram program;

  const GymDetailScreen({
    super.key,
    required this.program,
  });

  @override
  State<GymDetailScreen> createState() => _GymDetailScreenState();
}

class _GymDetailScreenState extends State<GymDetailScreen> {
  bool _isExpanded = false;

  void _onReservePressed() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: Color(0xFFE6F9EE),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: Color(0xFF00D15B),
                  size: 32,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Reservation Confirmed!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1D1D1F),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'You have successfully reserved your spot at ${widget.program.title} for \$${widget.program.pricePerWeek.toStringAsFixed(2)}/week.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF8E8E93),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00D15B),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF00D15B);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Scrollable Content
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // Top Header Image Section
                SizedBox(
                  height: size.height * 0.45,
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=1200&auto=format&fit=crop',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: const Color(0xFF2C2C2E),
                            child: const Icon(
                              Icons.fitness_center,
                              color: Colors.white30,
                              size: 80,
                            ),
                          );
                        },
                      ),

                      // Light Gradient Overlay
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withValues(alpha: 0.35),
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.15),
                            ],
                          ),
                        ),
                      ),

                      // Navigation Buttons Bar
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Back Button
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.85),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.1),
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.arrow_back_rounded,
                                    color: Color(0xFF1D1D1F),
                                    size: 22,
                                  ),
                                ),
                              ),

                              // More Options Button
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.85),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.1),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.more_vert_rounded,
                                  color: Color(0xFF1D1D1F),
                                  size: 22,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Main Details Card (Overlapping rounded container)
                Transform.translate(
                  offset: const Offset(0, -28),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(32),
                      ),
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Rating Row
                        Row(
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              color: Color(0xFFFFB800),
                              size: 20,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '${widget.program.rating}',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1D1D1F),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '(${widget.program.reviewCount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} reviews)',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF8E8E93),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        // Title
                        const Text(
                          'Mid City Gym Training',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1D1D1F),
                            height: 1.2,
                          ),
                        ),

                        const SizedBox(height: 6),

                        // Location Subtitle
                        Text(
                          widget.program.location,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF8E8E93),
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        const SizedBox(height: 18),

                        const Divider(
                          color: Color(0xFFF2F2F7),
                          thickness: 1,
                        ),

                        const SizedBox(height: 18),

                        // Description
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF6E6E73),
                              height: 1.5,
                            ),
                            children: [
                              TextSpan(
                                text: _isExpanded
                                    ? '${widget.program.description} Certified trainers available all day. Equipped with state-of-the-art weights and cardio machines.'
                                    : '${widget.program.description} ',
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isExpanded = !_isExpanded;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              _isExpanded ? 'Read less' : 'Read more',
                              style: const TextStyle(
                                color: primaryGreen,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Amenities Header
                        const Text(
                          'Amenities',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1D1D1F),
                          ),
                        ),

                        const SizedBox(height: 14),

                        // Amenities Chips Grid / Row
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: const [
                            AmenityChip(
                              title: 'Showers',
                              icon: Icons.shower_outlined,
                            ),
                            AmenityChip(
                              title: 'Lockers',
                              icon: Icons.door_sliding_outlined,
                            ),
                            AmenityChip(
                              title: 'Free Wi-Fi',
                              icon: Icons.wifi_rounded,
                            ),
                            AmenityChip(
                              title: 'Personal Trainer',
                              icon: Icons.fitness_center_rounded,
                            ),
                          ],
                        ),

                        const SizedBox(height: 120), // Bottom padding for sticky bar
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Sticky Reserve Action Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 16,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Price Column
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF8E8E93),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              '\$${widget.program.pricePerWeek.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1D1D1F),
                              ),
                            ),
                            const Text(
                              ' /week',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF8E8E93),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Reserve Button
                    SizedBox(
                      width: 170,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _onReservePressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryGreen,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'Reserve',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
