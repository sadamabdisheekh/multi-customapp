import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/logic/cubit/category_cubit.dart';
import 'package:multi/presentation/screens/category/widgets/category_list.dart';
import '../../../data/models/modules_model.dart';

class CategoryScreen extends StatefulWidget {
  final ModulesModel module;

  const CategoryScreen({super.key, required this.module});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().getCategory(null,widget.module.id);
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
                widget.module.moduleName,
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
          return const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is CategoryError) {
          return SliverFillRemaining(
            child: Center(
              child: Text(
                state.error.message,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
          );
        }
        if (state is CategoryLoaded) {
          if (state.categoryList.isEmpty) {
            return  SliverFillRemaining(
              child: Center(
                child: Text(
                  'No Categories Found',
                  style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                ),
              ),
            );
          }
          return CategoryList(categories: state.categoryList, module: widget.module);
          // return _buildGrid(state.categoryList);
        }
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    ),
  );
  }

}
