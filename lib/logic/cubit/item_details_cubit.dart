import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/data/models/item_details_model.dart';
import 'package:multi/data/providers/error/custom_error.dart';

import '../../data/repository/item_repository.dart';
part 'item_details_state.dart';

class ItemDetailsCubit extends Cubit<ItemDetailsState> {
  final ItemsRepository _itemsRepository;
  ItemDetailsCubit({
    required itemsRepository,
  })  : _itemsRepository = itemsRepository,
        super(ItemDetailsInitial());

  getItemDetails(int storeItemId) async {
    emit(ItemDetailsLoadingState());

    final result = await _itemsRepository.getItemDetials(storeItemId);
    result.fold(
      (failure) {
        var errorState = ItemDetailsErrorState(
            error: CustomError(
                statusCode: failure.statusCode, message: failure.message));
        emit(errorState);
      },
      (value) {
        emit(ItemDetailsLoadedState(itemDetails: value));
      },
    );
  }
}
