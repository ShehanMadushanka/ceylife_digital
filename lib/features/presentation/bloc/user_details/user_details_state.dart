import 'package:ceylife_digital/features/domain/entities/response/branch_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/verify_new_lead_generator_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';

abstract class UserDetailsState extends BaseState<UserDetailsState> {}

class InitialUserDetailsState extends UserDetailsState {}

class ValidateUserEmailSuccessState extends UserDetailsState {}

class ValidateUserEmailFailedState extends UserDetailsState{
  final String error;

  ValidateUserEmailFailedState({this.error});
}

class BranchesLoadedState extends UserDetailsState {
  final BranchResponseEntity branchResponseEntity;

  BranchesLoadedState({this.branchResponseEntity});
}

class BranchesFailedState extends UserDetailsState {
  final String error;

  BranchesFailedState({this.error});
}

class InitialNewLeadGeneratorState extends UserDetailsState {}

class NewLeadGeneratorSuccessState extends UserDetailsState {
  final VerifyNewLeadGeneratoResponseEntity verifyNewLeadGeneratorResponseEntity;

  NewLeadGeneratorSuccessState({this.verifyNewLeadGeneratorResponseEntity});
}

class NewLeadGeneratorFailedState extends UserDetailsState{
  final String error;

  NewLeadGeneratorFailedState({this.error});
}

class SubmitNearestBranchState extends UserDetailsState{

}
