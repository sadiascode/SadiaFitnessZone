import 'package:flutter/material.dart';
import '../../../common/app_shell.dart';
import '../../../common/custom_color.dart';
import '../widget/custom_medium.dart';
import '../widget/custom_txt.dart';
import 'edit_screen.dart';

class MyprofileScreen extends StatefulWidget {
  const MyprofileScreen({super.key});

  @override
  State<MyprofileScreen> createState() => _MyprofileScreenState();
}

class _MyprofileScreenState extends State<MyprofileScreen> {


  String name = "Sadia Akter";
  String email = "sadia@email.com";
  String address = "Dhaka, Bangladesh";
  String age = "25";
  String health = "Good";
  String wakeup = "7:00 AM";
  String breakfast = "9:00 AM";
  String lunch = "2:00 PM";
  String dinner = "9:00 PM";

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      parentTabIndex: 4,
      backgroundColor: const Color(0xFF121215),
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: const Color(0xFF121215),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20,
          ),
        ),
        title: const Text(
          "My Profile",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(height: 20),

              Container(
                height: 293,
                width: 380,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E24),
                  borderRadius: BorderRadius.circular(16),
                  border: const Border(
                    left: BorderSide(color: Color(0xff86CC55), width: 1),
                    top: BorderSide(color: Color(0xff86CC55), width: 1),
                    right: BorderSide(color: Color(0xff86CC55), width: 1),
                    bottom: BorderSide(color: Color(0xff86CC55), width: 1),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff86CC55).withValues(alpha: 0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 170,
                            height: 170,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: AppColors.primaryGradient,
                              ),
                            ),
                            child: const ClipOval(
                              child: Icon(
                                Icons.person,
                                size: 100,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Positioned(
                      top: 16,
                      right: 16,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EditScreen(),
                            ),
                          );
                        },
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: const Color(0xff86CC55).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 23,
                            color: Color(0xff86CC55),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              CustomMedium(text: "Profile Info", onTap: () {}),

              const SizedBox(height: 15),

              CustomTxt(title: "Full Name:", subtitle: name),
              const SizedBox(height: 5),

              CustomTxt(title: "Email:", subtitle: email),
              const SizedBox(height: 5),

              CustomTxt(title: "Address:", subtitle: address),

              const SizedBox(height: 20),

              CustomMedium(text: "Other Info", onTap: () {}),

              const SizedBox(height: 15),

              CustomTxt(title: "Age:", subtitle: age),
              const SizedBox(height: 5),

              CustomTxt(title: "Health condition:", subtitle: health),
              const SizedBox(height: 5),

              CustomTxt(title: "Wakeup time:", subtitle: wakeup),
              const SizedBox(height: 5),

              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }
}