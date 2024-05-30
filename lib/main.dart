import 'package:e_pos/views/keranjang/order_view.dart';
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
      home: Scaffold(
        body: Center(
          child: OrderView(),
        ),
      ),
    );
  }
}
