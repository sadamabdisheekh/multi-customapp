import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/data/models/modules_model.dart';
import 'package:multi/data/router_names.dart';
import 'package:multi/logic/cubit/category_cubit.dart';
import 'package:multi/presentation/widgets/custom_images.dart';

import '../../../constants/app_constants.dart';
import '../../../constants/dimensions.dart';
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
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: Dimensions.paddingSizeSmall,
        crossAxisSpacing: Dimensions.paddingSizeSmall,
        childAspectRatio: (1 / 1),
      ),
      itemCount: products.length,
      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext ctx, index) {
        return InkWell(
          onTap: () {
            context.read<CategoryCubit>().getCategory();
            Navigator.pushNamed(context, RouteNames.categoryScreen,
                arguments: products[index]);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
              color: Theme.of(context).cardColor,
              border: Border.all(
                  color: Theme.of(context).primaryColor, width: 0.15),
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3)
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                  child: CustomImage(
                    path: '${AppConstants.modulePath}/${products[index].image}',
                    width: 50,
                    height: 50,
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeSmall),
                Center(
                  child: Text(
                    products[index].moduleName,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: robotoMedium.copyWith(
                      fontSize: Dimensions.fontSizeSmall,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
