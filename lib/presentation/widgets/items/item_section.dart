import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/cubit/items_cubit.dart';
import 'items.dart';

class ItemsSection extends StatelessWidget {
  const ItemsSection({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemsCubit, ItemsState>(
      builder: (context, state) {
        if (state is ItemsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ItemsLoaded) {
          return Column(
            children: [
              ListView.builder(
                itemCount: state.itemsList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ItemWidget(
                    itemsList: state.itemsList[index],
                  );
                },
              ),
              
            ],
          );
        } else if (state is ItemsError) {
          return const Center(child: Text('Error loading items'));
        }
        return const SizedBox.shrink();
      },
    );
  }
}