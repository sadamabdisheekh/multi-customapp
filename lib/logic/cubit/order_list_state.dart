part of 'order_list_cubit.dart';

sealed class OrderListState extends Equatable {
  const OrderListState();

  @override
  List<Object> get props => [];
}

final class OrderListInitial extends OrderListState {}

class OrderListLoading extends OrderListState {}

class OrderListLoaded extends OrderListState {
  final List<OrderModel> orders;
  const OrderListLoaded(this.orders);

  @override
  List<Object> get props => [orders];
}

class OrderListError extends OrderListState {
  final String message;
  const OrderListError(this.message);

  @override
  List<Object> get props => [message];
}