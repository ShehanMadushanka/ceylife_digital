import 'dart:io';

import 'package:ceylife_digital/core/configurations/app_config.dart';
import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/splash/splash_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/splash/splash_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/splash/splash_state.dart';
import 'package:ceylife_digital/features/presentation/views/base_view.dart';
import 'package:ceylife_digital/utils/app_animation.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/app_extensions.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:ceylife_digital/utils/navigation_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:open_appstore/open_appstore.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashView extends BaseView {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends BaseViewState<SplashView>
    with TickerProviderStateMixin {
  final bloc = injection<SplashBloc>();

  @override
  void initState() {
    super.initState();
    if (AppConfig.isPacketEncryptionAvailable)
      bloc.add(ExchangeKeyEvent());
    else
      bloc.add(GetPushToken());
  }

  @override
  Widget buildView(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: BlocProvider<SplashBloc>(
          create: (_) => bloc,
          child: BlocListener<SplashBloc, BaseState<SplashState>>(
            cubit: bloc,
            listener: (context, state) {
              if (state is SplashSuccessState) {
                if (state.isLanguageExists) {
                  AppConstants.APP_LANGUAGE = state.languages;
                  switch (state.languages.getValue()) {
                    case 'en':
                      AppLocalizations.of(context).load(Locale("en", "US"));
                      break;
                    case 'si':
                      AppLocalizations.of(context).load(Locale("si", "LK"));
                      break;
                    case 'ta':
                      AppLocalizations.of(context).load(Locale("ta", "TA"));
                      break;
                  }

                  Navigator.pushNamedAndRemoveUntil(
                      context, Routes.LOGIN_VIEW, (route) => false);
                } else {
                  Navigator.pushNamedAndRemoveUntil(
                      context, Routes.PRE_LANG_VIEW, (route) => false);
                }
              } else if (state is SplashFailedState) {
                showCeylifeDialog(
                    title:
                        AppLocalizations.of(context).translate('title_error'),
                    message: state.error,
                    onPositiveCallback: () {
                      if (Platform.isAndroid) {
                        SystemNavigator.pop();
                      }
                    });
              } else if (state is PushTokenSuccessState) {
                if (kDebugMode && Platform.isAndroid) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, Routes.LOGIN_VIEW, (route) => false);
                } else {
                  bloc.add(SplashRequestEvent());
                }
              } else if (state is ForceUpdateState) {
                showCeylifeDialog(
                  title: AppLocalizations.of(context)
                      .translate('label_version_available'),
                  positiveButtonText: AppLocalizations.of(context)
                      .translate('button_update_now'),
                  onPositiveCallback: () {
                    if (AppConfig.deviceOS == DeviceOS.HUAWEI)
                      launch(
                          'appmarket://details?id=${AppConstants.androidAppID}',
                          enableJavaScript: false);
                    else
                      OpenAppstore.launch(
                        androidAppId: AppConstants.androidAppID,
                        iOSAppId: AppConstants.iOSAppID,
                      );
                  },
                  alertType: AlertType.FAIL,
                  message: AppLocalizations.of(context)
                      .translate('label_version_available_desc'),
                  dialogContentWidget: Column(
                    children: [
                      Lottie.asset(AppAnimation.animForceUpdate, repeat: true)
                    ],
                  ),
                );
              } else if (state is ExchangeKeySuccessState) {
                AppConstants.SERVER_PMK = state.exchangeResponseEntity.pmk;
                AppConstants.SERVER_KCV = state.exchangeResponseEntity.kcv;
                bloc.add(GetPushToken());
              } else if (state is ExchangeKeyFailedState) {
                showCeylifeDialog(
                    title:
                        AppLocalizations.of(context).translate('title_error'),
                    message: state.error,
                    onPositiveCallback: () {
                      if (Platform.isAndroid) {
                        SystemNavigator.pop();
                      }
                    });
              }
            },
            child: Container(
              decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                colors: [Colors.white, AppColors.splashGradient],
                stops: [0.0, 1.0],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
              )),
              child: Center(
                child: Image.asset(
                  AppImages.splashLogo,
                  width: 241,
                  height: 367,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Bloc getBloc() {
    return bloc;
  }
}
