part of 'cart_cubit.dart';

 class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartLoaded extends CartState {}

final class CartError extends CartState {
  final CustomError error;

  const CartError({required this.error});
}
