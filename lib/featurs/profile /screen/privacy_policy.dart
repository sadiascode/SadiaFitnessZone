import 'package:flutter/material.dart';
import '../../../common/app_shell.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return  SubPageScaffold(
      backgroundColor: const Color(0xFF121215),
      parentTabIndex: 4,
      appBar: AppBar(
        backgroundColor: const Color(0xFF121215),
        title: const Text(
          "Privacy Policy",
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
              "Privacy Policy",
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
              "Welcome to Top Talent Agency Gym App! We value your privacy. This Privacy Policy explains how we collect, use, and protect your personal information when you use our fitness application and gym services.",
              style: TextStyle(fontSize: 16, color: Colors.white.withValues(alpha: 0.9)),
            ),
            SizedBox(height: 20),
            Text(
              "1. Information We Collect",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff86CC55)),
            ),
            SizedBox(height: 5),
            Text(
              "- Personal Information: Name, email address, phone number, date of birth, and emergency contact details for membership verification and safety.\n"
                  "- Health and Fitness Data: Workout history, progress tracking, fitness goals, body measurements, and performance metrics.\n"
                  "- Membership Information: Subscription details, payment information, and gym access records.\n"
                  "- Usage Data: Features used, time spent in app, equipment usage frequency, and session duration.\n"
                  "- Device Information: Mobile device type, operating system, and unique device identifiers for app functionality.\n"
                  "- Location Data: Check-in times and gym location access for security and attendance tracking.",
              style: TextStyle(fontSize: 16, color: Colors.white.withValues(alpha: 0.8)),
            ),
            SizedBox(height: 20),
            Text(
              "2. How We Use Your Information",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff86CC55)),
            ),
            SizedBox(height: 5),
            Text(
              "- To provide and maintain your gym membership and app access.\n"
                  "- To track your workout progress and provide personalized fitness recommendations.\n"
                  "- To communicate gym updates, class schedules, and membership notifications.\n"
                  "- To process payments and manage your subscription.\n"
                  "- To ensure gym security and monitor facility access.\n"
                  "- To improve app features and workout programs based on usage patterns.\n"
                  "- To provide customer support and respond to your inquiries.",
              style: TextStyle(fontSize: 16, color: Colors.white.withValues(alpha: 0.8)),
            ),
            SizedBox(height: 20),
            Text(
              "3. Data Sharing and Disclosure",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff86CC55)),
            ),
            SizedBox(height: 5),
            Text(
              "- We do not sell your personal fitness or health information. We may share your data only in specific circumstances:\n"
                  "  • With payment processors for membership billing and transactions\n"
                  "  • With certified trainers (with your consent) for personalized workout planning\n"
                  "  • With healthcare providers (with your explicit consent) in case of emergencies\n"
                  "  • With law enforcement or legal authorities when required by law\n"
                  "  • With gym staff for facility management and safety purposes\n"
                  "  • During business transfers (e.g., gym sale) with privacy protections maintained.",
              style: TextStyle(fontSize: 16, color: Colors.white.withValues(alpha: 0.8)),
            ),
            SizedBox(height: 20),
            Text(
              "4. Workout Data and Analytics",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff86CC55)),
            ),
            SizedBox(height: 5),
            Text(
              "- Your workout data is used to provide personalized fitness insights and progress tracking.\n"
                  "- We analyze anonymized workout patterns to improve gym equipment layout and class scheduling.\n"
                  "- Performance metrics help us suggest appropriate workout intensity and duration.\n"
                  "- You can choose to share or hide specific workout achievements in the community section.\n"
                  "- Historical workout data is retained for 2 years unless you request earlier deletion.",
              style: TextStyle(fontSize: 16, color: Colors.white.withValues(alpha: 0.8)),
            ),
            SizedBox(height: 20),
            Text(
              "5. Data Security Measures",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff86CC55)),
            ),
            SizedBox(height: 5),
            Text(
              "- We use industry-standard encryption to protect your personal and payment information.\n"
                  "- Gym access data is stored securely with limited staff access.\n"
                  "- Regular security audits and vulnerability assessments are conducted.\n"
                  "- Staff members are trained on privacy protection and data handling procedures.\n"
                  "- Secure servers with backup systems to prevent data loss.",
              style: TextStyle(fontSize: 16, color: Colors.white.withValues(alpha: 0.8)),
            ),
            SizedBox(height: 20),
            Text(
              "6. Your Privacy Rights",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff86CC55)),
            ),
            SizedBox(height: 5),
            Text(
              "- Access: View all personal information we have collected about you.\n"
                  "- Correction: Update inaccurate personal details and contact information.\n"
                  "- Deletion: Request removal of your account and associated data.\n"
                  "- Portability: Export your workout data and progress information.\n"
                  "- Restriction: Limit how we use your personal information.\n"
                  "- Objection: Opt-out of marketing communications and data analytics.",
              style: TextStyle(fontSize: 16, color: Colors.white.withValues(alpha: 0.8)),
            ),
            SizedBox(height: 20),
            Text(
              "7. Age Requirements and Minors",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff86CC55)),
            ),
            SizedBox(height: 5),
            Text(
              "- Our gym app and services are intended for users 16 years and older.\n"
                  "- Users under 18 require parental consent for membership and data processing.\n"
                  "- Parents can review, modify, or delete their child's account information.\n"
                  "- We limit data collection from minors to essential membership and safety information only.",
              style: TextStyle(fontSize: 16, color: Colors.white.withValues(alpha: 0.8)),
            ),
            SizedBox(height: 20),
            Text(
              "8. Changes to This Privacy Policy",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff86CC55)),
            ),
            SizedBox(height: 5),
            Text(
              "- We may update this privacy policy to reflect changes in our practices or legal requirements.\n"
                  "- Significant changes will be notified via email and in-app notifications.\n"
                  "- Continued use of the app after changes constitutes acceptance of the updated policy.\n"
                  "- The 'Effective Date' will be updated with each revision.",
              style: TextStyle(fontSize: 16, color: Colors.white.withValues(alpha: 0.8)),
            ),
            SizedBox(height: 20),
            Text(
              "9. Contact Us",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff86CC55)),
            ),
            SizedBox(height: 5),
            Text(
              "For privacy-related questions or to exercise your rights:\n\n"
                  "Privacy Officer: privacy@toptalentagency.com\n"
                  "Gym Support: support@toptalentagency.com\n"
                  "Phone: +880 1234-567890\n"
                  "Address: Top Talent Agency, Privacy Department, Dhaka, Bangladesh\n\n"
                  "Response Time: We respond to privacy inquiries within 5 business days.",
              style: TextStyle(fontSize: 16, color: Colors.white.withValues(alpha: 0.8)),
            ),
            SizedBox(height: 20),
            Text(
              "10. Data Retention",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff86CC55)),
            ),
            SizedBox(height: 5),
            Text(
              "- Workout and progress data: Retained for 2 years after account closure\n"
                  "- Membership and billing records: Retained for 7 years as required by law\n"
                  "- Facility access logs: Retained for 90 days for security purposes\n"
                  "- Customer support communications: Retained for 3 years\n"
                  "- Analytics data: Anonymized after 12 months",
              style: TextStyle(fontSize: 16, color: Colors.white.withValues(alpha: 0.8)),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}