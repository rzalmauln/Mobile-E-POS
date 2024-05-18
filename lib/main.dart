import 'package:e_pos/views/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "Plus Jakarta Sans"),
      home: const Scaffold(
        body: LoginScreen(),
      ),
    );
  }
}
