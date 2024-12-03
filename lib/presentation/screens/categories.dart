import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/data/models/category.dart';
import 'package:multi/data/router_names.dart';
import 'package:multi/logic/cubit/category_cubit.dart';
import '../../constants/app_constants.dart';
import '../../constants/dimensions.dart';
import '../../constants/styles.dart';
import '../../data/models/modules_model.dart';
import '../widgets/custom_images.dart';

class CategoryScreen extends StatefulWidget {
  final ModulesModel category;

  const CategoryScreen({super.key, required this.category});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().getCategory(null);
  }

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
              title: Text(
                widget.category.moduleName,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            _buildCategoryGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryGrid() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return const SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()),
            );
          }
          if (state is CategoryError) {
            return SliverToBoxAdapter(
              child: Center(
                child: Text(
                  state.error.message,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
            );
          }
          if (state is CategoryLoaded) {
            return _buildGrid(state.categoryList);
          }
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        },
      ),
    );
  }

  Widget _buildGrid(List<CategoryModel> categories) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: MediaQuery.of(context).size.width / 3,
        mainAxisExtent: 128,
        crossAxisSpacing:
            MediaQuery.of(context).size.width * 0.04, // 4% spacing
        mainAxisSpacing: MediaQuery.of(context).size.width * 0.04, // 4% spacing
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final category = categories[index];
          return _buildCategoryItem(category);
        },
        childCount: categories.length,
      ),
    );
  }

  Widget _buildCategoryItem(CategoryModel category) {
    return InkWell(
      onTap: () {
        print(category);
        Navigator.pushNamed(
          context,
          RouteNames.itemScreen,
          arguments: category,
        );
      },
      borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(Dimensions.fontSizeOverSmall),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade200, width: 2),
            ),
            child: ClipOval(
              child: CustomImage(
                path: AppConstants.categoryPath + category.image,
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: Dimensions.paddingSizeSmall),
          Text(
            category.name,
            style: robotoMedium.copyWith(
              fontSize: Dimensions.fontSizeSmall,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
