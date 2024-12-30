import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.title,
  });

  final String title;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.background,
      title: Text(title),
    );
  }
}
