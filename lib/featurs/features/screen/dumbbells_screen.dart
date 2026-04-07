import 'package:flutter/material.dart';
import '../../../common/app_shell.dart';
import 'features_screen.dart';


class DumbbellsScreen extends StatelessWidget {
  final Equipment item;

  const DumbbellsScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final Color bgColor = const Color(0xFF121215);
    final Color primaryGreen = const Color(0xFF86CC55);

    return  SubPageScaffold(
      backgroundColor: const Color(0xFF121215),
      parentTabIndex: 1,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(item.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(item.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Category badge
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
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Description
            Text(
              item.description,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),

            // Target muscles
            const Text(
              "Target Muscles",
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              children: const [
                Chip(label: Text("Arms")),
                Chip(label: Text("Shoulders")),
                Chip(label: Text("Legs")),
              ],
            ),
            const SizedBox(height: 20),

            // How to Use
            const Text(
              "How to Use",
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "1. Grab a pair of dumbbells.\n"
                  "2. Perform bicep curls, shoulder presses, and lunges.\n"
                  "3. Maintain proper form for safety and effectiveness.",
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 20),

            // Tips
            const Text(
              "Tips",
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "• Start with lighter weights if you are a beginner.\n"
                  "• Keep your back straight during exercises.\n"
                  "• Control the movement, avoid swinging the weights.",
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 100), // bottom padding for button
          ],
        ),
      ),
    );
  }
}