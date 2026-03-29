import 'package:flutter/material.dart';
import '../auth/screen/login_screen.dart';

class Todo extends StatelessWidget {
  const Todo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: "Top Talent Agency",
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}