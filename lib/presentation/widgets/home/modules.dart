import 'package:flutter/material.dart';
import 'package:multi/data/models/modules_model.dart';
import 'package:multi/data/router_names.dart';
import 'package:multi/presentation/widgets/custom_images.dart';

import '../../../constants/app_constants.dart';
import '../../../constants/styles.dart';

class ModuleWidget extends StatelessWidget {
  const ModuleWidget({
    super.key,
    required this.products,
  });

  final List<ModulesModel> products;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) return const Center(child: Text('No Module found'));
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.only(bottom: 30),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 100,
        mainAxisExtent: 128,
        crossAxisSpacing: 19,
        mainAxisSpacing: 19,
      ),
      itemCount: products.length,
      itemBuilder: (BuildContext ctx, index) {
        return InkWell(
          onTap: () {
            Navigator.pushNamed(context, RouteNames.categoryScreen,
                arguments: products[index]);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: AppConstants.lightGrey),
                child: CustomImage(
                  path: '${AppConstants.modulePath}/${products[index].image}',
                  height: 26.82,
                  width: 43.54,
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              Text(products[index].moduleName,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: robotoMedium),
            ],
          ),
        );
      },
    );
  }
}
