import 'package:ceylife_digital/features/presentation/bloc/base_event.dart';

abstract class PaymentHistoryEvent extends BaseEvent {}

class GetPoliciesEvent extends PaymentHistoryEvent {}

class GetPaymentHistoryEvent extends PaymentHistoryEvent {
  final String policyNo;
  final String clientNo;
  final int pageNo;

  GetPaymentHistoryEvent({this.policyNo, this.clientNo, this.pageNo});
}
