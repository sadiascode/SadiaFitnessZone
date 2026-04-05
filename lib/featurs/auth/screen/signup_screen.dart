import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../common/custom_button.dart';
import '../widget/custom_screen.dart';
import '../widget/custom_text_field.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;

  final supabase = Supabase.instance.client;

  Future<void> signUp() async {
    if (fullNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      final response = await supabase.auth.signUp(
        email: emailController.text.trim(),
        password: passwordController.text,
        data: {'full_name': fullNameController.text.trim()},
      );

      if (response.user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account created! Please log in.')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
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
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScreen(
        svgPath: 'assets/logo.png',
        svgHeight: 180,
        svgWidth: 130,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Text("Full Name"),
            const SizedBox(height: 6),
            CustomTextfield(
              hintText: "Enter your full name",
              controller: fullNameController,
            ),

            const SizedBox(height: 12),

            const Text("Email"),
            const SizedBox(height: 6),
            CustomTextfield(
              hintText: "Enter your email",
              controller: emailController,
            ),

            const SizedBox(height: 12),

            const Text("Password"),
            const SizedBox(height: 6),
            CustomTextfield(
              hintText: "Enter password",
              isPassword: true,
              controller: passwordController,
            ),

            const SizedBox(height: 20),
            loading
                ? const Center(child: CircularProgressIndicator())
                : CustomButton(
                    text: "Sign Up",
                    onTap: signUp,
                  ),
          ],
        ),
      ),
    );
  }
}