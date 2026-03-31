import 'package:flutter/material.dart';
import '../../../common/app_shell.dart';

class TermsConditions extends StatelessWidget {
  const TermsConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      backgroundColor: const Color(0xFF121215),
      parentTabIndex: 4,
      appBar: AppBar(
        backgroundColor: const Color(0xFF121215),
        title: const Text(
          "Terms and Conditions",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xff86CC55), size: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Terms and Conditions",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Effective Date: March 31, 2026",
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.white.withValues(alpha: 0.7)),
            ),
            SizedBox(height: 20),
            Text(
              "Welcome to Top Talent Agency Gym App! These Terms and Conditions govern your use of our fitness application and services.",
              style: TextStyle(fontSize: 16, color: Colors.white.withValues(alpha: 0.9)),
            ),
            SizedBox(height: 20),
            Text(
              "1. Acceptance of Terms",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff86CC55)),
            ),
            SizedBox(height: 5),
            Text(
              "By downloading, installing, or using our app, you agree to be bound by these Terms and Conditions. If you do not agree, please do not use our app.",
              style: TextStyle(fontSize: 16, color: Colors.white.withValues(alpha: 0.8)),
            ),
            SizedBox(height: 20),
            Text(
              "2. Membership and Account",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff86CC55)),
            ),
            SizedBox(height: 5),
            Text(
              "- You must create an account to access gym features and track workouts.\n"
                  "- You are responsible for maintaining the confidentiality of your login credentials.\n"
                  "- You must provide accurate personal information for membership verification.\n"
                  "- You must be at least 16 years old to create an account.\n"
                  "- Membership fees and payment terms are as specified in your subscription plan.",
              style: TextStyle(fontSize: 16, color: Colors.white.withValues(alpha: 0.8)),
            ),
            SizedBox(height: 20),
            Text(
              "3. Gym Equipment Usage",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff86CC55)),
            ),
            SizedBox(height: 5),
            Text(
              "- Use gym equipment responsibly and follow safety guidelines.\n"
                  "- Clean equipment after use using provided sanitation supplies.\n"
                  "- Do not use equipment beyond your physical capabilities.\n"
                  "- Report any damaged or malfunctioning equipment immediately.\n"
                  "- Wear appropriate workout attire and footwear at all times.",
              style: TextStyle(fontSize: 16, color: Colors.white.withValues(alpha: 0.8)),
            ),
            SizedBox(height: 20),
            Text(
              "4. Workout Programs and Training",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff86CC55)),
            ),
            SizedBox(height: 5),
            Text(
              "- Workout programs provided are for general fitness guidance.\n"
                  "- Consult with certified trainers for personalized workout plans.\n"
                  "- Progress at your own pace and avoid overexertion.\n"
                  "- Stay hydrated and take breaks as needed during workouts.\n"
                  "- Follow proper form and technique to prevent injuries.",
              style: TextStyle(fontSize: 16, color: Colors.white.withValues(alpha: 0.8)),
            ),
            SizedBox(height: 20),
            Text(
              "5. Health and Safety Disclaimer",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff86CC55)),
            ),
            SizedBox(height: 5),
            Text(
              "IMPORTANT: Your health and safety are your responsibility:\n"
                  "- Consult with a healthcare professional before starting any fitness program.\n"
                  "- Inform us of any medical conditions or physical limitations.\n"
                  "- Stop exercising immediately if you feel dizzy, nauseous, or experience pain.\n"
                  "- We are not liable for injuries, accidents, or health issues resulting from app usage.\n"
                  "- Emergency contact information must be kept up to date in your profile.",
              style: TextStyle(fontSize: 16, color: Colors.white.withValues(alpha: 0.8)),
            ),
            SizedBox(height: 20),
            Text(
              "6. Gym Facility Rules",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff86CC55)),
            ),
            SizedBox(height: 5),
            Text(
              "- Respect other members and maintain a positive gym environment.\n"
                  "- No unauthorized personal training or coaching.\n"
                  "- Follow gym hours and schedule guidelines.\n"
                  "- Do not drop weights or create excessive noise.\n"
                  "- Adhere to dress code and personal hygiene standards.\n"
                  "- No food or drinks (except water) in workout areas.",
              style: TextStyle(fontSize: 16, color: Colors.white.withValues(alpha: 0.8)),
            ),
            SizedBox(height: 20),
            Text(
              "7. Subscription and Payments",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff86CC55)),
            ),
            SizedBox(height: 5),
            Text(
              "- Membership fees are charged monthly/annually as per your selected plan.\n"
                  "- All payments are processed securely through our payment partners.\n"
                  "- No refunds for partial months or unused days in the current billing cycle.\n"
                  "- Prices are subject to change with 30 days prior notice.\n"
                  "- Failed payments may result in temporary suspension of access.",
              style: TextStyle(fontSize: 16, color: Colors.white.withValues(alpha: 0.8)),
            ),
            SizedBox(height: 20),
            Text(
              "8. Cancellation and Termination",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff86CC55)),
            ),
            SizedBox(height: 5),
            Text(
              "- You can cancel your membership at any time through your account settings.\n"
                  "- Cancellation takes effect at the end of the current billing period.\n"
                  "- We reserve the right to terminate accounts for violations of these terms.\n"
                  "- Terminated accounts lose access to all features and stored data after 30 days.",
              style: TextStyle(fontSize: 16, color: Colors.white.withValues(alpha: 0.8)),
            ),
            SizedBox(height: 20),
            Text(
              "9. Limitation of Liability",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff86CC55)),
            ),
            SizedBox(height: 5),
            Text(
              "To the fullest extent permitted by law, Top Talent Agency shall not be liable for any indirect, incidental, special, or consequential damages resulting from your use of the app or gym services, including but not limited to personal injury or health issues.",
              style: TextStyle(fontSize: 16, color: Colors.white.withValues(alpha: 0.8)),
            ),
            SizedBox(height: 20),
            Text(
              "10. Changes to Terms",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff86CC55)),
            ),
            SizedBox(height: 5),
            Text(
              "We reserve the right to modify these Terms at any time. Changes will be effective immediately upon posting in the app. Continued use of the app constitutes acceptance of any changes.",
              style: TextStyle(fontSize: 16, color: Colors.white.withValues(alpha: 0.8)),
            ),
            SizedBox(height: 20),
            Text(
              "11. Contact Information",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff86CC55)),
            ),
            SizedBox(height: 5),
            Text(
              "For questions about these Terms and Conditions or any gym-related matters:\n\n"
                  "Email: support@toptalentagency.com\n"
                  "Phone: +880 1234-567890\n"
                  "Address: Top Talent Agency, Dhaka, Bangladesh\n\n"
                  "Gym Hours: 6:00 AM - 10:00 PM (Daily)\n"
                  "Emergency Contact: +880 1234-567891",
              style: TextStyle(fontSize: 16, color: Colors.white.withValues(alpha: 0.8)),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
