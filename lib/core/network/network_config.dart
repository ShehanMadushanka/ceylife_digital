import 'package:ceylife_digital/flavors/flavor_config.dart';

const CONNECT_TIMEOUT = 5 * 60 * 1000;
const RECEIVE_TIMEOUT = 5 * 60 * 1000;

class IPAddress {
  static const String DEV = 'epictechdev.com:65534/';
  static const String DEV_LOCAL = '192.168.1.45:6689/';
  static const String QA = '192.168.1.28:6689/';
  static const String QA_PUBLIC = '124.43.16.185:58588/';
  static const String QA_CEYLIFE = 'cusapp01.ceylincolife.com/';
  static const String UAT = 'cusapp01.ceylincolife.com/';
  static const String LIVE = 'cusapp02.ceylincolife.com/';
}

class ServerProtocol {
  static const String DEV = 'http://';
  static const String QA = 'http://';
  static const String QA_CEYLIFE = 'https://';
  static const String UAT = 'https://';
  static const String LIVE = 'https://';
}

class ContextRoot {
  static const String DEV = 'cli-dev/api/v1/';
  static const String QA = 'cli-test/api/v1/';
  static const String QA_CEYLIFE = 'cli-dev/api/v1/';
  static const String UAT = 'uat/api/v1/';
  static const String LIVE = 'prod/api/v1/';
}

class NetworkConfig {
  static String getNetworkUrl() {
    String url = _getProtocol() + _getIP() + _getContextRoot();
    return url;
  }

  static String _getContextRoot() {
    if (FlavorConfig.isDevelopment()) {
      return ContextRoot.DEV;
    } else if (FlavorConfig.isQA()) {
      return ContextRoot.QA_CEYLIFE;
    } else if (FlavorConfig.isUAT()) {
      return ContextRoot.UAT;
    } else {
      return ContextRoot.LIVE;
    }
  }

  static String _getProtocol() {
    if (FlavorConfig.isDevelopment()) {
      return ServerProtocol.DEV;
    } else if (FlavorConfig.isQA()) {
      return ServerProtocol.QA_CEYLIFE;
    } else if (FlavorConfig.isUAT()) {
      return ServerProtocol.UAT;
    } else {
      return ServerProtocol.LIVE;
    }
  }

  static String _getIP() {
    if (FlavorConfig.isDevelopment()) {
      return IPAddress.DEV;
    } else if (FlavorConfig.isQA()) {
      return IPAddress.QA_CEYLIFE;
    } else if (FlavorConfig.isUAT()) {
      return IPAddress.UAT;
    } else {
      return IPAddress.LIVE;
    }
  }
}

class APIResponse {
  static const String RESPONSE_SUCCESS = "1000";
  static const String RESPONSE_FAILED_FORCE_UPDATE = "1001";
  static const String RESPONSE_APPLICATION_VERSIOM_NO_MISMATCH = "1002";
  static const String RESPONSE_UNKNOWN_OS = "1003";
  static const String RESPONSE_UNKNOWN_VERSION_NO = "1004";
  static const String RESPONSE_INVALID_APP_HASH = "1005";
  static const String RESPONSE_SUCCESS_OTP_NOT_SEND = "1006";
  static const String RESPONSE_DEVICE_TOKEN_INSERT_FAILED = "1007";
  static const String RESPONSE_DEVICE_UPDATE_FAILED = "1008";
  static const String RESPONSE_DEVICE_ID_MISSING = "1009";
  static const String RESPONSE_USER_NOT_FOUND = "1010";
  static const String RESPONSE_USER_MOBILE_NO_NOT_FOUND = "1011";
  static const String RESPONSE_USER_EMAIL_NOT_FOUND = "1012";
  static const String RESPONSE_MULTIPLE_RECORDS_UPDATED = "1013";
  static const String RESPONSE_OTP_VALIDATION_FAILED = "1014";
  static const String RESPONSE_OTP_EXPIRED = "1015";
  static const String RESPONSE_INVALID_PASSWORD = "1016";
  static const String RESPONSE_INVALID_USER_KEY_TYPE = "1017";
  static const String RESPONSE_INVALID_REQUESTED_DATA = "1018";
  static const String RESPONSE_INVALID_USER = "1019";
  static const String RESPONSE_FAILED_EXISTING_USER_ID = "1020";
  static const String RESPONSE_FAILED_OTP_SEND = "1022";
  static const String RESPONSE_USER_TEMPORILY_LOCKED = "1023";
  static const String RESPONSE_LOGIN_INVALID_CREDENTIALS = "1024";
  static const String RESPONSE_LOGIN_FAILED = "1025";
  static const String RESPONSE_FAILED_REQUEST_PENDING = "1026";
  static const String
      RESPONSE_CUSTOMER_INITIATED_SERVICE_REQUEST_ALREADY_IN_PROGRESS = "1027";
  static const String RESPONSE_PREMIUM_CESS_DATE_EXPIRED = "1028";
  static const String RESPONSE_FAILED_TRANSACTION_NOT_FOUND = "1029";
}
