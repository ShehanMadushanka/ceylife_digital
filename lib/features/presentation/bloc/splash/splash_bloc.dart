import 'package:ceylife_digital/core/configurations/app_config.dart';
import 'package:ceylife_digital/core/network/network_config.dart';
import 'package:ceylife_digital/core/service/cloud_services.dart';
import 'package:ceylife_digital/core/service/platform_services.dart';
import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/features/data/datasources/shared_preference.dart';
import 'package:ceylife_digital/features/domain/entities/request/key_exchange_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/splash_request_entity.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_key_exchange.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_splash.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/splash/splash_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/splash/splash_state.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/app_extensions.dart';
import 'package:ceylife_digital/utils/encryption/encryptor/epic_dart_encryptor.dart';
import 'package:package_info/package_info.dart';

class SplashBloc extends BaseBloc<SplashEvent, BaseState<SplashState>> {
  final CloudServices cloudServices;
  final UseCaseSplash useCaseSplash;
  final UseCaseKeyExchange useCaseKeyExchange;
  final AppSharedData appSharedData;

  SplashBloc(
      {this.useCaseSplash,
      this.appSharedData,
      this.cloudServices,
      this.useCaseKeyExchange})
      : super(InitialSplashState());

  @override
  Stream<BaseState<SplashState>> mapEventToState(SplashEvent event) async* {
    if (event is SplashRequestEvent) {
      final token = await appSharedData.getPushToken();
      final appHash = await PlatformServices.signature;
      final _packageInfo = await PackageInfo.fromPlatform();
      final _initialLaunch = await appSharedData.isInitialLaunch();
      final _language = await appSharedData.getAppLanguage();
      final biometric = await appSharedData.getBiometric();

      AppConstants.IS_BIOMETRIC_ENABLED = biometric;

      final result = await useCaseSplash(SplashRequestEntity(
          versionNumber: _packageInfo.buildNumber,
          buildVersion: _packageInfo.version,
          pushId: token,
          os: AppConfig.deviceOS.getValue(),
          appHash: appHash));
      yield result.fold(
          (l) =>
              SplashFailedState(error: ErrorMessages().mapFailureToMessage(l)),
          (r) {
        if (r.responseCode == APIResponse.RESPONSE_SUCCESS) {
          appSharedData.setConfigurationData(
              configurationDataEntity: r.configurationData);
          return SplashSuccessState(
              splashResponseEntity: r,
              isLanguageExists: _initialLaunch,
              languages: _language.getLanguage());
        } else if (r.responseCode == APIResponse.RESPONSE_FAILED_FORCE_UPDATE)
          return ForceUpdateState();
        else
          return SplashFailedState(error: r.responseError);
      });
    } else if (event is GetPushToken) {
      final hasToken = await appSharedData.hasPushToken();
      if (hasToken) {
        final token = await appSharedData.getPushToken();
        yield PushTokenSuccessState(token);
      } else {
        await cloudServices.capturePushToken();
        yield PushTokenSuccessState("TOKEN");
      }
    } else if (event is ExchangeKeyEvent) {
      DartEncryptor.init();
      final result = await useCaseKeyExchange(
          KeyExchangeRequestEntity(key: DartEncryptor.publicKey));
      yield result.fold(
          (l) => ExchangeKeyFailedState(
              error: ErrorMessages().mapFailureToMessage(l)), (r) {
        if (r.responseCode == APIResponse.RESPONSE_SUCCESS) {
          if (DartEncryptor.compareKCV(
              kcv: r.kcv, pmk: r.pmk, serverPublicKey: serverDefaultPublicKey))
            return ExchangeKeySuccessState(exchangeResponseEntity: r);
          else
            return ExchangeKeyFailedState(
                error: ErrorMessages()
                    .mapAPIErrorCode(ErrorMessages.APP_ERROR_VERIFICATION, ""));
        } else
          return ExchangeKeyFailedState(
              error: ErrorMessages()
                  .mapAPIErrorCode(r.responseCode, r.responseError));
      });
    }
  }
}
