import 'package:ceylife_digital/features/domain/entities/response/payment_details_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/policy_details_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';

abstract class PaymentHistoryState extends BaseState<PaymentHistoryState> {}

class InitialPaymentHistoryState extends PaymentHistoryState {}

class PolicyLoadedState extends PaymentHistoryState {
  final PolicyDetailsResponseEntity policyDetailsResponseEntity;

  PolicyLoadedState({this.policyDetailsResponseEntity});
}

class PolicyLoadingFailedState extends PaymentHistoryState {
  final String error;

  PolicyLoadingFailedState({this.error});
}

class PaymentHistoryLoadingState extends PaymentHistoryState {}

class PaymentHistoryLoadedState extends PaymentHistoryState {
  final PaymentDetailsResponseEntity paymentDetailsResponseEntity;
  final isPageRefreshed;

  PaymentHistoryLoadedState({this.paymentDetailsResponseEntity, this.isPageRefreshed});
}

class PaymentHistoryLoadingFailedState extends PaymentHistoryState {
  final String error;

  PaymentHistoryLoadingFailedState({this.error});
}
