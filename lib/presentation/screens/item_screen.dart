import 'package:flutter/material.dart';

import '../../constants/dimensions.dart';
import '../widgets/categories/sub_category.dart';
import '../widgets/categories/sub_category2.dart';
import '../widgets/items/items.dart';

class ItemScreen extends StatelessWidget {
  const ItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeSmall, vertical: 50),
          child: const Column(
            children: [
              SubCategory2(),
              SizedBox(
                height: 20,
              ),
              SubCategory(),
              SizedBox(
                height: 20,
              ),
              ItemWidget()
            ],
          ),
        ),
      ),
    );
  }
}
