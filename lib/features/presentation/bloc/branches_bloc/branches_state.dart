import 'package:ceylife_digital/features/domain/entities/response/branch_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';

abstract class BranchesState extends BaseState<BranchesState> {}

class InitialBranchesState extends BranchesState {}

class BranchesLoadedState extends BranchesState {
  final BranchResponseEntity branchResponseEntity;

  BranchesLoadedState({this.branchResponseEntity});
}

class BranchesFailedState extends BranchesState {
  final String error;

  BranchesFailedState({this.error});
}
