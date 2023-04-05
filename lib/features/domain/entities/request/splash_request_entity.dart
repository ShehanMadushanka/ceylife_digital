import 'package:ceylife_digital/features/data/models/requests/splash_request.dart';

class SplashRequestEntity extends SplashRequest {
  SplashRequestEntity({
    this.appHash,
    this.buildVersion,
    this.os,
    this.pushId,
    this.versionNumber,
  }) : super(
            appHash: appHash,
            buildVersion: buildVersion,
            os: os,
            pushId: pushId,
            versionNumber: versionNumber);

  String appHash;
  String buildVersion;
  String os;
  String pushId;
  String versionNumber;
}
