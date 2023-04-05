import 'package:ceylife_digital/core/network/network_config.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/features/data/models/responses/common_error_response.dart';
import 'package:ceylife_digital/features/domain/entities/request/verify_new_lead_generator_request_entity.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_branches.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_verify_new_lead_generator.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/validator.dart';

import 'user_details_event.dart';
import 'user_details_state.dart';

class UserDetailsBloc
    extends BaseBloc<UserDetailsEvent, BaseState<UserDetailsState>> {
  final UseCaseGetBranches useCaseGetBranches;
  final UseCaseNewLeadGenerator useCaseNewLeadGenerator;

  UserDetailsBloc({this.useCaseGetBranches, this.useCaseNewLeadGenerator})
      : super(InitialUserDetailsState());

  @override
  Stream<BaseState<UserDetailsState>> mapEventToState(
      UserDetailsEvent event) async* {
    if (event is ValidateUserEmailEvent) {
      if (event.email != null && event.email.isNotEmpty) {
        if (Validator.validateEmail(event.email))
          yield ValidateUserEmailSuccessState();
        else
          yield ValidateUserEmailFailedState(error: 'email_invalid_error');
      } else
        yield ValidateUserEmailSuccessState();
    } else if (event is GetBranchesEvent) {
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
    } else if (event is NewLeadGeneratorEvent) {
      yield APILoadingState();
      final result =
          await useCaseNewLeadGenerator(VerifyNewLeadGeneratorRequestEntity(
        email: event.email,
        nic: event.nic,
        contactNo: event.contactNo,
        contactNo2: event.contactNo2,
      ));
      yield result.fold(
          (l) => APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseError: ErrorMessages().mapFailureToMessage(l))), (r) {
        if (r.responseCode == APIResponse.RESPONSE_SUCCESS) {
          return NewLeadGeneratorSuccessState(verifyNewLeadGeneratorResponseEntity: r);
        } else
          return NewLeadGeneratorFailedState(error: ErrorMessages().mapAPIErrorCode(r.responseCode, r.responseError));
      });
    }else if (event is SubmitNearestBranchEvent){
      yield SubmitNearestBranchState();
    }
  }
}
