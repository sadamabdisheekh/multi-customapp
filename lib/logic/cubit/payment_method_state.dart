part of 'payment_method_cubit.dart';

sealed class PaymentMethodState extends Equatable {
  const PaymentMethodState();

  @override
  List<Object> get props => [];
}

final class PaymentMethodInitial extends PaymentMethodState {}

final class PaymentMethodLoadingState extends PaymentMethodState {}

final class PaymentMethodErrorState extends PaymentMethodState {
  final CustomError error;
  const PaymentMethodErrorState({required this.error});
}

final class PaymentMethodLoadedState extends PaymentMethodState {
  final List<PaymentMethodsModel> paymentMethods;
  const PaymentMethodLoadedState({required this.paymentMethods});
}