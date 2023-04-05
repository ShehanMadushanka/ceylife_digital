import 'dart:convert';

import 'package:ceylife_digital/core/network/network_config.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/features/data/datasources/shared_preference.dart';
import 'package:ceylife_digital/features/data/models/responses/common_error_response.dart';
import 'package:ceylife_digital/features/domain/entities/request/otp_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/resend_otp_request_entity.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_otp.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_resend_otp.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/otp/otp_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/otp/otp_state.dart';

class OtpBloc extends BaseBloc<OtpEvent, BaseState<OtpState>> {
  final UseCaseGetOtp useCaseGetOtp;
  final UseCaseResendOtp useCaseResendOtp;
  final AppSharedData appSharedData;

  OtpBloc({this.useCaseGetOtp, this.useCaseResendOtp, this.appSharedData})
      : super(InitialOtpState());

  @override
  Stream<BaseState<OtpState>> mapEventToState(OtpEvent event) async* {
    if (event is GetOtpEvent) {
      yield APILoadingState();
      final result = await useCaseGetOtp(OtpRequestEntity(
          key: event.key,
          keyType: event.keyType,
          otpRef: event.otpRef,
          userOtp: base64.encode(utf8.encode(event.userOtp))));

      yield result.fold((l) {
        if (l is AuthorizedFailure) {
          return APIFailureState(errorResponseModel: l.errorResponse);
        } else
          return APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseError: ErrorMessages().mapFailureToMessage(l)));
      }, (r) {
        if (r.responseCode == APIResponse.RESPONSE_SUCCESS)
          return OtpLoadedState(otpResponseEntity: r);
        else
          return OtpFailedState(error: ErrorMessages().mapAPIErrorCode(r.responseCode, r.responseError));
      });
    } else if (event is ResendOtpEvent) {
      yield APILoadingState();
      final result = await useCaseResendOtp(ResendOtpRequestEntity(
        key: event.key,
        keyType: event.keyType,
      ));
      yield result.fold((l) {
        if (l is AuthorizedFailure) {
          return APIFailureState(errorResponseModel: l.errorResponse);
        } else
          return APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseError: ErrorMessages().mapFailureToMessage(l)));
      }, (r) {
        if (r.responseCode == APIResponse.RESPONSE_SUCCESS)
          return ResendOtpSuccessState(resendOtpResponseEntity: r);
        else
          return APIFailureState(
              errorResponseModel:
                  ErrorResponseModel(responseError: r.responseError));
      });
    } else if (event is GetConfigurationData) {
      final confData = await appSharedData.getConfigurationData();
      yield ConfigDataSuccessState(configurationData: confData);
    }
  }
}
