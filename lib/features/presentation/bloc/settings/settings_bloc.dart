import 'package:ceylife_digital/core/network/network_config.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/features/data/datasources/shared_preference.dart';
import 'package:ceylife_digital/features/data/models/responses/common_error_response.dart';
import 'package:ceylife_digital/features/domain/entities/request/biometric_registration_request_entity.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_biometric_registration.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_login.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/settings/settings_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/settings/settings_state.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:ceylife_digital/features/domain/entities/request/login_request_entity.dart';
import 'package:ceylife_digital/utils/app_extensions.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'dart:convert';

class SettingsBloc extends BaseBloc<SettingsEvent, BaseState<SettingsState>> {
  final AppSharedData appSharedData;
  final UseCaseBiometricRegistration biometricRegistration;
  final UseCaseGetLogin useCaseGetLogin;

  SettingsBloc({this.appSharedData, this.biometricRegistration, this.useCaseGetLogin})
      : super(InitialSettingsState());

  @override
  Stream<BaseState<SettingsState>> mapEventToState(SettingsEvent event) async* {
    if (event is GetCacheUserEvent) {
      final result = await appSharedData.getCacheUser();
      yield CacheUserSuccessState(profileEntity: result);
    } else if (event is BiometricRegistrationEvent) {
      final cacheUser = await appSharedData.getCacheUser();
      final result = await biometricRegistration(
          BiometricRegistrationRequestEntity(
              mobileUserId: cacheUser.mobileUserId,
              bioAuthEnable: event.isBiometricEnabled ? 1 : 2));
      yield result.fold((l) {
        if (l is AuthorizedFailure) {
          if (AppConstants.IS_USER_LOGGED)
            return SessionExpireState();
          else
            return APIFailureState(
                errorResponseModel: ErrorResponseModel(
                    responseError: ErrorMessages().mapFailureToMessage(l)));
        } else
          return APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseError: ErrorMessages().mapFailureToMessage(l)));
      }, (r) {
        if (r.responseCode == APIResponse.RESPONSE_SUCCESS)
          return BiometricEnableSuccessState(
              shouldEnabled: event.isBiometricEnabled);
        else
          return BiometricEnableFailedState(error: r.responseError);
      });
    }else if (event is GetLoginEvent) {
      yield APILoadingState();
      final token = await appSharedData.getPushToken();
      final cacheUser = await appSharedData.getCacheUser();
      final result = await useCaseGetLogin(LoginRequestEntity(
          username: event.signInType == SignInType.PASSWORD
              ? event.username
              : cacheUser.username,
          password: event.signInType == SignInType.PASSWORD
              ? base64.encode(utf8.encode(event.password.getSHA1()))
              : '',
          pushId: token,
          signInMode: event.signInType.getValue(),
          deviceId: await FlutterUdid.consistentUdid,
          mobileManufacture: event.deviceInfo.getMobileManufacture(),
          mobileOs: event.deviceInfo.getMobileOS(),
          mobileModel: event.deviceInfo.getModel()));
      yield result.fold((l) {
        if (l is AuthorizedFailure) {
          return APIFailureState(errorResponseModel: l.errorResponse);
        } else
          return APIFailureState(errorResponseModel: ErrorResponseModel(responseError: ErrorMessages().mapFailureToMessage(l)));
      }, (r) {
        if (r.responseCode == APIResponse.RESPONSE_SUCCESS) {
          return AuthSuccessState();
        } else
          return APIFailureState(errorResponseModel: ErrorResponseModel(responseError: ErrorMessages().mapAPIErrorCode(r.responseCode, "")));
      });
    }
  }
}
