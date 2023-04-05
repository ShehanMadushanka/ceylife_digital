import 'package:ceylife_digital/features/presentation/bloc/base_event.dart';

abstract class PayPremiumEvent extends BaseEvent {}

class GetGeneratedPaymentLink extends PayPremiumEvent {
  final double amount;
  final String startDate;
  final String endDate;
  final String interval;
  final String mobileNumber;
  final int paymentType;
  final double premium;
  final String policyNumber;

  GetGeneratedPaymentLink({
    this.amount,
    this.startDate,
    this.endDate,
    this.interval,
    this.mobileNumber,
    this.paymentType,
    this.premium,
    this.policyNumber,
  });
}

class GetPaymentStatus extends PayPremiumEvent {
  final String referenceCode;

  GetPaymentStatus({this.referenceCode});
}

class GetProfileDataEvent extends PayPremiumEvent{}
