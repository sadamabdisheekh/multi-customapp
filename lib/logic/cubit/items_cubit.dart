import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/data/providers/error/custom_error.dart';
import 'package:multi/data/repository/item_repository.dart';

import '../../data/models/items_model.dart';

part 'items_state.dart';

class ItemsCubit extends Cubit<ItemsState> {
  final ItemsRepository _itemsRepository;

  ItemsCubit({
    required itemsRepository,
  })  : _itemsRepository = itemsRepository,
        super(ItemsInitial());
  // List<Attribute>? attributes;

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

  // getItemAttributes(Map<String, dynamic> body) async {
  //   final result = await _itemsRepository.getItemAttributes(body);
  //   result.fold(
  //     (failure) {
      
  //     },
  //     (value) {
  //       // attributes = value;
  //     },
  //   );
  // }
}
