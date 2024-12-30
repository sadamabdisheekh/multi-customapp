part of 'add_to_cart_cubit.dart';

sealed class AddToCartState extends Equatable {
  const AddToCartState();

  @override
  List<Object> get props => [];
}

final class AddToCartInitial extends AddToCartState {}

final class AddToCartLoading extends AddToCartState {}

final class AddToCartLoaded extends AddToCartState {
  final String message;

  const AddToCartLoaded({required this.message});
}

final class AddToCartError extends AddToCartState {
  final CustomError error;

  const AddToCartError({required this.error});
}
