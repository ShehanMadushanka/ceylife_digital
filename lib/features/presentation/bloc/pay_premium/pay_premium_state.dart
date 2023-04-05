import 'package:ceylife_digital/features/domain/entities/response/generate_payment_link_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/login_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/payment_status_check_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';

abstract class PayPremiumState extends BaseState<PayPremiumState> {}

class InitialPayPremiumState extends PayPremiumState {}

class PaymentLinkGenerateSuccessState extends PayPremiumState {
  final GeneratePaymentLinkResponseEntity generatePaymentLinkResponseEntity;

  PaymentLinkGenerateSuccessState({this.generatePaymentLinkResponseEntity});
}

class CheckPaymentStatusSuccessState extends PayPremiumState {
  final PaymentStatusCheckResponseEntity paymentStatusCheckResponseEntity;

  CheckPaymentStatusSuccessState({this.paymentStatusCheckResponseEntity});
}

class ProfileDataLoadedState extends PayPremiumState{
  final ProfileEntity profileEntity;

  ProfileDataLoadedState({this.profileEntity});
}
