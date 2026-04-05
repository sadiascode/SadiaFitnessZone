import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo/featurs/auth/screen/signup_screen.dart';
import 'package:todo/featurs/home%20/screen/home_screen.dart';
import '../../../common/custom_button.dart';
import '../../../common/app_shell.dart';
import '../widget/custom_screen.dart';
import '../widget/custom_text_field.dart';
import 'forget_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = false;
  final email = TextEditingController();
  final password = TextEditingController();
  bool loading = false;

  final supabase = Supabase.instance.client;

  // Supabase login function
  login() async {
    if (email.text.isEmpty || password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter email and password')),
      );
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      final response = await supabase.auth.signInWithPassword(
        email: email.text.trim(),
        password: password.text,
      );

      if (response.user != null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const AppShell()),
              (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid email or password')),
        );
      }
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unexpected error: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: CustomScreen(
        svgPath: 'assets/logo.png',
        svgHeight: 180,
        svgWidth: 130,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: const Text(
                "Welcome to Sadia Fitness Zone",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87),
              ),
            ),
            const SizedBox(height: 16),
            const Text("Enter Email", style: TextStyle(color: Colors.black87)),
            const SizedBox(height: 6),
            CustomTextfield(
              hintText: "Enter Your Email",
              controller: email,
            ),
            const SizedBox(height: 12),
            const Text("Password", style: TextStyle(color: Colors.black87)),
            const SizedBox(height: 6),
            CustomTextfield(
              hintText: "Enter Your Password",
              isPassword: true,
              controller: password,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: rememberMe,
                      onChanged: (bool? value) {
                        setState(() {
                          rememberMe = value ?? false;
                        });
                      },
                      checkColor: Colors.white,
                      activeColor: const Color(0xff3CB189),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      "Remember Me",
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ForgetScreen()),
                    );
                  },
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(fontSize: 14, color: Color(0xff3CB189)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            loading
                ? const Center(child: CircularProgressIndicator())
                : CustomButton(
                    text: "Sign in",
                    onTap: login,
                  ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account? ",
                  style: TextStyle(color: Colors.black87, fontSize: 14),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const SignupScreen()),
                    );
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Color(0xff3CB189),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}