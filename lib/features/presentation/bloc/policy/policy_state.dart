import 'package:ceylife_digital/features/domain/entities/response/policy_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';

abstract class PolicyState extends BaseState<PolicyState> {}

class InitialPolicyState extends PolicyState {}

class PolicyLoadingState extends PolicyState {}

class PolicyLoadedState extends PolicyState {
  final PolicyResponseEntity policyResponseEntity;

  PolicyLoadedState({this.policyResponseEntity});
}

class PolicyFailedState extends PolicyState {
  final String error;

  PolicyFailedState({this.error});
}

class ValidationFailedState extends PolicyState {
  final String error;

  ValidationFailedState({this.error});
}
