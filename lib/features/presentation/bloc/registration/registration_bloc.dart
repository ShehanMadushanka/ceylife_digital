import 'dart:convert';

import 'package:ceylife_digital/core/network/network_config.dart';
import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/features/data/datasources/shared_preference.dart';
import 'package:ceylife_digital/features/data/models/responses/common_error_response.dart';
import 'package:ceylife_digital/features/domain/entities/request/create_user_request_entity.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_create_user.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/utils/app_extensions.dart';
import 'package:ceylife_digital/utils/validator.dart';
import 'package:flutter_udid/flutter_udid.dart';

import 'registration_event.dart';
import 'registration_state.dart';

class RegistrationBloc
    extends BaseBloc<RegistrationEvent, BaseState<RegistrationState>> {
  final UseCaseCreateUser useCaseCreateUser;
  final AppSharedData appSharedData;

  RegistrationBloc({this.useCaseCreateUser, this.appSharedData})
      : super(InitialRegistrationState());

  @override
  Stream<BaseState<RegistrationState>> mapEventToState(
      RegistrationEvent event) async* {
    if (event is CreateUserEvent) {
      final confData = await appSharedData.getConfigurationData();
      if (!event.isWebUser) {
        if (event.password != event.repeatPassword)
          yield PasswordMatchingFailedState(
              error: ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_PASSWORD_MISMATCH,""));
        else if (!Validator.validatePassword(
            event.password, confData.passwordPolicy)) {
          yield PasswordMatchingFailedState(
              error: ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_PASSWORD_POLICY_MISMATCH,""));
        } else {
          yield APILoadingState();
          final token = await appSharedData.getPushToken();
          final deviceId = await FlutterUdid.consistentUdid;
          final result = await useCaseCreateUser(
            CreateUserRequestEntity(
                email: event.email,
                nickname: event.nickname,
                username: event.userId,
                password: base64.encode(utf8.encode(event.password.getSHA1())),
                nic: event.nic,
                pushId: token,
                mobileOs: event.deviceInfo.getMobileOS(),
                mobileModel: event.deviceInfo.getModel(),
                mobileManufacture: event.deviceInfo.getMobileManufacture(),
                mobileIMEINo: '',
                deviceId: deviceId),
          );
          yield result.fold(
              (l) => APIFailureState(
                  errorResponseModel: ErrorResponseModel(
                      responseError: ErrorMessages().mapFailureToMessage(l))),
              (r) {
            if (r.responseCode == APIResponse.RESPONSE_SUCCESS) {
              appSharedData.setCacheUser(
                  username: event.userId, nickname: event.nickname);
              return CreateUserSuccessState(createUserResponseEntity: r);
            } else if (r.responseCode ==
                APIResponse.RESPONSE_FAILED_EXISTING_USER_ID)
              return ExistingUserFailedState(
                  error: ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_USER_ID_TAKEN,""));
            else
              return CreateUserFailedState(
                  error: ErrorMessages()
                      .mapAPIErrorCode(r.responseCode, r.responseError));
          });
        }
      } else {
        yield APILoadingState();
        final result = await useCaseCreateUser(CreateUserRequestEntity(
          email: event.email,
          nickname: event.nickname,
          username: event.userId,
          password: base64.encode(utf8.encode(event.password.getSHA1())),
          nic: event.nic,
        ));
        yield result.fold(
            (l) => APIFailureState(
                errorResponseModel: ErrorResponseModel(
                    responseError: ErrorMessages().mapFailureToMessage(l))),
            (r) {
          if (r.responseCode == APIResponse.RESPONSE_SUCCESS) {
            appSharedData.setCacheUser(
                username: event.userId, nickname: event.nickname);
            return CreateUserSuccessState(createUserResponseEntity: r);
          } else if (r.responseCode ==
              APIResponse.RESPONSE_FAILED_EXISTING_USER_ID)
            return ExistingUserFailedState(
                error: ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_USER_ID_TAKEN,""));
          else
            return CreateUserFailedState(
                error: ErrorMessages()
                    .mapAPIErrorCode(r.responseCode, r.responseError));
        });
      }
    } else if (event is GetConfigData) {
      final confData = await appSharedData.getConfigurationData();
      yield ConfigDataSuccessState(configurationData: confData);
    }
  }
}
