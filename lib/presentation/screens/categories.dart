import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi/constants/app_constants.dart';
import 'package:multi/constants/images.dart';
import 'package:multi/data/router_names.dart';
import '../../constants/dimensions.dart';
import '../../constants/styles.dart';
import '../widgets/custom_images.dart';

class CategoryScreen extends StatelessWidget {
  final dynamic category;
  const CategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverAppBar(
            floating: true,
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.background,
            title: const Text('')),
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeSmall),
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.18,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: 8,
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RouteNames.itemScreen);
                        },
                        child: Padding(
                          padding: index == 0
                              ? const EdgeInsets.only(right: 12.0)
                              : const EdgeInsets.symmetric(horizontal: 15.0),
                          child: SizedBox(
                            width: 56,
                            child: Column(
                              children: [
                                Container(
                                  height: 56,
                                  width: 56,
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppConstants.lightGrey),
                                  child: CustomImage(
                                    path: Kimages.logo,
                                    height: 26.82,
                                    width: 43.54,
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text("Burgar",
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    style: robotoMedium),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeExtraSmall),
              
              ],
            ),
          ),
        )
      ],
    )));
  }
}
