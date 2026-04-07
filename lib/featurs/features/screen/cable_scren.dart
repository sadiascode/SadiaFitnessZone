import 'package:flutter/material.dart';
import 'main.dart'; // Equipment class এর জন্য import

class CableStationScreen extends StatelessWidget {
  final Equipment item;

  const CableStationScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final Color bgColor = const Color(0xFF121215);
    final Color primaryGreen = const Color(0xFF86CC55);

    return Scaffold(
      backgroundColor: bgColor,
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
                color: primaryGreen.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: primaryGreen.withOpacity(0.5)),
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
                Chip(label: Text("Chest")),
                Chip(label: Text("Back")),
                Chip(label: Text("Triceps")),
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
              "1. Adjust the pulleys to desired height.\n"
                  "2. Select appropriate weight.\n"
                  "3. Perform chest flies, lat pulldowns, or tricep pushdowns with controlled movements.",
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
              "• Keep movements slow and controlled.\n"
                  "• Focus on mind-muscle connection.\n"
                  "• Avoid shrugging shoulders during exercises.",
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 100), // bottom padding for button
          ],
        ),
      ),

      // Bottom button
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: const Color(0xFF1E1E24),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryGreen,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          onPressed: () {
            // Start workout action
          },
          child: const Text(
            "Start Workout",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }
}