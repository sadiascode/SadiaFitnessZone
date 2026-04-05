import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo/featurs/auth/screen/login_screen.dart';
import '../../../common/custom_button.dart';
import '../widget/custom_screen.dart';
import '../widget/custom_text_field.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  final emailController = TextEditingController();
  bool loading = false;

  final supabase = Supabase.instance.client;

  Future<void> sendResetEmail() async {
    if (emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email')),
      );
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      await supabase.auth.resetPasswordForEmail(emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset link sent to your email')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
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
    emailController.dispose();
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
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            const Center(
              child: Text(
                "Forgot Password?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 10),

            const Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Text(
                "Enter your email and we will send you a \n                  verification code.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 30),

            Text(
              "Email",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 10),
            CustomTextfield(
              hintText: "Enter your email address",
              controller: emailController,
            ),

            const SizedBox(height: 30),
            loading
                ? const Center(child: CircularProgressIndicator())
                : CustomButton(
                    text: "Send code",
                    onTap: sendResetEmail,
                  ),
          ],
        ),
      ),
    );
  }
}