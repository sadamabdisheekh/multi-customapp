import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/cart/cart_response_model.dart';
import '../../data/providers/error/failure.dart';
import '../../data/repository/item_repository.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final ItemsRepository _itemsRepository;
  CartCubit({
    required itemsRepository,
  })  : _itemsRepository = itemsRepository,
        super(CartInitial());

  List<CartResponseModel>? cartResponseModel;
  int cartCount = 0;
  double total = 0;

  getCartItems() async {
    emit(const CartStateLoading());

    final result = await _itemsRepository.getCartItems();

    result.fold(
      (failure) {
        emit(CartStateError(failure.message, failure.statusCode));
      },
      (successData) {
        cartResponseModel = successData;
        cartCount = successData.length;
        double subTotal = 0;

        for (var item in successData) {
          subTotal += item.price * item.quantity.toDouble();
        }
        total = subTotal;
        emit(CartStateLoaded(successData));
      },
    );
  }

   Future<Either<Failure, dynamic>> incrementquantity(int storeItemId) async {
      emit(const CartStateDecIncrementLoading());

    final result = await _itemsRepository.incrementQuantity(storeItemId);

    result.fold(
      (failure) {
        emit(CartStateDecIncError(failure.message, failure.statusCode));
      },
      (successData) {
        emit(const CartDecIncState(message: 'increment sucess'));
      },
    );
    return result;
   }

   Future<Either<Failure, dynamic>> decrementquantity(int storeItemId) async {
      emit(const CartStateDecIncrementLoading());

    final result = await _itemsRepository.decrementQuantity(storeItemId);

    result.fold(
      (failure) {
        emit(CartStateDecIncError(failure.message, failure.statusCode));
      },
      (successData) {
      
        emit(const CartDecIncState(message: 'descrement successfully'));
      },
    );
    return result;
   }

   Future<void> removeCartItem(int storeItemId) async {
      emit(const CartStateDecIncrementLoading());

    final result = await _itemsRepository.removeCartItem(storeItemId);

    result.fold(
      (failure) {
        emit(CartStateDecIncError(failure.message, failure.statusCode));
      },
      (successData) {
        cartResponseModel!
            .removeWhere((element) => element.storeItem.id == storeItemId);
        cartCount = cartCount - 1;

         double subTotal = 0;

        for (var item in cartResponseModel!) {
          subTotal += item.price * item.quantity.toDouble();
        }
        total = subTotal;
      
        emit( CartStateRemove(successData));
        emit(CartStateLoaded(cartResponseModel ?? []));
      },
    );
   }
}
