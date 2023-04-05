import 'package:ceylife_digital/core/network/network_config.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/features/data/datasources/shared_preference.dart';
import 'package:ceylife_digital/features/data/models/responses/common_error_response.dart';
import 'package:ceylife_digital/features/domain/entities/request/policy_request_entity.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_policy.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/policy/policy_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/policy/policy_state.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/validator.dart';

class PolicyBloc extends BaseBloc<PolicyEvent, BaseState<PolicyState>> {
  final UseCaseGetPolicy useCaseGetPolicy;
  final AppSharedData appSharedData;

  PolicyBloc({this.useCaseGetPolicy, this.appSharedData})
      : super(InitialPolicyState());

  @override
  Stream<BaseState<PolicyState>> mapEventToState(PolicyEvent event) async* {
    if (event is GetPolicyEvent) {
      if (event.key == null || event.key.isEmpty)
        yield ValidationFailedState(
            error:
                event.keyType == 1 ? 'nic_empty_error' : 'user_id_empty_error');
      else if (event.keyType == 1 ? Validator.validateNIC(event.key) : true) {
        yield APILoadingState();
        final result = await useCaseGetPolicy(PolicyRequestEntity(
            key: event.key,
            keyType: event.keyType,
            registrationType: event.registrationType));
        yield result.fold((l) {
          if (l is AuthorizedFailure) {
            return SessionExpireState();
          } else
            return APIFailureState(
                errorResponseModel: ErrorResponseModel(
                    responseError: ErrorMessages().mapFailureToMessage(l)));
        }, (r) {
          if (r.responseCode == APIResponse.RESPONSE_SUCCESS) {
            appSharedData.setCacheUser(nic: event.key);
            if (event.registrationType ==
                AppConstants.POLICY_HOLDER_REGISTRATION) {
              if (r.userType == AppConstants.CLIENT_USER_TYPE_NEW_USER) {
                return PolicyFailedState(
                    error:ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_POLICY_VERIFY_FAILED,""));
              } else if (r.userType ==
                  AppConstants.CLIENT_USER_TYPE_MOBILE_USER || r.userType ==
                  AppConstants.CLIENT_USER_TYPE_DUAL_USER) {
                return PolicyFailedState(
                    error: ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_POLICY_ALREADY_REGISTERED,""));
              } else if (r.userType ==
                  AppConstants.CLIENT_USER_TYPE_LEAD_GENERATOR) {
                return PolicyFailedState(
                    error:
                    ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_POLICY_VERIFY_FAILED,""));
              } else {
                return PolicyLoadedState(policyResponseEntity: r);
              }
            } else {
              if (r.userType == AppConstants.CLIENT_USER_TYPE_POLICY_HOLDER ||
                  r.userType ==
                      AppConstants.CLIENT_USER_TYPE_CLIENT_LEAD_GENERATOR ||
                  r.userType ==
                      AppConstants
                          .CLIENT_USER_TYPE_VERIFIED_WEB_LEAD_GENERATOR ||
                  r.userType ==
                      AppConstants
                          .CLIENT_USER_TYPE_NON_VERIFIED_WEB_LEAD_GENERATOR) {
                return PolicyFailedState(
                    error:
                    ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_POLICY_VERIFY_FAILED,""));
              } else if (r.userType ==
                  AppConstants.CLIENT_USER_TYPE_LEAD_GENERATOR || r.userType ==
                  AppConstants.CLIENT_USER_TYPE_DUAL_USER) {
                return PolicyFailedState(
                    error: 'You are an already registered lead generator.');
              } else
                return PolicyLoadedState(policyResponseEntity: r);
            }
          } else
            return PolicyFailedState(
                error:
                ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_POLICY_VERIFY_FAILED,""));
        });
      } else
        yield ValidationFailedState(error: 'nic_invalid_error');
    }
  }
}
