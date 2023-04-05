import 'package:ceylife_digital/features/presentation/bloc/base_event.dart';

abstract class PolicyDetailsEvent extends BaseEvent {}

class GetPaymentHistoryEvent extends PolicyDetailsEvent {
  final String policyNo;

  GetPaymentHistoryEvent({
    this.policyNo,
  });
}

class GetPolicyBenefitsEvent extends PolicyDetailsEvent {
  final String policyNo;

  GetPolicyBenefitsEvent({this.policyNo});
}

class GetPolicyLoansEvent extends PolicyDetailsEvent {
  final String policyNo;

  GetPolicyLoansEvent({this.policyNo});
}
