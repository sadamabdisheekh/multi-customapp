import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:multi/constants/app_constants.dart';
import 'package:multi/data/router_names.dart';
import 'package:multi/logic/cubit/category_cubit.dart';
import '../../constants/dimensions.dart';
import '../../constants/styles.dart';
import '../../data/models/modules_model.dart';
import '../widgets/custom_images.dart';

class CategoryScreen extends StatelessWidget {
  final ModulesModel category;
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
                centerTitle: false,
                title:  Text(category.moduleName)),
            SliverToBoxAdapter(
              child: BlocBuilder<CategoryCubit, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is CategoryError) {
                    return Center(child: Text(state.error.message));
                  }
                  if (state is CategoryLoaded) {
                    final list = state.categoryList;
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeSmall),
                      child: Column(
                        children: [
                          SizedBox(
                            height: Get.height * 0.18,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: list.length,
                              scrollDirection: Axis.horizontal,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                
                                return GestureDetector(
                                  onTap: () {
                                    
                                    Navigator.pushNamed(
                                        context, RouteNames.itemScreen,arguments: list[index]);
                                  },
                                  child: Padding(
                                    padding: index == 0
                                        ? const EdgeInsets.only(right: 12.0)
                                        : const EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                    child: SizedBox(
                                      width: 60,
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 50,
                                            padding: const EdgeInsets.all(8),
                                            margin: EdgeInsets.only(
                                              left: index == 0
                                                  ? 0
                                                  : Dimensions
                                                      .paddingSizeExtraSmall,
                                              right: Dimensions
                                                  .paddingSizeExtraSmall,
                                            ),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppConstants.lightGrey),
                                            child: CustomImage(
                                              path: AppConstants.categoryPath +
                                                  list[index].image,
                                              height: 26.82,
                                              width: 43.54,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: index == 0
                                                    ? Dimensions
                                                        .paddingSizeExtraSmall
                                                    : 0),
                                            child: Text(list[index].name,
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: robotoRegular.copyWith(
                                                    fontSize: 11)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                              height: Dimensions.paddingSizeExtraSmall),
                        ],
                      ),
                    );
                  }
                  return Container();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
