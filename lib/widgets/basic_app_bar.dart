import 'package:flutter/material.dart';

class BasicAppBar extends StatelessWidget implements PreferredSize {
  const BasicAppBar({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      titleTextStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 0.2),
      title: Text(title),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget get child => throw UnimplementedError();
}
