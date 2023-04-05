import 'dart:convert';

import 'package:ceylife_digital/core/network/network_config.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/features/data/datasources/shared_preference.dart';
import 'package:ceylife_digital/features/data/models/responses/common_error_response.dart';
import 'package:ceylife_digital/features/domain/entities/request/password_reset_request_entity.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_password_reset.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/password_reset/password_reset_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/password_reset/password_reset_state.dart';
import 'package:ceylife_digital/utils/app_extensions.dart';
import 'package:ceylife_digital/utils/validator.dart';

class PasswordResetBloc
    extends BaseBloc<PasswordResetEvent, BaseState<PasswordResetState>> {
  final AppSharedData appSharedData;
  final UseCasePasswordReset useCasePasswordReset;

  PasswordResetBloc({this.appSharedData, this.useCasePasswordReset})
      : super(InitialPasswordResetState());

  @override
  Stream<BaseState<PasswordResetState>> mapEventToState(
      PasswordResetEvent event) async* {
    if (event is GetConfigDataEvent) {
      final confData = await appSharedData.getConfigurationData();
      final userData = await appSharedData.getCacheUser();
      yield UserDataSuccessState(
          cacheUser: userData, configurationData: confData);
    } else if (event is ResetPasswordEvent) {
      final confData = await appSharedData.getConfigurationData();
      if (event.newPassword != event.repeatPassword)
        yield PasswordMatchingFailedState(
            error: ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_PASSWORD_MISMATCH,""));
      else if (!Validator.validatePassword(
          event.newPassword, confData.passwordPolicy)) {
        yield PasswordMatchingFailedState(
            error: ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_PASSWORD_POLICY_MISMATCH,""));
      } else {
        yield APILoadingState();
        final userData = await appSharedData.getCacheUser();
        final result = await useCasePasswordReset(
          PasswordResetRequestEntity(
            mobileUserId: userData.mobileUserId,
            oldPassword:
                base64.encode(utf8.encode(event.oldPassword.getSHA1())),
            password: base64.encode(utf8.encode(event.newPassword.getSHA1())),
          ),
        );
        yield result.fold((l) {
          if (l is AuthorizedFailure) {
            return SessionExpireState();
          } else
            return APIFailureState(
                errorResponseModel: ErrorResponseModel(
                    responseError: ErrorMessages().mapFailureToMessage(l)));
        }, (r) {
          if (r.responseCode == APIResponse.RESPONSE_SUCCESS) {
            return PasswordResetSuccessState(passwordResetResponseEntity: r);
          } else
            return PasswordResetFailedState(error: r.responseError);
        });
      }
    }
  }
}
