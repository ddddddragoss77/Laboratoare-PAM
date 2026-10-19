import 'package:flutter/material.dart';
import '../models/workout_program.dart';
import '../widgets/category_filter_chip.dart';
import '../widgets/featured_plan_card.dart';
import '../widgets/workout_card.dart';
import 'gym_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'All Type';

  final List<String> _categories = [
    'All Type',
    'Pilates',
    'Cardio',
    'Boxing',
    'Yoga',
  ];

  final List<FeaturedPlan> _featuredPlans = const [
    FeaturedPlan(
      id: '1',
      title: 'Massive Upper Body',
      duration: '5 week',
      frequency: '4x/week',
      imageUrl:
          'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?q=80&w=800&auto=format&fit=crop',
    ),
    FeaturedPlan(
      id: '2',
      title: 'Full Body Shred',
      duration: '6 week',
      frequency: '3x/week',
      imageUrl:
          'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=800&auto=format&fit=crop',
    ),
  ];

  final List<WorkoutProgram> _allPrograms = const [
    WorkoutProgram(
      id: '1',
      title: 'Yoga',
      category: 'Yoga',
      calories: 210,
      durationMinutes: 120,
      imageUrl:
          'https://images.unsplash.com/photo-1545205597-3d9d02c29597?q=80&w=800&auto=format&fit=crop',
      isPro: false,
    ),
    WorkoutProgram(
      id: '2',
      title: 'Arm Strengthening',
      category: 'Cardio',
      calories: 210,
      durationMinutes: 120,
      imageUrl:
          'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?q=80&w=800&auto=format&fit=crop',
      isPro: true,
    ),
    WorkoutProgram(
      id: '3',
      title: 'Core & Pilates',
      category: 'Pilates',
      calories: 180,
      durationMinutes: 45,
      imageUrl:
          'https://images.unsplash.com/photo-1518611012118-696072aa579a?q=80&w=800&auto=format&fit=crop',
      isPro: false,
    ),
    WorkoutProgram(
      id: '4',
      title: 'Boxing Knockout',
      category: 'Boxing',
      calories: 350,
      durationMinutes: 60,
      imageUrl:
          'https://images.unsplash.com/photo-1549719386-74dfcbf7dbed?q=80&w=800&auto=format&fit=crop',
      isPro: true,
    ),
  ];

  List<WorkoutProgram> get _filteredPrograms {
    if (_selectedCategory == 'All Type') {
      return _allPrograms;
    }
    return _allPrograms
        .where((p) => p.category.toLowerCase() == _selectedCategory.toLowerCase())
        .toList();
  }

  void _navigateToDetail(WorkoutProgram program) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => GymDetailScreen(program: program),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF00D15B);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Friday, 20 May',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF8E8E93),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Good Morning',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1D1D1F),
                        ),
                      ),
                    ],
                  ),

                  // Bell Notification Icon Button
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xFFE5E5EA),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const Icon(
                          Icons.notifications_none_rounded,
                          color: Color(0xFF1D1D1F),
                          size: 24,
                        ),
                        Positioned(
                          top: 13,
                          right: 14,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFF3B30),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Today's Challenge Dark Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF121214),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Today's Challenge",
                          style: TextStyle(
                            color: Color(0xFFA1A1A6),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Running',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    // Circular Progress Widget (15/20)
                    SizedBox(
                      width: 54,
                      height: 54,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 54,
                            height: 54,
                            child: CircularProgressIndicator(
                              value: 15 / 20,
                              strokeWidth: 4.5,
                              backgroundColor: primaryGreen.withValues(alpha: 0.2),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                primaryGreen,
                              ),
                            ),
                          ),
                          const Text(
                            '15/20',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Featured Plan Section Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Featured Plan',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1D1D1F),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'See All',
                      style: TextStyle(
                        color: primaryGreen,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Featured Plans Horizontal Carousel
              SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: _featuredPlans.length,
                  itemBuilder: (context, index) {
                    final plan = _featuredPlans[index];
                    return FeaturedPlanCard(
                      plan: plan,
                      onTap: () {
                        _navigateToDetail(_allPrograms[0]);
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 28),

              // Workout Programs Section Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Workout Programs',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1D1D1F),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'See All',
                      style: TextStyle(
                        color: primaryGreen,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Category Filters List
              SizedBox(
                height: 42,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: _categories.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    final isSelected = category == _selectedCategory;
                    return CategoryFilterChip(
                      label: category,
                      isSelected: isSelected,
                      onTap: () {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Workout Programs Grid (2 Columns)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.72,
                ),
                itemCount: _filteredPrograms.length,
                itemBuilder: (context, index) {
                  final program = _filteredPrograms[index];
                  return WorkoutCard(
                    program: program,
                    onTap: () => _navigateToDetail(program),
                  );
                },
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
