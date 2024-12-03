part of 'cart_cubit.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}


class CartStateLoading extends CartState {
  const CartStateLoading();
}


class CartStateError extends CartState {
  final String message;
  final int statusCode;

  const CartStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class CartStateLoaded extends CartState {
  final dynamic cartResponse;

  const CartStateLoaded(this.cartResponse);

  @override
  List<Object> get props => [cartResponse];
}