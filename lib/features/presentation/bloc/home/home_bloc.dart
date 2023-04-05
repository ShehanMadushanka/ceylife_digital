import 'package:ceylife_digital/core/network/network_config.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/features/data/datasources/shared_preference.dart';
import 'package:ceylife_digital/features/data/models/responses/common_error_response.dart';
import 'package:ceylife_digital/features/domain/entities/request/password_reset_otp_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/policy_details_request_entity.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_policy_details.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_user_profile.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_password_reset_otp_request.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/home/home_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/home/home_state.dart';

class HomeBloc extends BaseBloc<HomeEvent, BaseState<HomeState>> {
  final UseCaseGetUserProfile useCaseGetUserProfile;
  final UseCasePolicyDetails useCaseGetPolicy;
  final UseCasePasswordResetOtpRequest useCasePasswordResetOtpRequest;
  final AppSharedData appSharedData;

  HomeBloc(
      {this.useCaseGetUserProfile,
      this.appSharedData,
      this.useCaseGetPolicy,
      this.useCasePasswordResetOtpRequest})
      : super(InitialHomeState());

  @override
  Stream<BaseState<HomeState>> mapEventToState(HomeEvent event) async* {
    if (event is GetProfileDataEvent) {
      final cacheUser = await appSharedData.getCacheUser();
      yield ProfileDataLoadedState(profileEntity: cacheUser);
    } else if (event is GetPoliciesEvent) {
      yield APILoadingState();
      final cacheUser = await appSharedData.getCacheUser();
      final result = await useCaseGetPolicy(PolicyDetailsRequestEntity(
          clientNo: cacheUser.mobileUserId.toString()));
      yield result.fold((l) {
        if (l is AuthorizedFailure) {
          return SessionExpireState();
        } else
          return PolicyLoadingFailedState(
              error: ErrorMessages().mapFailureToMessage(l));
      }, (r) {
        if (r.responseCode == APIResponse.RESPONSE_SUCCESS) {
          return PolicyLoadedState(policyDetailsResponseEntity: r);
        } else
          return PolicyLoadingFailedState(error: ErrorMessages().mapAPIErrorCode(r.responseCode, r.responseError));
      });
    } else if (event is PasswordResetOtpRequestEvent) {
      yield APILoadingState();
      final cacheUser = await appSharedData.getCacheUser();
      final result = await useCasePasswordResetOtpRequest(
          PasswordResetOtpRequestEntity(mobileUserId: cacheUser.mobileUserId));
      yield result.fold((l) {
        if (l is AuthorizedFailure) {
          return SessionExpireState();
        } else
          return PolicyLoadingFailedState(
              error: ErrorMessages().mapFailureToMessage(l));
      }, (r) {
        if (r.responseCode == APIResponse.RESPONSE_SUCCESS) {
          return PasswordResetOtpSuccessState(
              passwordResetOtpResponseEntity: r);
        } else
          return APIFailureState(
              errorResponseModel:
                  ErrorResponseModel(responseError: r.responseError));
      });
    }
  }
}
