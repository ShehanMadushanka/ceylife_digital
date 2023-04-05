import 'dart:io';

import 'package:ceylife_digital/core/configurations/app_config.dart';
import 'package:ceylife_digital/features/data/datasources/shared_preference.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:huawei_push/push.dart';

class PushNotificationsManager {
  final AppSharedData _appSharedData;
  FirebaseMessaging _firebaseMessaging;

  PushNotificationsManager(this._appSharedData) {
    if (AppConfig.deviceOS == DeviceOS.ANDROID) {
      _firebaseMessaging = FirebaseMessaging();

      if (Platform.isIOS) {
        _firebaseMessaging
            .requestNotificationPermissions(IosNotificationSettings());
      }

      _firebaseMessaging.requestNotificationPermissions();
      _firebaseMessaging.configure();
    }
  }

  Future<bool> getFCMToken() async {
    String token = await _firebaseMessaging.getToken();
    if (token != null && token.isNotEmpty) {
      _appSharedData.setPushToken(token);
      return true;
    } else
      getFCMToken();
  }

  Future<bool> getHCMToken() async {
    Push.getToken("");
    Push.getTokenStream.listen((token) {
      _appSharedData.setPushToken(token);
      return true;
    }, onError: (error) {
      getHCMToken();
    });
  }
}
