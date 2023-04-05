import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

class PlatformServices {
  static const String ADB_REQ_KEY =
      "2672ef947486257c71881b970411546803f35a4ed09833edf55ab2e8968684c0";
  static const String APP_HASH_REQ_KEY =
      "c8fe82764f3a63f8eb5cd8c11a272b313ef113880c8eb3b8714004719eb958c3";
  static const String ROOT_REQ_KEY =
      "cdec2bb0ae84adc926bac868fc193b34a8e40a0e2970c9cda11f6bf9124427ef";
  static const String EMU_REQ_KEY =
      "bcf8b716f48ac74e853995f0a59fbdfe7f261fa247784ba8fe19218a07ce9517";
  static const String BIO_REQ_KEY =
      "75182d4878251a71bd16f72114be3dc05f0b3d957545dafa905416f571b8303d";
  static const String ADB_DISABLE_KEY =
      "a0404261b67a4debc2a32790ac94d132b3b6085e5da4b58129527dc8f371dcaf";
  static const String ADB_RES_KEY =
      "c68622628700ae373e914ec0a7c527cb85dea7292e6cf7fffc8239e0f98e9b33";
  static const String ROOT_RES_KEY =
      "18417d51b0f0917e79ee900abfeb4aa59c51bd65b456cf23e3b607cd677eb8c9";
  static const String EMU_RES_KEY =
      "4e0966ea2be68e9bee5987918154ecb5c5574536605e8314162d42bab08ce494";
  static const String JAIL_KEY = "messedUp";

  static const platform = const MethodChannel('ceylinco_method_channel');

  static Future<bool> get getADBStatus async {
    final res = await platform.invokeMethod(ADB_REQ_KEY);
    Map<String, bool> map = _decoder(res.keys.first, res.values.first);
    if (map.keys.first == ADB_RES_KEY)
      return map.values.first;
    else
      return false;
  }

  static Future<String> get signature async {
    if (Platform.isAndroid) {
      return await platform.invokeMethod(APP_HASH_REQ_KEY);
    } else {
      return "12345";
    }
  }

  static Future<bool> get isRooted async {
    final res = await platform.invokeMethod(ROOT_REQ_KEY);
    Map<String, bool> map = _decoder(res.keys.first, res.values.first);
    if (map.keys.first == ROOT_RES_KEY)
      return map.values.first;
    else
      return false;
  }

  static Future<bool> get isJailBroken async {
    final res = await platform.invokeMethod(JAIL_KEY);
    return res;
  }

  static Future<bool> get isRealDevice async {
    final res = await platform.invokeMethod(EMU_REQ_KEY);
    Map<String, bool> map = _decoder(res.keys.first, res.values.first);
    if (map.keys.first == EMU_RES_KEY)
      return map.values.first;
    else
      return false;
  }

  static Future<bool> get hasBiometricEnrolled async {
    final res = await platform.invokeMethod(BIO_REQ_KEY);
    return res;
  }

  static disableADB() async{
    await platform.invokeMethod(ADB_DISABLE_KEY);
  }

  static Map<String, bool> _decoder(String key, String value) {
    String decoded = utf8.decode(base64Decode(utf8.decode(base64Decode(key))));
    var resArr = decoded.split(value);
    Map<String, bool> result = HashMap();
    result.putIfAbsent(resArr.join(""), () => resArr.length.isOdd);
    return result;
  }
}
