import 'package:flutter/material.dart';
import 'package:multi/data/models/category.dart';
import 'package:multi/presentation/widgets/variation.dart';

import '../../constants/dimensions.dart';
import '../widgets/items/items.dart';

class ItemScreen extends StatelessWidget {
  const ItemScreen({super.key, required CategoryModel category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeSmall, vertical: 50),
        child: const SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              // SubCategory(),
              SizedBox(
                height: 20,
              ),
              ItemWidget(),

              AddonView(item: []),
              NewVariationView(
                  item: [],
                  discount: 0,
                  discountType: '',
                  showOriginalPrice: true),
            ],
          ),
        ),
      ),
    );
  }
}
