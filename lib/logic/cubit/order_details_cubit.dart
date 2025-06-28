import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:multi/data/models/orders/order_details.dart';
import 'package:multi/data/repository/order_repository.dart';

part 'order_details_state.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  final OrderRepository _orderRepository;
  OrderDetailsCubit({required orderRepository}) : _orderRepository = orderRepository, super(OrderDetailsInitial());

  Future<void> loadOrderDetails(int orderId) async {
    try {
      emit(OrderDetailsLoading());
      final result = await _orderRepository.getOrderDetails(orderId);
      result.fold(
        (failure) {
          emit(OrderDetailsError(failure.message));
        },
        (orderDetails) {
          emit(OrderDetailsLoaded(orderDetails));
        },
      );
     
    } catch (e) {
      emit(OrderDetailsError('Failed to load order details ${e.toString()}'));
    }
  }
}
