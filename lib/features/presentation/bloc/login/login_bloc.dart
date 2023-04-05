import 'dart:convert';

import 'package:ceylife_digital/core/network/network_config.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/features/data/datasources/shared_preference.dart';
import 'package:ceylife_digital/features/domain/entities/request/login_request_entity.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_login.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/login/login_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/login/login_state.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/app_extensions.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:flutter_udid/flutter_udid.dart';

class LoginBloc extends BaseBloc<LoginEvent, BaseState<LoginState>> {
  final UseCaseGetLogin useCaseGetLogin;
  final AppSharedData appSharedData;

  LoginBloc({this.useCaseGetLogin, this.appSharedData})
      : super(InitialLoginState());

  @override
  Stream<BaseState<LoginState>> mapEventToState(LoginEvent event) async* {
    if (event is GetLoginEvent) {
      if (event.signInType == SignInType.PASSWORD &&
          (event.username == null || event.username.isEmpty))
        yield ValidationFailedState(error: 'username_invalid_error');
      else if (event.signInType == SignInType.PASSWORD &&
          (event.password == null || event.password.isEmpty))
        yield ValidationFailedState(error: 'password_invalid_error');
      else {
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
            return LoginFailedState(
                error: ErrorMessages().mapFailureToMessage(l));
        }, (r) {
          if (r.responseCode == APIResponse.RESPONSE_SUCCESS) {
            AppConstants.IS_USER_LOGGED = true;
            AppConstants.LAST_LOGIN = r.lastLoginDate;
            AppConstants.UNREAD_NOTIFICATION_COUNT = r.unReadNotificationCount;

            return LoginLoadedState(loginResponseEntity: r);
          } else
            return LoginFailedState(error: ErrorMessages().mapAPIErrorCode(r.responseCode, r.responseError));
        });
      }
    } else if (event is GetCacheUser) {
      final cacheUser = await appSharedData.getCacheUser();
      yield CacheUserSuccessState(user: cacheUser);
    }
  }
}
