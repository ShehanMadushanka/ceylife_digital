import 'dart:io';

import 'package:ceylife_digital/core/service/platform_services.dart';
import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

class BiometricServices {
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  String reason;
  List<BiometricType> _availableBiometrics;

  initService() async {
    _availableBiometrics = await _localAuthentication.getAvailableBiometrics();
    reason = 'Touch your finger on the fingerprint sensor';
  }

  Future<bool> isEnrolled() async {
    bool isAvailable = false;
    if(Platform.isAndroid){
      isAvailable = await PlatformServices.hasBiometricEnrolled;
    }else {
      try {
        isAvailable = await _localAuthentication.canCheckBiometrics;
      } on PlatformException {}
    }

    return isAvailable;
  }

  Future<Biometric> getAvailableType() async {
    return await isEnrolled().then((enrolled) {
      if (enrolled) {
        if (_availableBiometrics.contains(BiometricType.fingerprint))
          return Biometric.FINGERPRINT;
        else if (_availableBiometrics.contains(BiometricType.face))
          return Biometric.FACE;
        else if (_availableBiometrics.contains(BiometricType.fingerprint) &&
            _availableBiometrics.contains(BiometricType.face))
          return Biometric.FINGERPRINT;
        else
          return Biometric.NONE;
      } else {
        return Biometric.NONE;
      }
    });
  }

  Future<bool> authenticate() async {
    bool isAuthenticated = false;
    try {
      isAuthenticated = await _localAuthentication.authenticateWithBiometrics(
          localizedReason: reason,
          androidAuthStrings: AndroidAuthMessages(
              cancelButton: 'Cancel',
              fingerprintHint: 'Please authenticate to enable the service',
              signInTitle: 'CeyLife Digital'),
          stickyAuth: true,
          useErrorDialogs: true);
    } catch (e) {
      return isAuthenticated;
    }

    return isAuthenticated;
  }
}
