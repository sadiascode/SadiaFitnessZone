import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
  final supabase = Supabase.instance.client;
  bool isLoading = true;

  String name = "N/A";
  String email = "N/A";
  String address = "N/A";
  String age = "0";
  String health = "N/A";
  String wakeup = "N/A";
  String? avatarUrl;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    setState(() {
      isLoading = true;
    });

    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) {
        setState(() => isLoading = false);
        return;
      }

      final data = await supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();

      if (mounted) {
        setState(() {
          name = data['full_name'] ?? "N/A";
          email = data['email'] ?? "N/A";
          address = data['address'] ?? "N/A";
          age = data['age']?.toString() ?? "N/A";
          health = data['health_condition'] ?? "N/A";
          wakeup = data['wakeup_time'] ?? "N/A";
          avatarUrl = data['avatar_url'];
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load profile: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

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
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xff86CC55)))
          : SingleChildScrollView(
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
                                  child: ClipOval(
                                    child: avatarUrl != null && avatarUrl!.isNotEmpty
                                        ? Image.network(
                                            avatarUrl!,
                                            fit: BoxFit.cover,
                                            loadingBuilder: (context, child, loadingProgress) {
                                              if (loadingProgress == null) return child;
                                              return const Center(child: CircularProgressIndicator(color: Colors.white));
                                            },
                                            errorBuilder: (context, error, stackTrace) =>
                                                const Icon(Icons.person, size: 100, color: Colors.white),
                                          )
                                        : const Icon(
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
                              onTap: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const EditScreen(),
                                  ),
                                );
                                if (result == true) {
                                  loadProfile();
                                }
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