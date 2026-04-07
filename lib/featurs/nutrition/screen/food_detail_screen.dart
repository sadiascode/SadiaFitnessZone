import 'package:flutter/material.dart';
import 'package:todo/featurs/nutrition/screen/nutrition_screen.dart';
import '../../../common/app_shell.dart';

class FoodDetailData {
  final String description;
  final List<String> benefits;
  final String bestTime;
  final List<String> ingredients;

  const FoodDetailData({
    required this.description,
    required this.benefits,
    required this.bestTime,
    required this.ingredients,
  });
}

final Map<String, FoodDetailData> _foodDetails = {
  "Grilled Chicken Salad": const FoodDetailData(
    description:
        "Lean protein packed with fiber from mixed greens. "
        "This meal keeps you full for hours and helps reduce "
        "calorie intake while supporting fat loss. The combination of "
        "grilled chicken breast with fresh leafy greens provides essential "
        "vitamins and minerals without the extra calories.",
    benefits: [
      "High protein for fat loss",
      "Low calorie meal",
      "Keeps you full longer",
      "Improves metabolism",
    ],
    bestTime: "Lunch or Dinner",
    ingredients: [
      "Grilled chicken breast",
      "Mixed greens & arugula",
      "Cherry tomatoes",
      "Cucumber slices",
      "Olive oil & lemon dressing",
    ],
  ),
  "Glazed Salmon Bowl": const FoodDetailData(
    description:
        "Rich in Omega-3 fatty acids, this glazed salmon bowl is paired "
        "with quinoa for healthy, slow-digesting complex carbs. Omega-3s "
        "reduce inflammation, improve heart health, and help your body burn "
        "fat more efficiently during workouts.",
    benefits: [
      "Rich in Omega-3 fatty acids",
      "Supports heart health",
      "Anti-inflammatory properties",
      "Boosts brain function",
    ],
    bestTime: "Lunch or Dinner",
    ingredients: [
      "Glazed salmon fillet",
      "Quinoa",
      "Steamed broccoli",
      "Edamame",
      "Soy-ginger glaze",
    ],
  ),
  "Oats & Fresh Berries": const FoodDetailData(
    description:
        "A low-calorie breakfast powerhouse that provides excellent morning "
        "energy without the sugar crash. Rolled oats are packed with beta-glucan "
        "fiber that regulates blood sugar levels, while antioxidant-rich berries "
        "protect your cells from damage.",
    benefits: [
      "Steady energy release",
      "High in dietary fiber",
      "Regulates blood sugar",
      "Packed with antioxidants",
    ],
    bestTime: "Breakfast",
    ingredients: [
      "Rolled oats",
      "Fresh blueberries & strawberries",
      "Chia seeds",
      "Almond milk",
      "A drizzle of honey",
    ],
  ),
  "Avocado & Egg Toast": const FoodDetailData(
    description:
        "Healthy fats from avocado instantly crush cravings and keep you "
        "satisfied. Paired with whole grain bread and a perfectly poached egg, "
        "this meal delivers a balanced mix of protein, fats, and complex carbs "
        "to kickstart your morning metabolism.",
    benefits: [
      "Healthy monounsaturated fats",
      "Crushes hunger cravings",
      "Rich in potassium",
      "Supports eye health",
    ],
    bestTime: "Breakfast or Brunch",
    ingredients: [
      "Ripe avocado",
      "Poached egg",
      "Whole grain sourdough bread",
      "Red pepper flakes",
      "Lemon juice & sea salt",
    ],
  ),
  "Greek Yogurt & Honey": const FoodDetailData(
    description:
        "Creamy, high-protein snack that satisfies sweet cravings without "
        "packing on weight. Greek yogurt is loaded with probiotics that improve "
        "gut health, while raw honey provides natural sweetness along with "
        "antibacterial properties.",
    benefits: [
      "High in protein",
      "Supports gut health",
      "Satisfies sweet cravings",
      "Strengthens bones",
    ],
    bestTime: "Snack Time (morning or Afternoon)",
    ingredients: [
      "Thick Greek yogurt",
      "Raw organic honey",
      "Granola",
      "Fresh mixed berries",
      "Crushed walnuts",
    ],
  ),
  "Green Detox Smoothie": const FoodDetailData(
    description:
        "Packed with spinach, green apple, and ginger, this incredibly "
        "low-calorie smoothie acts as a powerful metabolism booster. It flushes "
        "toxins from the body, aids digestion, and delivers a concentrated dose "
        "of vitamins A, C, and K.",
    benefits: [
      "Powerful detox properties",
      "Boosts metabolism",
      "Extremely low calorie",
      "Rich in vitamins & minerals",
    ],
    bestTime: "Morning (on empty stomach)",
    ingredients: [
      "Fresh spinach",
      "Green apple",
      "Fresh ginger root",
      "Lemon juice",
      "Coconut water",
    ],
  ),

  // ── Weight Gain Foods ──
  "Peanut Butter Smoothie": const FoodDetailData(
    description:
        "A colossal calorie bomb that's perfect for bulking! Blended with ripe "
        "banana, whole milk, and whey protein powder, this smoothie delivers "
        "massive calories in a drinkable form. Peanut butter provides dense "
        "healthy fats and additional protein for muscle recovery.",
    benefits: [
      "Extremely calorie dense",
      "Fast muscle recovery",
      "Easy to consume calories",
      "Rich in healthy fats",
    ],
    bestTime: "Post-Workout or Breakfast",
    ingredients: [
      "Natural peanut butter (2 tbsp)",
      "Ripe banana",
      "Whole milk",
      "Whey protein powder",
      "Rolled oats",
    ],
  ),
  "Beef Steak & Rice": const FoodDetailData(
    description:
        "The ultimate muscle builder. Premium beef steak delivers massive iron "
        "content and complete amino acids, paired with easily digestible white "
        "rice for rapid glycogen replenishment. This is the go-to meal for "
        "serious bodybuilders during bulking season.",
    benefits: [
      "Complete amino acid profile",
      "High iron content",
      "Rapid glycogen replenishment",
      "Maximizes muscle protein synthesis",
    ],
    bestTime: "Lunch or Post-Workout Dinner",
    ingredients: [
      "Ribeye steak (8 oz)",
      "Jasmine white rice",
      "Sautéed garlic butter",
      "Steamed asparagus",
      "Sea salt & black pepper",
    ],
  ),
  "Mixed Nuts & Trail Mix": const FoodDetailData(
    description:
        "Calorie dense snacking made easy. A premium mix of almonds, walnuts, "
        "cashews, and dried fruits delivers continuous energy surplus throughout "
        "the day. Perfect for sneaking in extra calories between meals without "
        "feeling overly full.",
    benefits: [
      "Extremely calorie dense",
      "Rich in healthy fats",
      "Portable & convenient",
      "Provides sustained energy",
    ],
    bestTime: "Between Meals (Snack)",
    ingredients: [
      "Raw almonds",
      "Walnuts",
      "Cashews",
      "Dried cranberries & raisins",
      "Dark chocolate chips",
    ],
  ),
  "Whole Wheat Pasta Bowl": const FoodDetailData(
    description:
        "A gigantic bowl of complex carbs with rich meat sauce. Whole wheat "
        "pasta provides sustained energy release, while the meat sauce adds "
        "protein and flavor. This meal is crucial for heavy bulking phases "
        "when you need maximum carbohydrate intake.",
    benefits: [
      "Massive carb loading",
      "Sustained energy release",
      "Supports heavy training",
      "Easy to eat in large portions",
    ],
    bestTime: "Lunch or Pre-Workout ",
    ingredients: [
      "Whole wheat penne pasta",
      "Ground beef meat sauce",
      "Parmesan cheese",
      "Garlic & olive oil",
      "Fresh basil",
    ],
  ),
  "Double Beef Burger": const FoodDetailData(
    description:
        "A massive caloric surplus cheat meal packed with extreme protein and "
        "heavy fats. Two thick beef patties, melted cheese, and all the "
        "toppings deliver an insane amount of calories in one sitting. "
        "Perfect for weekly surplus days during aggressive bulking.",
    benefits: [
      "Extreme caloric surplus",
      "Massive protein intake",
      "Satisfies cravings completely",
      "Great for cheat/surplus days",
    ],
    bestTime: "Lunch (Surplus/Cheat Day)",
    ingredients: [
      "Double beef patties (200g each)",
      "Cheddar cheese slices",
      "Brioche bun",
      "Lettuce, tomato & onion",
      "Special sauce & pickles",
    ],
  ),
  "Stack of Protein Pancakes": const FoodDetailData(
    description:
        "Huge breakfast surplus loaded with whey protein, oats, and heavy maple "
        "syrup for massive gains. These fluffy pancakes taste like a treat but "
        "deliver serious macros to fuel your morning workouts and kickstart "
        "muscle protein synthesis for the day.",
    benefits: [
      "High protein breakfast",
      "Massive calorie surplus",
      "Tastes amazing",
      "Fuels intense morning workouts",
    ],
    bestTime: "Breakfast or Post-Workout",
    ingredients: [
      "Whey protein powder",
      "Rolled oats (blended)",
      "Eggs & banana",
      "Pure maple syrup",
      "Fresh berries on top",
    ],
  ),
};

class FoodDetailScreen extends StatelessWidget {
  final FoodItem item;

  const FoodDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final detail = _foodDetails[item.name];
    final Color primaryGreen = const Color(0xFF86CC55);
    final Color cardColor = const Color(0xFF1E1E24);

    return SubPageScaffold(
      backgroundColor: const Color(0xFF121215),
      parentTabIndex: 0,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: 'food_${item.name}',
                  child: Image.network(
                    item.imageUrl,
                    height: 320,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return Container(
                        height: 320,
                        color: cardColor,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF86CC55),
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 320,
                        color: cardColor,
                        child: const Center(
                          child: Icon(Icons.broken_image,
                              color: Colors.white38, size: 60),
                        ),
                      );
                    },
                  ),
                ),

                Container(
                  height: 320,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        const Color(0xFF121215),
                        Colors.black.withOpacity(0.3),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                  ),
                ),

                Positioned(
                  top: 50,
                  left: 16,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new,
                          color: Color(0xff86CC55), size: 20),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),

                /// Food name on the image
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Text(
                    item.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 10,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            /// ── BODY CONTENT ──
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ── CALORIE & MACRO CHIPS ──
                  Row(
                    children: [
                      _infoChip(
                        icon: Icons.local_fire_department,
                        iconColor: primaryGreen,
                        label: item.calories,
                        cardColor: cardColor,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _infoChip(
                          icon: Icons.pie_chart_outline,
                          iconColor: const Color(0xFF1E6BD1),
                          label: item.macros,
                          cardColor: cardColor,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  /// ── DESCRIPTION ──
                  _sectionTitle("About"),
                  const SizedBox(height: 10),
                  Text(
                    detail?.description ?? item.description,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.75),
                      height: 1.6,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 28),

                  /// ── INGREDIENTS ──
                  if (detail != null && detail.ingredients.isNotEmpty) ...[
                    _sectionTitle("Ingredients"),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: Colors.white.withOpacity(0.05)),
                      ),
                      child: Column(
                        children: detail.ingredients
                            .asMap()
                            .entries
                            .map((entry) => _ingredientRow(
                                  entry.value,
                                  isLast: entry.key ==
                                      detail.ingredients.length - 1,
                                ))
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 28),
                  ],

                  /// ── BENEFITS ──
                  if (detail != null && detail.benefits.isNotEmpty) ...[
                    _sectionTitle("Benefits"),
                    const SizedBox(height: 12),
                    ...detail.benefits.map(
                      (b) => _benefitTile(b, primaryGreen),
                    ),
                    const SizedBox(height: 28),
                  ],

                  /// ── BEST TIME ──
                  if (detail != null) ...[
                    _sectionTitle("Best Time to Eat"),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            primaryGreen.withOpacity(0.15),
                            const Color(0xFF1E6BD1).withOpacity(0.10),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: primaryGreen.withOpacity(0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.schedule,
                              color: primaryGreen, size: 22),
                          const SizedBox(width: 12),
                          Text(
                            detail.bestTime,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Helper Widgets ──

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _infoChip({
    required IconData icon,
    required Color iconColor,
    required String label,
    required Color cardColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor, size: 18),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: iconColor,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _ingredientRow(String text, {bool isLast = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 10),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: const Color(0xFF86CC55),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(
              color: Colors.white.withOpacity(0.75),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _benefitTile(String text, Color accentColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.check_rounded, color: accentColor, size: 16),
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
