part of 'order_cubit.dart';

sealed class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

final class OrderInitial extends OrderState {}

final class OrderLoadingState extends OrderState {}

final class OrderErrorState extends OrderState {
  final CustomError error;

  const OrderErrorState({required this.error});
}

final class OrderLoadedState extends OrderState {
  final String message;

  const OrderLoadedState({required this.message});

}

