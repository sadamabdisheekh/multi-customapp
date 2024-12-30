import 'dart:io';

import 'package:flutter/material.dart';

class AppbarLeading extends StatelessWidget {
  const AppbarLeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: Container(
          height: 35.0,
          width: 35.0,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            // Icons.arrow_back_ios_new,
            Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios_new,
            color: Theme.of(context).cardColor,
          ),
        ),
      ),
    );
  }
}
