import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/providers/error/custom_error.dart';
import '../../data/repository/item_repository.dart';

part 'add_to_cart_state.dart';

class AddToCartCubit extends Cubit<AddToCartState> {

      final ItemsRepository _itemsRepository;
    AddToCartCubit(
      {required itemsRepository,})
      : _itemsRepository = itemsRepository,
        super(AddToCartInitial());

    getUserCart() {

    }

    addToCart(Map<String,dynamic> body) async {
      emit(AddToCartLoading());

      final result = await _itemsRepository.addToCart(body);
    result.fold(
      (failure) {
        var errorState = AddToCartError(
            error: CustomError(
                statusCode: failure.statusCode, message: failure.message));
        emit(errorState);
      },
      (value) {
        emit(AddToCartLoaded());
      },
    ); 
    }
}
