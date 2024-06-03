import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff2563EB),
        actions: [
          GestureDetector(
            child: SvgPicture.asset("assets/icons/arrow-left.svg"),
          ),
          GestureDetector(
            child: Icon(Icons.abc),
          ),
        ],
      ),
    );
  }
}
