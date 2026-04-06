import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../common/app_shell.dart';
import '../featurs/auth/screen/login_screen.dart';

class Todo extends StatelessWidget {
  const Todo({super.key});

  @override
  Widget build(BuildContext context) {
    // Check if there is an active session
    final session = Supabase.instance.client.auth.currentSession;

    return MaterialApp(
      title: "Top Talent Agency",
      debugShowCheckedModeBanner: false,
      home: session != null ? const AppShell() : const LoginScreen(),
    );
  }
}