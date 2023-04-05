import 'dart:convert';

import 'package:ceylife_digital/core/network/network_config.dart';
import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/features/data/datasources/shared_preference.dart';
import 'package:ceylife_digital/features/data/models/responses/common_error_response.dart';
import 'package:ceylife_digital/features/domain/entities/request/update_password_request_entity.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_update_password.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/utils/app_extensions.dart';
import 'package:ceylife_digital/utils/validator.dart';

import 'forgot_password_event.dart';
import 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends BaseBloc<ForgotPasswordEvent, BaseState<ForgotPasswordState>> {
  final UseCaseUpdatePassword useCaseUpdatePassword;
  final AppSharedData appSharedData;

  ForgotPasswordBloc({this.useCaseUpdatePassword, this.appSharedData})
      : super(InitialForgotPasswordState());

  @override
  Stream<BaseState<ForgotPasswordState>> mapEventToState(
      ForgotPasswordEvent event) async* {
    if (event is UpdatePassword) {
      final confData = await appSharedData.getConfigurationData();
      final cacheUser = await appSharedData.getCacheUser();
      if (event.password != event.repeatPassword)
        yield PasswordMatchingFailedState(
            error: ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_PASSWORD_MISMATCH,""));
      else if (!Validator.validatePassword(
          event.password, confData.passwordPolicy)) {
        yield PasswordMatchingFailedState(
            error: ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_PASSWORD_POLICY_MISMATCH,""));
      } else {
        yield APILoadingState();
        final result = await useCaseUpdatePassword(UpdatePasswordRequestEntity(
          username: cacheUser.nicNo,
          password: base64.encode(utf8.encode(event.password.getSHA1())),
        ));
        yield result.fold(
            (l) => APIFailureState(
                errorResponseModel: ErrorResponseModel(
                    responseError: ErrorMessages().mapFailureToMessage(l))),
            (r) {
          if (r.responseCode == APIResponse.RESPONSE_SUCCESS) {
            return UpdatePasswordSuccessState(updatePasswordResponseEntity: r);
          } else
            return UpdatePasswordFailedState(error: ErrorMessages().mapAPIErrorCode(r.responseCode, r.responseError));
        });
      }
    } else if (event is GetConfigData) {
      final confData = await appSharedData.getConfigurationData();
      yield ConfigDataSuccessState(configurationData: confData);
    }
  }
}
