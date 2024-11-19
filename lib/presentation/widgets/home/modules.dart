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
    Key? key,
    required this.products,
  }) : super(key: key);

  final List<ModulesModel> products;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(child: Text('No modules found', style: TextStyle(fontSize: 16)));
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: Dimensions.paddingSizeSmall,
        crossAxisSpacing: Dimensions.paddingSizeSmall,
        childAspectRatio: 1,
      ),
      itemCount: products.length,
      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return _buildModuleItem(context, products[index]);
      },
    );
  }

  Widget _buildModuleItem(BuildContext context, ModulesModel module) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          RouteNames.categoryScreen,
          arguments: module,
        );
      },
      borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          color: Theme.of(context).cardColor,
          border: Border.all(
            color: Theme.of(context).primaryColor.withOpacity(0.3),
            width: 0.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildImage(module.image),
            const SizedBox(height: Dimensions.paddingSizeSmall),
            _buildModuleName(context, module.moduleName),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
      child: CustomImage(
        path: '${AppConstants.modulePath}/$imagePath',
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildModuleName(BuildContext context, String name) {
    return Center(
      child: Text(
        name,
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: robotoMedium.copyWith(
          fontSize: Dimensions.fontSizeSmall,
          color: Theme.of(context).textTheme.bodyMedium?.color,
        ),
      ),
    );
  }
}
