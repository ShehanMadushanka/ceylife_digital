import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';

abstract class DirectPayState extends BaseState<DirectPayState> {}

class InitialDirectPayState extends DirectPayState {}

class DirectPayPaymentSuccessState extends DirectPayState {}

class DirectPayPaymentFailedState extends DirectPayState {}

class PaymentFailedState extends DirectPayState {}
