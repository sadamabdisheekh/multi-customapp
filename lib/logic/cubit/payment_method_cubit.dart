import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:multi/data/models/payment_methods.dart';
import 'package:multi/data/providers/error/custom_error.dart';
import 'package:multi/data/repository/order_repository.dart';

part 'payment_method_state.dart';

class PaymentMethodCubit extends Cubit<PaymentMethodState> {
  final OrderRepository _orderRepository;
  PaymentMethodCubit({
    required orderRepository,
  })  : _orderRepository = orderRepository,
        super(PaymentMethodInitial());

  PaymentMethodsModel? selectedPayment;

  Future<void> getPaymentMethods() async {
    emit(PaymentMethodLoadingState());

    final result = await _orderRepository.getPaymentMethods();
    result.fold(
      (failure) {
        var errorState = PaymentMethodErrorState(
            error: CustomError(
                statusCode: failure.statusCode, message: failure.message));
        emit(errorState);
      },
      (paymentList) {
        emit(PaymentMethodLoadedState(paymentMethods: paymentList));
      },
    );
  }
}
