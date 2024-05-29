import 'package:e_pos/views/home/home_page.dart';
import 'package:e_pos/views/store_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(
          // body: Center(
          //   child: StoreScreen(),
          // ),
          ),
    );
  }
}
