import 'package:ceylife_digital/core/configurations/app_config.dart';
import 'package:ceylife_digital/core/service/push_notification_manager.dart';

class CloudServices {
  final PushNotificationsManager _pushNotificationsManager;

  CloudServices(this._pushNotificationsManager);

  Future<bool> capturePushToken() {
    if(AppConfig.deviceOS == DeviceOS.ANDROID)
      return _pushNotificationsManager.getFCMToken();
    else
      return _pushNotificationsManager.getHCMToken();
  }
}
