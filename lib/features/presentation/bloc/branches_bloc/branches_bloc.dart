import 'package:ceylife_digital/core/network/network_config.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_branches.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/branches_bloc/branches_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/branches_bloc/branches_state.dart';
import 'package:ceylife_digital/utils/app_constants.dart';

import '../base_state.dart';

class BranchesBloc extends BaseBloc<BranchesEvent, BaseState<BranchesState>> {
  final UseCaseGetBranches useCaseGetBranches;

  BranchesBloc({this.useCaseGetBranches}) : super(InitialBranchesState());

  @override
  Stream<BaseState<BranchesState>> mapEventToState(BranchesEvent event) async* {
    if (event is GetBranchesEvent) {
      yield APILoadingState();
      final result = await useCaseGetBranches(event.branchesRequestEntity);
      yield result.fold((l) {
        if (l is AuthorizedFailure) {
          if (AppConstants.IS_USER_LOGGED)
            return SessionExpireState();
          else
            return BranchesFailedState(
                error: ErrorMessages().mapFailureToMessage(l));
        } else
          return BranchesFailedState(
              error: ErrorMessages().mapFailureToMessage(l));
      }, (r) {
        if (r.responseCode == APIResponse.RESPONSE_SUCCESS)
          return BranchesLoadedState(branchResponseEntity: r);
        else
          return BranchesFailedState(error: ErrorMessages().mapAPIErrorCode(r.responseCode, r.responseError));
      });
    }
  }
}
