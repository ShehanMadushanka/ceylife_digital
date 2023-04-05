import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:after_init/after_init.dart';
import 'package:ceylife_digital/core/configurations/app_config.dart';
import 'package:ceylife_digital/core/service/biometric_services.dart';
import 'package:ceylife_digital/core/service/platform_services.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/common/app_data_provider.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_app_dialog.dart';
import 'package:ceylife_digital/features/presentation/common/file_upload_widget.dart';
import 'package:ceylife_digital/features/presentation/views/security/security_failure_view.dart';
import 'package:ceylife_digital/flavors/flavor_banner.dart';
import 'package:ceylife_digital/utils/app_animation.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:ceylife_digital/utils/navigation_routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:installer_info/installer_info.dart';
import 'package:lottie/lottie.dart';
import 'package:trust_fall/trust_fall.dart';

abstract class BaseView extends StatefulWidget {
  BaseView({Key key}) : super(key: key);
}

abstract class BaseViewState<Page extends BaseView> extends State<Page>
    with AfterInitMixin {
  SecurityFailureType _securityFailureType = SecurityFailureType.SECURE;
  bool isRealDevice = true, isJailBroken = false, isADBEnabled = true;
  InstallerInfo installerInfo;
  BiometricServices biometricServices = BiometricServices();

  Bloc getBloc();

  Widget buildView(BuildContext context);

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  bool _isProgressShow = false;
  bool _isLoadingShow = false;
  static Timer _timer;

  void _initializeTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer(const Duration(seconds: APP_SESSION_TIMEOUT), _stopTimer);
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;

    showCeylifeDialog(
        isSessionTimeout: true,
        title: AppLocalizations.of(context).translate('title_error'),
        message: AppLocalizations.of(context).translate('session_timeout'),
        onPositiveCallback: () {
          logout();
        });
  }

  logout() {
    AppConstants.IS_USER_LOGGED = false;
    Navigator.pushNamedAndRemoveUntil(
        context, Routes.SPLASH_VIEW, (route) => false);
  }

  checkSecurityAspects() async {
    if (AppConfig.isEmulatorCheckAvailable) {
      if (Platform.isAndroid)
        isRealDevice = await PlatformServices.isRealDevice;
      else
        isRealDevice = await TrustFall.isRealDevice;
    } else
      isRealDevice = true;

    if (AppConfig.isRootCheckAvailable) {
      if (Platform.isAndroid)
        isJailBroken = await PlatformServices.isRooted;
      else
        isJailBroken = await PlatformServices.isJailBroken;
    } else
      isJailBroken = false;

    if (Platform.isAndroid && AppConfig.isADBCheckAvailable) {
      isADBEnabled = await PlatformServices.getADBStatus;
      if (isADBEnabled) _securityFailureType = SecurityFailureType.ADB;
    }

    if (AppConfig.isSourceVerificationAvailable && AppConfig.deviceOS == DeviceOS.ANDROID) {
      installerInfo = await getInstallerInfo();
      if (installerInfo != null) {
        if (!((installerInfo.installerName == AppConstants.VENDOR_ANDROID) ||
            (installerInfo.installerName == AppConstants.VENDOR_HUAWEI) ||
            (installerInfo.installerName == AppConstants.VENDOR_IOS ||
                installerInfo.installerName == AppConstants.TESTFLIGHT_IOS))) {
          _securityFailureType = SecurityFailureType.SOURCE;
        }
      } else {
        _securityFailureType = SecurityFailureType.SOURCE;
      }
    }

    if (isJailBroken) {
      _securityFailureType = SecurityFailureType.ROOT;
    }

    if (!isRealDevice) {
      _securityFailureType = SecurityFailureType.EMU;
    }

    setState(() {});
  }

  void _handleUserInteraction(s) {
    if (AppConstants.IS_USER_LOGGED) {
      _initializeTimer();
    }
  }

  @override
  void initState() {
    _configureFirebase(context);
    _configureLocalNotification();
    biometricServices.initService();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    checkSecurityAspects();
    if (AppConstants.IS_USER_LOGGED) {
      _initializeTimer();
    }
  }

  @override
  void didInitState() {}

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BaseBloc>(
      create: (_) => getBloc(),
      child: BlocListener<BaseBloc, BaseState>(
        listener: (context, state) {
          if (state is APILoadingState) {
            showProgressBar();
          } else if(state is UploadLoadingState){
            showLoadingBar();
          }else {
            hideLoadingBar();
            hideProgressBar();
            if (state is SessionExpireState) {
              showCeylifeDialog(
                  isSessionTimeout: true,
                  title: AppLocalizations.of(context).translate('title_error'),
                  message:
                      AppLocalizations.of(context).translate('session_timeout'),
                  onPositiveCallback: () {
                    logout();
                  });
            } else if (state is APIFailureState) {
              showCeylifeDialog(
                  title: AppLocalizations.of(context).translate('title_error'),
                  message: state.errorResponseModel.responseError,
                  onPositiveCallback: () {});
            }
          }
        },
        child: FlavorBanner(
          child: Listener(
            behavior: HitTestBehavior.translucent,
            onPointerCancel: _handleUserInteraction,
            onPointerDown: _handleUserInteraction,
            onPointerMove: _handleUserInteraction,
            onPointerSignal: _handleUserInteraction,
            onPointerUp: _handleUserInteraction,
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: _securityFailureType == SecurityFailureType.SECURE
                  ? Platform.isAndroid
                      ? buildView(context)
                      : SafeArea(
                          child: buildView(context),
                          top: false,
                          left: false,
                          right: false,
                          bottom: false,
                          minimum: EdgeInsets.only(bottom: 10),
                        )
                  : SecurityFailureView(
                      securityFailureType: _securityFailureType,
                    ),
            ),
          ),
        ),
      ),
    );
  }

  void _configureFirebase(BuildContext context) {
    if (Platform.isIOS) _iOSPermission();

    _firebaseMessaging.getToken().then((token) {});

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        context.read<AppDataProvider>().incrementCount();
        showLocalPushNotifications(
            title: message['notification']['title'],
            message: message['notification']['body']);
      },
      onLaunch: (Map<String, dynamic> message) async {
        context.read<AppDataProvider>().incrementCount();
        showLocalPushNotifications(
            title: message['notification']['title'],
            message: message['notification']['body']);
      },
      onResume: (Map<String, dynamic> message) async {
        context.read<AppDataProvider>().incrementCount();
        showLocalPushNotifications(
            title: message['notification']['title'],
            message: message['notification']['body']);
      },
    );
  }

  showLocalPushNotifications(
      {@required String title, @required String message}) async {
    final IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails();
    var android = AndroidNotificationDetails(
        'platformID', 'platformChannel ', 'CeyLife',
        priority: Priority.high, importance: Importance.max);

    NotificationDetails platformChannelSpecifics =
        NotificationDetails(iOS: iOSPlatformChannelSpecifics, android: android);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      message,
      platformChannelSpecifics,
    );
  }

  void _iOSPermission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {});
  }

  Future<void> _configureLocalNotification() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    showCeylifeDialog(
      title: title,
    );
  }

  Future selectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
  }

  void showCeylifeDialog(
      {String title,
      String message,
      Color messageColor,
      String subDescription,
      Color subDescriptionColor,
      AlertType alertType = AlertType.SUCCESS,
      String positiveButtonText,
      String negativeButtonText,
      VoidCallback onPositiveCallback,
      VoidCallback onNegativeCallback,
      Widget dialogContentWidget,
      bool isSessionTimeout = false}) {
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: CeyLifeAppDialog(
                title: title,
                description: message,
                descriptionColor: messageColor,
                subDescription: subDescription,
                subDescriptionColor: subDescriptionColor,
                alertType: alertType,
                positiveButtonText: positiveButtonText,
                negativeButtonText: negativeButtonText,
                onNegativeCallback: onNegativeCallback,
                onPositiveCallback: onPositiveCallback,
                dialogContentWidget: dialogContentWidget,
                isSessionTimeout: isSessionTimeout,
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {});
  }

  showProgressBar() {
    if (!_isProgressShow) {
      _isProgressShow = true;
      showGeneralDialog(
          context: context,
          barrierDismissible: false,
          transitionBuilder: (context, a1, a2, widget) {
            return WillPopScope(
              onWillPop: () async => false,
              child: Transform.scale(
                scale: a1.value,
                child: Opacity(
                  opacity: a1.value,
                  child: BackdropFilter(
                    child: Container(
                      alignment: FractionalOffset.center,
                      child: Wrap(
                        children: [
                          Container(
                            color: Colors.transparent,
                            child: Lottie.asset(
                              AppAnimation.animLoading,
                              onLoaded: (composition) {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  ),
                ),
              ),
            );
          },
          transitionDuration: Duration(milliseconds: 200),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {});
    }
  }

  showLoadingBar() {
    if (!_isLoadingShow) {
      _isLoadingShow = true;
      showGeneralDialog(
          context: context,
          barrierDismissible: false,
          transitionBuilder: (context, a1, a2, widget) {
            return WillPopScope(
              onWillPop: () async => false,
              child: Transform.scale(
                scale: a1.value,
                child: Opacity(
                  opacity: a1.value,
                  child: BackdropFilter(
                    child: FileUploadProgressDialog(),
                    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  ),
                ),
              ),
            );
          },
          transitionDuration: Duration(milliseconds: 200),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {});
    }
  }

  hideLoadingBar(){
    if (_isLoadingShow) {
      Navigator.pop(context);
      _isLoadingShow = false;
    }
  }

  hideProgressBar() {
    if (_isProgressShow) {
      Navigator.pop(context);
      _isProgressShow = false;
    }
  }
}
