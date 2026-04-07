import 'package:flutter/material.dart';
import 'package:todo/featurs/nutrition/screen/food_detail_screen.dart';

class FoodItem {
  final String name;
  final String description;
  final String calories;
  final String macros;
  final String imageUrl;

  FoodItem({
    required this.name,
    required this.description,
    required this.calories,
    required this.macros,
    required this.imageUrl,
  });
}

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({super.key});

  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  final Color bgColor = const Color(0xFF121215);
  final Color cardColor = const Color(0xFF1E1E24);
  final Color primaryGreen = const Color(0xFF86CC55);
  final Gradient primaryGradient = const LinearGradient(
    colors: [Color(0xFF86CC55), Color(0xFF1E6BD1)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  bool isWeightLoss = true;

  final List<FoodItem> weightLossFoods = [
    FoodItem(
      name: "Grilled Chicken Salad",
      description: "Lean protein packed with fiber from mixed greens. Keeps you full for hours.",
      calories: "320 kcal",
      macros: "35g Protein • 8g Fat",
      imageUrl: "https://images.unsplash.com/photo-1512621776951-a57141f2eefd?q=80&w=1470&auto=format&fit=crop",
    ),
    FoodItem(
      name: "Glazed Salmon Bowl",
      description: "Rich in Omega-3s and combined with quinoa for healthy slow-digesting complex carbs.",
      calories: "450 kcal",
      macros: "40g Protein • 15g Fat",
      imageUrl: "https://images.unsplash.com/photo-1467003909585-2f8a72700288?q=80&w=1470&auto=format&fit=crop",
    ),
    FoodItem(
      name: "Oats & Fresh Berries",
      description: "Low-calorie breakfast powerhouse. Provides excellent morning energy without the sugar crash.",
      calories: "280 kcal",
      macros: "10g Protein • 5g Fat",
      imageUrl: "https://images.unsplash.com/photo-1511690656952-34342bb7c2f2?q=80&w=1470&auto=format&fit=crop",
    ),
    FoodItem(
      name: "Avocado & Egg Toast",
      description: "Healthy fats from avocado instantly crush cravings. Paired with whole grain bread.",
      calories: "350 kcal",
      macros: "14g Protein • 18g Fat",
      imageUrl: "https://images.unsplash.com/photo-1525351484163-7529414344d8?q=80&w=1470&auto=format&fit=crop",
    ),
    FoodItem(
      name: "Greek Yogurt & Honey",
      description: "Creamy, high-protein snack that satisfies sweet cravings without packing on weight.",
      calories: "180 kcal",
      macros: "20g Protein • 3g Fat",
      imageUrl: "https://images.pexels.com/photos/29516115/pexels-photo-29516115.jpeg",
    ),
    FoodItem(
      name: "Green Detox Smoothie",
      description: "Packed with spinach, green apple, and ginger. An incredibly low-calorie metabolism booster.",
      calories: "150 kcal",
      macros: "4g Protein • 1g Fat",
      imageUrl: "https://images.unsplash.com/photo-1610970881699-44a5587cabec?q=80&w=1200&auto=format&fit=crop",
    ),
  ];

  final List<FoodItem> weightGainFoods = [
    FoodItem(
      name: "Peanut Butter Smoothie",
      description: "A colossal calorie bomb! Blended with banana, whole milk, and whey protein powder.",
      calories: "850 kcal",
      macros: "50g Protein • 30g Fat",
      imageUrl: "https://images.unsplash.com/photo-1577805947697-89e18249d767?q=80&w=800&auto=format&fit=crop",
    ),
    FoodItem(
      name: "Beef Steak & Rice",
      description: "The ultimate muscle builder. Massive iron content paired with easily digestible white rice.",
      calories: "920 kcal",
      macros: "65g Protein • 40g Fat",
      imageUrl: "https://images.unsplash.com/photo-1600891964092-4316c288032e?q=80&w=1470&auto=format&fit=crop",
    ),
    FoodItem(
      name: "Mixed Nuts & Trail Mix",
      description: "Calorie dense snacking. Almonds, walnuts, and dried fruits for continuous energy surplus.",
      calories: "600 kcal (per cup)",
      macros: "20g Protein • 50g Fat",
      imageUrl: "https://images.unsplash.com/photo-1599599810769-bcde5a160d32?q=80&w=1200&auto=format&fit=crop",
    ),
    FoodItem(
      name: "Whole Wheat Pasta Bowl",
      description: "A gigantic bowl of complex carbs with meat sauce. Crucial for heavy bulking phases.",
      calories: "780 kcal",
      macros: "35g Protein • 18g Fat",
      imageUrl: "https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?q=80&w=1470&auto=format&fit=crop",
    ),
    FoodItem(
      name: "Double Beef Burger",
      description: "A massive caloric surplus cheat meal packed with extreme protein and heavy fats.",
      calories: "1150 kcal",
      macros: "70g Protein • 65g Fat",
      imageUrl: "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?q=80&w=1470&auto=format&fit=crop",
    ),
    FoodItem(
      name: "Stack of Protein Pancakes",
      description: "Huge breakfast surplus loaded with whey, oats, and heavy maple syrup for massive gains.",
      calories: "880 kcal",
      macros: "55g Protein • 20g Fat",
      imageUrl: "https://images.pexels.com/photos/14906566/pexels-photo-14906566.jpeg",
    ),
  ];

  void _navigateToDetail(FoodItem item) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        reverseTransitionDuration: const Duration(milliseconds: 350),
        pageBuilder: (context, animation, secondaryAnimation) =>
            FoodDetailScreen(item: item),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<FoodItem> currentList = isWeightLoss ? weightLossFoods : weightGainFoods;

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
              _buildToggleSwitch(),
              const SizedBox(height: 30),
              _buildFoodList(currentList),
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
          "Nutrition Guide",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Fuel your body for your exact fitness goals",
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.6),
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildToggleSwitch() {
    return Container(
      height: 55,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isWeightLoss = true;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  gradient: isWeightLoss ? primaryGradient : null,
                  borderRadius: BorderRadius.circular(25),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Weight Loss",
                  style: TextStyle(
                    color: isWeightLoss ? Colors.white : Colors.white.withValues(alpha: 0.5),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isWeightLoss = false;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  gradient: !isWeightLoss ? primaryGradient : null,
                  borderRadius: BorderRadius.circular(25),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Weight Gain",
                  style: TextStyle(
                    color: !isWeightLoss ? Colors.white : Colors.white.withValues(alpha: 0.5),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodList(List<FoodItem> list) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (context, index) {
        return _buildFoodCard(list[index]);
      },
    );
  }

  Widget _buildFoodCard(FoodItem item) {
    return GestureDetector(
      onTap: () => _navigateToDetail(item),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Hero(
              tag: 'food_${item.name}',
              child: Container(
                width: 120,
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(item.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 12, right: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 12,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.local_fire_department, color: primaryGreen, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          item.calories,
                          style: TextStyle(
                            color: primaryGreen,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.pie_chart_outline, color: const Color(0xFF1E6BD1), size: 16),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            item.macros,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.6),
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white.withValues(alpha: 0.3),
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
