import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/repository/item_repository.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
    final ItemsRepository _itemsRepository;
    CartCubit(
      {required itemsRepository,})
      : _itemsRepository = itemsRepository,
        super(CartInitial());


  dynamic cartResponseModel;
  int cartCount = 0;

  Future<void> getCartProducts() async {

    emit(const CartStateLoading());

    final result =
        await _itemsRepository.getCartItems();

    result.fold(
      (failure) {
        emit(CartStateError(failure.message, failure.statusCode));
      },
      (successData) {
        cartResponseModel = successData;
        cartCount = successData.length;
        
        emit(CartStateLoaded(successData));
      },
    );
  }
}


