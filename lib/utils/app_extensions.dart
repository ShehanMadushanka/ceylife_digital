import 'dart:convert';
import 'dart:io';

import 'package:ceylife_digital/core/configurations/app_config.dart';
import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:crypto/crypto.dart';

extension SHA1Ext on String {
  String getSHA1() {
    return sha1.convert(utf8.encode(this)).toString();
  }
}

extension DeviceOSExt on DeviceOS {
  String getValue() {
    if (Platform.isIOS)
      return "IOS";
    else
      return this.toString().split(".").last;
  }
}

extension StatusValue on DirectPayStatus {
  String getStatus() {
    if (this == DirectPayStatus.SUCCESS)
      return ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_EMPTY_DIRECTPAY_STATUS_SUCCESS, '');
    else
      return ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_EMPTY_DIRECTPAY_STATUS_FAILED, '');
  }
}

extension InfoTypeExt on InfoType {
  // ignore: missing_return
  String getValue() {
    switch (this) {
      case InfoType.NAME:
        return ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_INFO_TYPE_NAME, '');
      case InfoType.EMAIL:
        return ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_INFO_TYPE_EMAIL, '');
      case InfoType.NIC:
        return ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_INFO_TYPE_NIC, '');
      case InfoType.DOB:
        return ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_INFO_TYPE_DOB, '');
      case InfoType.MOBILE:
        return ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_INFO_TYPE_MOBILE, '');
      case InfoType.ADDRESS:
        return ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_INFO_TYPE_ADDRESS, '');
    }
  }
}

extension NotificationExt on NotificationType {
  // ignore: missing_return
  String getValue() {
    switch (this) {
      case NotificationType.NEWS:
        return ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_NOTIFICATION_TYPE_NEWS, '');
      case NotificationType.PROMO:
        return ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_NOTIFICATION_TYPE_PROMO, '');
    }
  }
}

extension DrawerItemExt on DrawerItem {
  // ignore: missing_return
  String get value {
    switch (this) {
      case DrawerItem.PAYMENT_HISTORY:
        return ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_DRAWER_ITEM_PAYMENT_HISTORY, '');
      case DrawerItem.CUSTOMER_SERVICE_REQUEST:
        return ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_DRAWER_ITEM_CUSTOMER_SERVICE, '');
      case DrawerItem.SETTINGS:
        return ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_DRAWER_ITEM_SETTINGS, '');
      case DrawerItem.PASSWORD_RESET:
        return ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_DRAWER_ITEM_PWD_RESET, '');
      case DrawerItem.BRANCH_LOCATOR:
        return ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_DRAWER_ITEM_BRANCH, '');
      case DrawerItem.CONTACT_US:
        return ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_DRAWER_ITEM_CONTACT, '');
      case DrawerItem.FAQ:
        return ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_DRAWER_ITEM_FAQ, '');
      case DrawerItem.FEATURE1:
        return 'Feature 01';
      case DrawerItem.FEATURE2:
        return 'Feature 02';
        break;
      case DrawerItem.LANGUAGE_SELECTION:
        return ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_DRAWER_ITEM_LANGUAGE, '');
        break;
    }
  }
}

extension PolicyStatusDescription on PolicyStatus {
  String get value {
    switch (this) {
      case PolicyStatus.ACTIVE:
        return ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_POLICY_STATUS_DES_ACTIVE, '');
        break;
      case PolicyStatus.LAPSED:
        return ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_POLICY_STATUS_DES_LAPSED, '');
        break;
      case PolicyStatus.PAIDUP:
        return ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_POLICY_STATUS_DES_PAIDUP, '');
        break;
      case PolicyStatus.PROPOSAL:
        return ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_POLICY_STATUS_DES_PROPOSAL, '');
        break;
      case PolicyStatus.MATURED:
        return ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_POLICY_STATUS_DES_MATURED, '');
        break;
      case PolicyStatus.BUYONLINE:
        return ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_POLICY_STATUS_DES_BUY, '');
        break;
    }
  }
}

extension PolicyStatusMapper on String {
  PolicyStatus get mapPolicyStatus {
    if (this == 'ACTIVE')
      return PolicyStatus.ACTIVE;
    else if (this == 'LAPSED')
      return PolicyStatus.LAPSED;
    else if (this == 'PAIDUP')
      return PolicyStatus.PAIDUP;
    else if (this == 'PROPOSAL')
      return PolicyStatus.PROPOSAL;
    else if (this == 'MATURED')
      return PolicyStatus.MATURED;
    else
      return PolicyStatus.BUYONLINE;
  }
}

extension EmptyStatusExt on EmptyStatus {
  // ignore: missing_return
  String getValue() {
    switch (this) {
      case EmptyStatus.NEWS:
        return ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_EMPTY_STATUS_NEWS, '');
      case EmptyStatus.PAYMENT_HISTORY:
        return ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_EMPTY_STATUS_PAYMENT, '');
      case EmptyStatus.CUSTOMER_SERVICE_REQUEST:
        return ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_EMPTY_STATUS_REQUEST, '');
      case EmptyStatus.NOTIFICATIONS:
        return ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_EMPTY_STATUS_NOTIFICATION, '');
      case EmptyStatus.PROMOTIONS:
        return ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_EMPTY_STATUS_PROMOTION, '');
      case EmptyStatus.HEALTH_TIPS:
        return ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_EMPTY_STATUS_HEALTH_TIP, '');
        break;
      case EmptyStatus.RATE_HISTORY:
        return ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_EMPTY_STATUS_RATE, '');
        break;
      case EmptyStatus.PRODUCT_DETAILS:
        return ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_EMPTY_STATUS_PRODUCT_DETAIL, '');
        break;
      case EmptyStatus.BENEFITS:
        return ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_EMPTY_STATUS_BENEFIT, '');
        break;
      case EmptyStatus.LOAD_DETAIL:
        return ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_EMPTY_STATUS_LOAN, '');
    }
  }
}

extension AppLanguage on Languages {
  String getValue() {
    switch (this) {
      case Languages.ENGLISH:
        return 'en';
        break;
      case Languages.SINHALA:
        return 'si';
        break;
      case Languages.TAMIL:
        return 'ta';
        break;
    }
  }
}

extension StrToLan on String {
  Languages getLanguage() {
    if (this == 'en')
      return Languages.ENGLISH;
    else if (this == 'si')
      return Languages.SINHALA;
    else if (this == 'ta')
      return Languages.TAMIL;
    else
      return Languages.ENGLISH;
  }
}

extension SignInTypeToStr on SignInType{
  String getValue(){
    switch(this){
      case SignInType.PASSWORD:
        return "PASSWORD";
        break;
      case SignInType.BIOMETRIC:
        return "BIOMETRIC";
        break;
    }
  }
}
