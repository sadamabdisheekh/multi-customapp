import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/data/providers/error/custom_error.dart';

import '../../data/repository/item_repository.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {

    final ItemsRepository _itemsRepository;
    CartCubit(
      {required itemsRepository,})
      : _itemsRepository = itemsRepository,
        super(CartInitial());

    getUserCart() {

    }

    addToCart(Map<String,dynamic> body) async {
      emit(CartLoading());

      final result = await _itemsRepository.addToCart(body);
    result.fold(
      (failure) {
        var errorState = CartError(
            error: CustomError(
                statusCode: failure.statusCode, message: failure.message));
        emit(errorState);
      },
      (value) {
        emit(CartLoaded());
      },
    ); 
    }
}
