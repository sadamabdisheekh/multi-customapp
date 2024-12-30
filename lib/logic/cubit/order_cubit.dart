import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/data/providers/error/custom_error.dart';
import '../../data/repository/order_repository.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {

  final OrderRepository _orderRepository;
  OrderCubit({
    required orderRepository,
  })  : _orderRepository = orderRepository,
        super(OrderInitial());
  
  Future<void> createOrder(Map<String,dynamic> body) async {
    emit(OrderLoadingState());

    final result = await _orderRepository.createOrder(body);
    result.fold(
      (failure) {
        var errorState = OrderErrorState(
            error: CustomError(
                statusCode: failure.statusCode, message: failure.message));
        emit(errorState);
      },
      (message) {
        emit(OrderLoadedState(message: message));
      },
    );
  }
}
