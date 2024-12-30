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

class CartStateDecIncrementLoading extends CartState {
  const CartStateDecIncrementLoading();
}

class CartStateError extends CartState {
  final String message;
  final int statusCode;

  const CartStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class CartStateDecIncError extends CartState {
  final String message;
  final int statusCode;

  const CartStateDecIncError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class CartDecIncState extends CartState {
  final String message;

  const CartDecIncState({required this.message});

  @override
  List<Object> get props => [message];
}

class CartStateLoaded extends CartState {
  final List<CartResponseModel> cartResponse;

  const CartStateLoaded(this.cartResponse);
}

class CartStateRemove extends CartState {
  final String message;

  const CartStateRemove(this.message);

  @override
  List<Object> get props => [message];
}