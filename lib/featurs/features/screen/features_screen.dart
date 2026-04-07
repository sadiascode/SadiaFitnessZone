import 'package:flutter/material.dart';
import 'package:todo/featurs/features/screen/dumbbells_screen.dart';
import 'package:todo/featurs/features/screen/treadmill_screen.dart';

class Equipment {
  final String name;
  final String category;
  final String description;
  final String imageUrl;
  final VoidCallback? onTap;

  Equipment({
    required this.name,
    required this.category,
    required this.description,
    required this.imageUrl,
    this.onTap,
  });
}

class FeaturesScreen extends StatefulWidget {
  const FeaturesScreen({super.key});

  @override
  State<FeaturesScreen> createState() => _FeaturesScreenState();
}

class _FeaturesScreenState extends State<FeaturesScreen> {

  final Color bgColor = const Color(0xFF121215);
  final Color cardColor = const Color(0xFF1E1E24);
  final Color primaryGreen = const Color(0xFF86CC55);

  late final List<Equipment> instruments = [
    Equipment(
      name: "Treadmill",
      category: "Cardio",
      description: "A motorized running belt used for walking, jogging, or high-intensity sprints. It builds incredible cardiovascular endurance, burns calories extremely fast, and is perfect for pre-workout warm-ups.",
      imageUrl: "https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?q=80&w=1470&auto=format&fit=crop",
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const  TreadmillScreen(item: item,),
          ),
        );
      }
    ),
    Equipment(
      name: "Dumbbells",
      category: "Free Weights",
      description: "Handheld weights used for isolation and compound exercises. Grab a pair to perform bicep curls, shoulder presses, and lunges to build functional upper and lower body muscle mass.",
      imageUrl: "https://images.unsplash.com/photo-1574680088814-c9e8a10d8a4d?q=80&w=1469&auto=format&fit=crop",
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const  DumbbellsScreen(item: item),
            ),
          );
        }
    ),
    Equipment(
      name: "Smith Machine",
      category: "Powerlifting",
      description: "A guided barbell fixed within steel rails. Excellent for safely performing heavy barbell squats, bench presses, and lunges without needing a spotter. Highly effective for isolating the glutes and quads.",
      imageUrl: "https://images.unsplash.com/photo-1605296867304-46d5465a13f1?q=80&w=1470&auto=format&fit=crop",
    ),
    Equipment(
      name: "Yoga Mat",
      category: "Flexibility",
      description: "A dedicated cushioned space for bodyweight and stretching exercises. Essential for practicing Yoga poses, doing Pilates routines, improving joint mobility, and enhancing mental mindfulness.",
      imageUrl: "https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?q=80&w=1520&auto=format&fit=crop",
    ),
    Equipment(
      name: "Cable Station",
      category: "Isolation",
      description: "An adjustable dual-pulley system providing constant weight tension from all angles. Perfect for chest flies, lat pulldowns, and tricep pushdowns to sculpt and tone specific upper-body muscle groups.",
      imageUrl: "https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?q=80&w=1470&auto=format&fit=crop",
    ),
    Equipment(
      name: "Kettlebells",
      category: "Dynamic Strength",
      description: "Cast-iron weights with a handle used for explosive, full-body movements. Perfect for performing kettlebell swings and goblet squats to build immense core stability and hip power.",
      imageUrl: "https://images.unsplash.com/photo-1574680096145-d05b474e2155?q=80&w=1469&auto=format&fit=crop",
    ),
    Equipment(
      name: "Rowing Machine",
      category: "Full Body Cardio",
      description: "A machine simulating water rowing for an incredible full-body workout. It maximizes calorie burn by pulling with your back and pushing with your legs, with zero impact on your knees.",
      imageUrl: "https://images.unsplash.com/photo-1549476464-37392f717541?q=80&w=1469&auto=format&fit=crop",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 30),
              _buildEquipmentList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Gym Instruments",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Explore the equipment waiting for you",
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.6),
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildEquipmentList() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: instruments.length,
      itemBuilder: (context, index) {
        return _buildEquipmentCard(instruments[index]);
      },
    );
  }

  Widget _buildEquipmentCard(Equipment item) {
    return GestureDetector(
        onTap: item.onTap, // simply call the stored callback
        child:Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 260,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
        image: DecorationImage(
          image: NetworkImage(item.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: [
              Colors.black.withValues(alpha: 0.95),
              Colors.black.withValues(alpha: 0.5),
              Colors.transparent,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
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
                color: primaryGreen.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: primaryGreen.withValues(alpha: 0.5)),
              ),
              child: Text(
                item.category,
                style: TextStyle(
                  color: primaryGreen, 
                  fontSize: 12, 
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              item.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              item.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
        )
    );
  }
}
