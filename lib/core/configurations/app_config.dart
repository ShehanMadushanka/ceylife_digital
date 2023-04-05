enum DeviceOS { ANDROID, HUAWEI }

class AppConfig {
  static DeviceOS deviceOS = DeviceOS.ANDROID;

  //Security Config
  static bool isRootCheckAvailable = true;
  static bool isEmulatorCheckAvailable = true;
  static bool isADBCheckAvailable = true;
  static bool isSSLAvailable = true;

  static bool isPacketEncryptionAvailable = true;
  static bool isSourceVerificationAvailable = true;
}
