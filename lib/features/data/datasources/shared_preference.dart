import 'dart:convert';

import 'package:ceylife_digital/features/data/models/common/configuration_data.dart';
import 'package:ceylife_digital/features/domain/entities/response/login_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/splash_response_entity.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const String _PUSH_TOKEN = 'push_token';
const String _CACHE_USER = 'cache_user';
const String _CONFIG_DATA = 'config_data';
const String _APP_LANGUAGE = 'app_language';
const String _INITIAL_LAUNCH_FLAG = 'initial_launch_flag';
const String _BIOMETRIC_FLAG = 'biometric_flag';

class AppSharedData {
  FlutterSecureStorage secureStorage;

  AppSharedData(FlutterSecureStorage preferences) {
    secureStorage = preferences;
  }

  Future<bool> hasPushToken() async {
    return await secureStorage.containsKey(key: _PUSH_TOKEN);
  }

  Future<bool> isInitialLaunch() async {
    return await secureStorage.containsKey(key: _INITIAL_LAUNCH_FLAG);
  }

  setPushToken(String token) {
    secureStorage.write(key: _PUSH_TOKEN, value: token);
  }

  setAppLanguage(String language) {
    secureStorage.write(key: _APP_LANGUAGE, value: language);
  }

  setInitialLaunch() {
    secureStorage.write(key: _INITIAL_LAUNCH_FLAG, value: _INITIAL_LAUNCH_FLAG);
  }

  Future<String> getPushToken() async {
    return await secureStorage.read(key: _PUSH_TOKEN);
  }

  Future<String> getAppLanguage() async {
    return await secureStorage.read(key: _APP_LANGUAGE);
  }

  clearPushToken() {
    secureStorage.delete(key: _PUSH_TOKEN);
  }

  Future<bool> hasCacheUser() async {
    return await secureStorage.containsKey(key: _CACHE_USER);
  }

  Future<bool> hasConfigurationData() async {
    return await secureStorage.containsKey(key: _CONFIG_DATA);
  }

  Future<ProfileEntity> getCacheUser() async {
    bool user = await hasCacheUser();
    if (user) {
      final value = await secureStorage.read(key: _CACHE_USER);
      return Future.value(ProfileEntity.fromJson(jsonDecode(value)));
    } else {
      return Future.value(ProfileEntity());
    }
  }

  Future<ConfigurationData> getConfigurationData() async {
    bool data = await hasConfigurationData();
    if (data) {
      final value = await secureStorage.read(key: _CONFIG_DATA);
      return Future.value(ConfigurationData.fromJson(jsonDecode(value)));
    } else {
      return Future.value(ConfigurationData());
    }
  }

  Future<void> setCacheUser(
      {String username,
      String nic,
      String address1,
      String address2,
      String city,
      String dateOfBirth,
      String email,
      String fullName,
      String mobileNumber,
      String nickname,
      String profileImage,
      int mobileUserId,
      int leadGenerationId,
      bool isLeadGenerator}) async {
    ProfileEntity cachedUser;
    final hasUser = await hasCacheUser();

    if (hasUser) {
      final user = await secureStorage.read(key: _CACHE_USER);
      cachedUser = ProfileEntity.fromJson(jsonDecode(user));
    } else {
      cachedUser = ProfileEntity();
    }

    if (username != null && username.isNotEmpty) cachedUser.username = username;
    if (leadGenerationId != null) cachedUser.leadGeneratorId = leadGenerationId;
    if (isLeadGenerator != null) cachedUser.isLeadGenerator = isLeadGenerator;
    if (nic != null && nic.isNotEmpty) cachedUser.nicNo = nic;
    if (address1 != null && address1.isNotEmpty)
      cachedUser.addressLine1 = address1;
    if (address2 != null && address2.isNotEmpty)
      cachedUser.addressLine2 = address2;
    if (city != null && city.isNotEmpty) cachedUser.city = city;
    if (dateOfBirth != null && dateOfBirth.isNotEmpty)
      cachedUser.dateOfBirth = dateOfBirth;
    if (email != null && email.isNotEmpty) cachedUser.email = email;
    if (fullName != null && fullName.isNotEmpty) cachedUser.fullName = fullName;
    if (mobileNumber != null && mobileNumber.isNotEmpty)
      cachedUser.mobileNo = mobileNumber;
    if (nickname != null && nickname.isNotEmpty) cachedUser.nickName = nickname;
    if (profileImage != null && profileImage.isNotEmpty)
      cachedUser.profilePictureUrl = profileImage;
    if (mobileUserId != null) cachedUser.mobileUserId = mobileUserId;

    secureStorage.write(
        key: _CACHE_USER, value: jsonEncode(cachedUser.toJson()));
  }

  setConfigurationData(
      {ConfigurationDataEntity configurationDataEntity}) async {
    ConfigurationDataEntity configurationData;
    bool hasData = await hasConfigurationData();
    if (hasData) {
      final confData = await secureStorage.read(key: _CONFIG_DATA);
      configurationData =
          ConfigurationDataEntity.fromJson(jsonDecode(confData));
    } else {
      configurationData = ConfigurationDataEntity();
    }

    if (configurationDataEntity != null)
      configurationData = configurationDataEntity;

    return secureStorage.write(
        key: _CONFIG_DATA, value: jsonEncode(configurationData.toJson()));
  }

  setBiometric(String isEnabled) {
    secureStorage.write(key: _BIOMETRIC_FLAG, value: isEnabled);
  }

  Future<bool> getBiometric() async {
    bool hasBiometric = await secureStorage.containsKey(key: _BIOMETRIC_FLAG);
    if (hasBiometric) {
      String value = await secureStorage.read(key: _BIOMETRIC_FLAG);
      if (value == 'YES')
        return true;
      else
        return false;
    } else {
      return false;
    }
  }
}
