import 'package:ceylife_digital/features/domain/entities/response/payment_details_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/policy_info_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';

abstract class PolicyDetailsState extends BaseState<PolicyDetailsState> {}

class InitialPolicyDetailsState extends PolicyDetailsState {}

class PaymentHistoryLoadedState extends PolicyDetailsState {
  final PaymentDetailsResponseEntity paymentDetailsResponseEntity;

  PaymentHistoryLoadedState({this.paymentDetailsResponseEntity});
}

class PolicyBenefitsLoadedState extends PolicyDetailsState {
  final PolicyInfoResponseEntity policyInfoResponseEntity;

  PolicyBenefitsLoadedState({this.policyInfoResponseEntity});
}

class PolicyLoansLoadedState extends PolicyDetailsState {
  final PolicyInfoResponseEntity policyInfoResponseEntity;

  PolicyLoansLoadedState({this.policyInfoResponseEntity});
}
