import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../common/custom_color.dart';

class Routine {
  final String title;
  final String duration;
  final String calories;
  final IconData icon;
  bool isCompleted;

  Routine(this.title, this.duration, this.calories, this.icon, {this.isCompleted = false});
}

class CategoryData {
  final String name;
  final IconData icon;
  final String featuredTitle;
  final String featuredSubtitle;
  final String featuredImage;
  final List<Routine> routines;

  CategoryData({
    required this.name,
    required this.icon,
    required this.featuredTitle,
    required this.featuredSubtitle,
    required this.featuredImage,
    required this.routines,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Color bgColor = const Color(0xFF121215);
  final Color cardColor = const Color(0xFF1E1E24);
  final Gradient primaryGradient = const LinearGradient(
    colors: [Color(0xFF86CC55), Color(0xFF1E6BD1)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  final supabase = Supabase.instance.client;
  String _userName = 'Hello 👋';
  String? _userAvatar;

  int selectedCategory = 0;
  int totalCaloriesBurned = 0;
  final int dailyGoal = 5000;
  
  final List<CategoryData> categories = [
    CategoryData(
      name: 'Running',
      icon: Icons.directions_run,
      featuredTitle: 'Morning 5K Sprint',
      featuredSubtitle: '30 Mins • 320 kcal',
      featuredImage: 'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?q=80&w=1470&auto=format&fit=crop',
      routines: [
        Routine('Paced Jog', '15 Mins', '200 kcal', Icons.directions_run),
        Routine('Hill Sprints', '20 Mins', '300 kcal', Icons.terrain),
        Routine('Stair Climbing', '10 Mins', '200 kcal', Icons.stairs),
        Routine('Tempo Run', '25 Mins', '400 kcal', Icons.timer),
        Routine('Cool Down Walk', '10 Mins', '150 kcal', Icons.directions_walk),
      ],
    ),
    CategoryData(
      name: 'Cycling',
      icon: Icons.directions_bike,
      featuredTitle: 'Mountain Trail',
      featuredSubtitle: '45 Mins • 410 kcal',
      featuredImage: 'https://images.unsplash.com/photo-1475483768296-6163e08872a1?q=80&w=1470&auto=format&fit=crop',
      routines: [
        Routine('Endurance Ride', '30 Mins', '350 kcal', Icons.directions_bike),
        Routine('Speed Intervals', '20 Mins', '300 kcal', Icons.speed),
        Routine('Uphill Climb', '25 Mins', '400 kcal', Icons.landscape),
        Routine('Recovery Spin', '15 Mins', '100 kcal', Icons.pedal_bike),
        Routine('Core & Cycle', '10 Mins', '100 kcal', Icons.fitness_center),
      ],
    ),
    CategoryData(
      name: 'Swimming',
      icon: Icons.pool,
      featuredTitle: 'Freestyle Flow',
      featuredSubtitle: '40 Mins • 380 kcal',
      featuredImage: 'https://images.unsplash.com/photo-1530549387789-4c1017266635?q=80&w=1470&auto=format&fit=crop',
      routines: [
        Routine('Laps Warm-up', '10 Mins', '200 kcal', Icons.pool),
        Routine('Breath Control', '20 Mins', '300 kcal', Icons.water),
        Routine('Butterfly Strokes', '15 Mins', '400 kcal', Icons.waves),
        Routine('Water Aerobics', '25 Mins', '350 kcal', Icons.accessibility_new),
      ],
    ),
    CategoryData(
      name: 'HIIT',
      icon: Icons.whatshot,
      featuredTitle: 'Full Body Burn',
      featuredSubtitle: '25 Mins • 450 kcal',
      featuredImage: 'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?q=80&w=1470&auto=format&fit=crop',
      routines: [
        Routine('Burpee Challenge', '10 Mins', '250 kcal', Icons.local_fire_department),
        Routine('Core Crusher', '15 Mins', '300 kcal', Icons.fitness_center),
        Routine('Jumping Jacks', '5 Mins', '150 kcal', Icons.self_improvement),
        Routine('Mountain Climbers', '10 Mins', '250 kcal', Icons.terrain),
        Routine('Squat Jumps', '12 Mins', '300 kcal', Icons.upgrade),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
    _calculateInitialCalories();
  }

  void _calculateInitialCalories() {
    int initialCalories = 0;
    for (var category in categories) {
      for (var routine in category.routines) {
        if (routine.isCompleted) {
          int cal = int.tryParse(routine.calories.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
          initialCalories += cal;
        }
      }
    }
    setState(() {
      totalCaloriesBurned = initialCalories;
    });
  }

  Future<void> _loadUserInfo() async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) return;
      
      final data = await supabase
          .from('profiles')
          .select('full_name, avatar_url')
          .eq('id', user.id)
          .maybeSingle();

      if (data != null && mounted) {
        setState(() {
          final name = data['full_name'] ?? '';
          _userName = name.isNotEmpty ? 'Hello, $name 👋' : 'Hello 👋';
          _userAvatar = data['avatar_url'];
        });
      }
    } catch (_) {
      // Ignore errors when fetching just to avoid unnecessary popups on home
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 120), // bottom padding for navbar
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 30),
              _buildActivityRingCard(),
              const SizedBox(height: 30),
              _buildSectionTitle('Cardio Categories'),
              const SizedBox(height: 15),
              _buildCategoryList(),
              const SizedBox(height: 30),
              _buildSectionTitle('Featured Routine'),
              const SizedBox(height: 15),
              _buildFeaturedCard(),
              const SizedBox(height: 30),
              _buildSectionTitle('Today\'s Plan'),
              const SizedBox(height: 15),
              _buildQuickActionList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _userName,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 3),
            const Text(
              "Ready to sweat?",
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Container(
          height: 45,
          width: 45,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: AppColors.primaryGradient,
            ),
          ),
          child: ClipOval(
            child: _userAvatar != null && _userAvatar!.isNotEmpty
                ? Image.network(
                    _userAvatar!,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2));
                    },
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.person, size: 28, color: Colors.white),
                  )
                : const Icon(
                    Icons.person,
                    size: 28,
                    color: Colors.white,
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildActivityRingCard() {
    double progress = totalCaloriesBurned / dailyGoal;
    if (progress > 1.0) progress = 1.0;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 15,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Daily Goal",
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "$totalCaloriesBurned / $dailyGoal",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "Calories Burned",
                style: TextStyle(
                  color: Color(0xFF86CC55),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 80,
            height: 80,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 8,
                  backgroundColor: Colors.white.withValues(alpha: 0.05),
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF86CC55)),
                  strokeCap: StrokeCap.round,
                ),
                const Center(
                  child: Icon(Icons.local_fire_department, color: Color(0xFF1E6BD1), size: 30),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildCategoryList() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          bool isSelected = selectedCategory == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: isSelected ? primaryGradient : null,
                color: isSelected ? null : cardColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? Colors.transparent : Colors.white.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    categories[index].icon,
                    size: 18,
                    color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.6),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    categories[index].name,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.6),
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeaturedCard() {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: DecorationImage(
          image: NetworkImage(categories[selectedCategory].featuredImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: [
              Colors.black.withValues(alpha: 0.9),
              Colors.transparent,
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF1E6BD1).withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "Intermediate",
                style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              categories[selectedCategory].featuredTitle,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              categories[selectedCategory].featuredSubtitle,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionList() {
    final routines = categories[selectedCategory].routines;
    
    return Column(
      children: routines.map((routine) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildRoutineTile(routine),
        );
      }).toList(),
    );
  }

  Widget _buildRoutineTile(Routine routine) {
    return GestureDetector(
      onTap: () {
        setState(() {
          routine.isCompleted = !routine.isCompleted;
          
          // Parse calories string like "120 kcal" into an integer
          int cal = int.tryParse(routine.calories.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
          
          if (routine.isCompleted) {
            totalCaloriesBurned += cal;
          } else {
            totalCaloriesBurned -= cal;
            if (totalCaloriesBurned < 0) totalCaloriesBurned = 0;
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: routine.isCompleted ? cardColor.withValues(alpha: 0.5) : cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: routine.isCompleted ? const Color(0xFF86CC55).withValues(alpha: 0.5) : Colors.white.withValues(alpha: 0.05),
          ),
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: routine.isCompleted ? null : primaryGradient,
                color: routine.isCompleted ? const Color(0xFF2C2C35) : null,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                routine.isCompleted ? Icons.check : routine.icon, 
                color: routine.isCompleted ? const Color(0xFF86CC55) : Colors.white, 
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    routine.title,
                    style: TextStyle(
                      color: routine.isCompleted ? Colors.white.withValues(alpha: 0.4) : Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decoration: routine.isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    routine.duration + " • " + routine.calories,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              routine.isCompleted ? Icons.check_circle : Icons.play_circle_fill,
              color: const Color(0xFF86CC55).withValues(alpha: routine.isCompleted ? 0.7 : 1.0),
              size: 36,
            ),
          ],
        ),
      ),
    );
  }
}
