import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/data/models/items_model.dart';
import 'package:multi/data/providers/error/custom_error.dart';
import 'package:multi/data/repository/item_repository.dart';
import 'package:multi/logic/cubit/category_cubit.dart';

part 'items_state.dart';

class ItemsCubit extends Cubit<ItemsState> {
  final ItemsRepository _itemsRepository;

  late StreamSubscription categoryCubitSubscription;
  late StreamSubscription subCategoryCubitSubscription;

  final CategoryCubit categoryCubit;

  ItemsCubit(
      {required itemsRepository,
      required this.categoryCubit,})
      : _itemsRepository = itemsRepository,
        super(ItemsInitial()) {
    categoryCubitSubscription =
        categoryCubit.stream.listen((CategoryState categoryState) {
      filterData();
    });

  }

  void filterData() {
    Map<String, dynamic> body = {};

    if (categoryCubit.state is CategoryLoaded) {
      final categoryState = categoryCubit.state as CategoryLoaded;
      if (categoryState.categoryList.isNotEmpty) {
        body['categoryId'] = categoryState.categoryList.first.id;
      }
    }
  }

  getItems(Map<String, dynamic> body) async {
    emit(ItemsLoading());

    final result = await _itemsRepository.getItems(body);
    result.fold(
      (failure) {
        var errorState = ItemsError(
            error: CustomError(
                statusCode: failure.statusCode, message: failure.message));
        emit(errorState);
      },
      (value) {
        emit(ItemsLoaded(itemsList: value));
      },
    );
  }

  @override
  Future<void> close() {
    categoryCubitSubscription.cancel();
    return super.close();
  }
}
