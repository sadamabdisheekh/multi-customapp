import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).primaryColor;
    return Center(
      child: CircularProgressIndicator(color: c),
    );
  }
}
