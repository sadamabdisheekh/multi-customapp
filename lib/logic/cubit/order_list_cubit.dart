import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/data/models/orders/order_model.dart';
import 'package:multi/data/repository/order_repository.dart';

part 'order_list_state.dart';

class OrderListCubit extends Cubit<OrderListState> {
  final OrderRepository _orderRepository;
  OrderListCubit({required orderRepository})
      : _orderRepository = orderRepository,
        super(OrderListInitial());

  Future<void> fetchOrders() async {
    try {
      emit(OrderListLoading());
      final result = await _orderRepository.getOrders();
      result.fold(
        (failure) {
          emit(OrderListError(failure.message));
        },
        (orders) {
          emit(OrderListLoaded(orders));
        },
      );
    } catch (e) {
      emit(OrderListError('Failed to fetch orders: ${e.toString()}'));
    }
  }
}
