import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/constants/app_constants.dart';
import 'package:multi/data/router_names.dart';
import 'package:multi/logic/cubit/category_cubit.dart';
import '../../constants/dimensions.dart';
import '../../data/models/modules_model.dart';
import '../widgets/categories/category_item.dart';

class CategoryScreen extends StatelessWidget {
  final ModulesModel category;
  const CategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
            context.read<CategoryCubit>().getCategory(null);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              floating: true,
              elevation: 0,
              backgroundColor: Theme.of(context).colorScheme.background,
              centerTitle: false,
              title: Text(category.moduleName),
            ),
            SliverToBoxAdapter(
              child: BlocBuilder<CategoryCubit, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CategoryError) {
                    return Center(child: Text(state.error.message));
                  } else if (state is CategoryLoaded) {
                    final list = state.categoryList;
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeSmall),
                      child: SizedBox(
                        height: 160,
                        child: ListView.builder(
                          itemCount: list.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final item = list[index];
                            return CategoryItem(
                              imagePath: AppConstants.categoryPath + item.image,
                              name: item.name,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  RouteNames.itemScreen,
                                  arguments: item,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
