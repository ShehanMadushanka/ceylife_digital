import 'dart:convert';
import 'dart:developer';

import 'package:ceylife_digital/core/configurations/app_config.dart';
import 'package:ceylife_digital/error/exceptions.dart';
import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/features/data/models/common/base_api_handler.dart';
import 'package:ceylife_digital/features/data/models/responses/common_error_response.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/encryption/encryptor/epic_dart_encryptor.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:hex/hex.dart';
import 'package:http_certificate_pinning/certificate_pinning_interceptor.dart';

import 'certificates.dart';
import 'network_config.dart';

class APIHelper {
  final Dio dio;
  var token;
  String deviceId;
  String request;

  APIHelper({@required this.dio}) {
    _initApiClient();
  }

  String _getLanguageCode() {
    switch (AppConstants.APP_LANGUAGE) {
      case Languages.ENGLISH:
        return "ENG";
        break;
      case Languages.SINHALA:
        return "SIN";
        break;
      case Languages.TAMIL:
        return "TAM";
        break;
    }
  }

  Future<void> _initApiClient() async {
    final logInterceptor = LogInterceptor(
        requestBody: !kReleaseMode,
        responseBody: !kReleaseMode,
        error: false,
        requestHeader: !kReleaseMode,
        responseHeader: !kReleaseMode);

    deviceId = await FlutterUdid.consistentUdid;

    BaseOptions options = new BaseOptions(
      connectTimeout: CONNECT_TIMEOUT,
      receiveTimeout: RECEIVE_TIMEOUT,
      baseUrl: NetworkConfig.getNetworkUrl(),
      contentType: 'application/json',
      headers: {'device_id': deviceId, 'request-from': 'MOB'},
    );

    dio
      ..options = options
      ..interceptors.add(logInterceptor);

    if (AppConfig.isSSLAvailable) {
      dio.interceptors
          .add(CertificatePinningInterceptor(SSLCert.getCertificates()));
    }

    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      if (token != null) {
        options.headers["Authorization"] = "Bearer $token";
      }

      options.headers["Accept-Language"] = _getLanguageCode();
      return options;
    }, onResponse: (Response response) async {
      return response;
    }, onError: (DioError e) async {
      return e;
    }));
  }

  Future<dynamic> get(String url) async {
    try {
      final response = await dio.get(NetworkConfig.getNetworkUrl() + url);

      if (AppConfig.isPacketEncryptionAvailable) {
        BaseAPIHandler exchangeResponse =
            BaseAPIHandler.fromJson(response.data);

        Map<String, dynamic> kxMap;
        try {
          kxMap = jsonDecode(DartEncryptor.decryptPacket(
              encryptedData: exchangeResponse.data,
              keyInfo: exchangeResponse.keyInfo,
              mode: null,
              deviceID: deviceId));
        } on Exception {
          throw ServerException(ErrorResponseModel(
              responseError: ErrorMessages().mapAPIErrorCode(
                  ErrorMessages.APP_ERROR_SOMETHING_WRONG, "")));
        }

        printDecodedData(kxMap);
        return kxMap;
      } else {
        printDecodedData(response.data);
        return response.data;
      }
    } on DioError catch (e) {
      if (kDebugMode)
        log('[API Helper - GET] Connection Exception => ' + e.message);

      if (e.response != null) {
        final int statusCode = e.response.statusCode;

        Map<String, dynamic> kxMap;

        if (AppConfig.isPacketEncryptionAvailable) {
          BaseAPIHandler exchangeResponse =
              BaseAPIHandler.fromJson(e.response.data);
          try {
            kxMap = jsonDecode(DartEncryptor.decryptPacket(
                encryptedData: exchangeResponse.data,
                keyInfo: exchangeResponse.keyInfo,
                mode: null,
                deviceID: deviceId));
          } catch (e) {
            throw ServerException(ErrorResponseModel(
                responseError: ErrorMessages().mapAPIErrorCode(
                    ErrorMessages.APP_ERROR_SOMETHING_WRONG, "")));
          }
        }

        if (statusCode < 200 || statusCode > 400) {
          switch (statusCode) {
            case 401:
            case 403:
              throw UnAuthorizedException(ErrorResponseModel.fromJson(
                  AppConfig.isPacketEncryptionAvailable
                      ? kxMap
                      : e.response.data));
            case 404:
              throw ServerException(ErrorResponseModel(
                  responseError: ErrorMessages().mapAPIErrorCode(
                      ErrorMessages.APP_ERROR_SOMETHING_WRONG, "")));
            case 500:
            default:
              throw DioException(
                  errorResponseModel: ErrorResponseModel(
                      responseCode: e.response.statusCode.toString(),
                      responseError: e.response.statusMessage));
          }
        }
      } else
        throw ServerException(ErrorResponseModel(
            responseError: ErrorMessages()
                .mapAPIErrorCode(ErrorMessages.APP_ERROR_SOMETHING_WRONG, "")));
    }
  }

  Future<dynamic> post(String url,
      {Map headers,
      @required body,
      encoding,
      String contentType = 'application/json',
      isKeyExchangeRequest = false}) async {
    try {
      if (AppConfig.isPacketEncryptionAvailable) {
        try {
          if (isKeyExchangeRequest) {
            try {
              request = DartEncryptor.encryptPacket(
                  data: utf8.encode(jsonEncode(body)),
                  deviceId: deviceId,
                  mode: DartEncryptor.DEVICE_KEY_ENC);
            } catch (e) {
              throw ServerException(ErrorResponseModel(
                  responseError: ErrorMessages().mapAPIErrorCode(
                      ErrorMessages.APP_ERROR_SOMETHING_WRONG, "")));
            }
          } else {
            try {
              request = DartEncryptor.encryptPacket(
                  data: utf8.encode(jsonEncode(body)),
                  mode: DartEncryptor.SESSION_KEY_ENC,
                  deviceId: '');
            } catch (e) {
              throw ServerException(ErrorResponseModel(
                  responseError: ErrorMessages().mapAPIErrorCode(
                      ErrorMessages.APP_ERROR_SOMETHING_WRONG, "")));
            }
          }
        } on Exception {
          throw ServerException(ErrorResponseModel(
              responseError: ErrorMessages().mapAPIErrorCode(
                  ErrorMessages.APP_ERROR_SOMETHING_WRONG, "")));
        }

        BaseAPIHandler baseAPIHandler = BaseAPIHandler(
            data: request,
            keyInfo: DartEncryptor.tc +
                '-' +
                DartEncryptor.kcv +
                '-' +
                HEX.encode(DartEncryptor.iv));

        final response = await dio.post(url,
            data: baseAPIHandler.toJson(), options: Options(headers: headers), onSendProgress: (sent, total) {
              AppConstants.LOADING_PROGRESS = (sent / total) * 100;
            });

        Map<String, dynamic> kxMap;
        try {
          if (isKeyExchangeRequest) {
            BaseAPIHandler exchangeResponse =
                BaseAPIHandler.fromJson(response.data);
            try {
              kxMap = jsonDecode(DartEncryptor.decryptPacket(
                  encryptedData: exchangeResponse.data,
                  keyInfo: exchangeResponse.keyInfo,
                  mode: DartEncryptor.DEVICE_KEY_DEC,
                  deviceID: deviceId));
            } catch (e) {
              throw ServerException(ErrorResponseModel(
                  responseError: ErrorMessages().mapAPIErrorCode(
                      ErrorMessages.APP_ERROR_SOMETHING_WRONG, "")));
            }
          } else {
            BaseAPIHandler exchangeResponse =
                BaseAPIHandler.fromJson(response.data);
            try {
              kxMap = jsonDecode(DartEncryptor.decryptPacket(
                  encryptedData: exchangeResponse.data,
                  keyInfo: exchangeResponse.keyInfo,
                  mode: null,
                  deviceID: deviceId));
            } catch (e) {
              throw ServerException(ErrorResponseModel(
                  responseError: ErrorMessages().mapAPIErrorCode(
                      ErrorMessages.APP_ERROR_SOMETHING_WRONG, "")));
            }
          }
        } on Exception {
          throw ServerException(ErrorResponseModel(
              responseError: ErrorMessages().mapAPIErrorCode(
                  ErrorMessages.APP_ERROR_SOMETHING_WRONG, "")));
        }

        if (response.headers["token"] != null) {
          token = response.headers["token"][0];
        }

        printDecodedData(kxMap);
        return kxMap;
      } else {
        final response = await dio.post(url,
            data: body,
            options: Options(headers: headers, contentType: contentType),
            onSendProgress: (sent, total) {
          AppConstants.LOADING_PROGRESS = (sent / total) * 100;
        });
        if (response.headers["token"] != null) {
          token = response.headers["token"][0];
        }
        printDecodedData(response.data);
        return response.data;
      }
    } on DioError catch (e) {
      if (kDebugMode)
        log('[API Helper - POST] Connection Exception => ' + e.message);

      Map<String, dynamic> kxMap;

      if (AppConfig.isPacketEncryptionAvailable) {
        if (isKeyExchangeRequest) {
          BaseAPIHandler exchangeResponse =
              BaseAPIHandler.fromJson(e.response.data);
          try {
            kxMap = jsonDecode(DartEncryptor.decryptPacket(
                encryptedData: exchangeResponse.data,
                keyInfo: exchangeResponse.keyInfo,
                mode: DartEncryptor.DEVICE_KEY_DEC,
                deviceID: deviceId));
          } catch (e) {
            throw ServerException(ErrorResponseModel(
                responseError: ErrorMessages().mapAPIErrorCode(
                    ErrorMessages.APP_ERROR_SOMETHING_WRONG, "")));
          }
        } else {
          BaseAPIHandler exchangeResponse =
              BaseAPIHandler.fromJson(e.response.data);
          try {
            kxMap = jsonDecode(DartEncryptor.decryptPacket(
                encryptedData: exchangeResponse.data,
                keyInfo: exchangeResponse.keyInfo,
                mode: null,
                deviceID: deviceId));
          } catch (e) {
            throw ServerException(ErrorResponseModel(
                responseError: ErrorMessages().mapAPIErrorCode(
                    ErrorMessages.APP_ERROR_SOMETHING_WRONG, "")));
          }
        }
      }

      if (e.response != null) {
        final int statusCode = e.response.statusCode;

        if (statusCode < 200 || statusCode >= 400) {
          switch (statusCode) {
            case 400:
              throw ServerException(ErrorResponseModel(
                  responseError: ErrorMessages().mapAPIErrorCode(
                      AppConfig.isPacketEncryptionAvailable
                          ? kxMap['response_code']
                          : e.response.data['response_code'],
                      AppConfig.isPacketEncryptionAvailable
                          ? kxMap['response_error']
                          : e.response.data['response_error'])));
            case 401:
            case 403:
              throw UnAuthorizedException(ErrorResponseModel(
                  responseError: ErrorMessages().mapAPIErrorCode(
                      AppConfig.isPacketEncryptionAvailable
                          ? kxMap['response_code']
                          : e.response.data['response_code'],
                      AppConfig.isPacketEncryptionAvailable
                          ? kxMap['response_error']
                          : e.response.data['response_error'])));
            case 404:
              throw ServerException(ErrorResponseModel(
                  responseError: ErrorMessages().mapAPIErrorCode(
                      ErrorMessages.APP_ERROR_SOMETHING_WRONG, "")));
            case 500:
            default:
              throw DioException(
                  errorResponseModel: ErrorResponseModel(
                      responseCode: e.response.statusCode.toString(),
                      responseError: ErrorMessages().mapAPIErrorCode(
                          e.response.statusCode.toString(),
                          e.response.statusMessage)));
          }
        }
      } else
        throw ServerException(ErrorResponseModel(
            responseError: ErrorMessages()
                .mapAPIErrorCode(ErrorMessages.APP_ERROR_SOMETHING_WRONG, "")));
    }
  }

  printDecodedData(Map<String, dynamic> map) {
    if (kDebugMode) {
      try {
        log("[Decoded Response Data]\n${json.encode(map)}\n\n");
      } catch (e) {
        log("[Decoded Response Data]\n${e.toString()}");
      }
    }
  }

  void interceptApi() {
    dio.interceptors.clear();

    dio
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (RequestOptions options) {
            if (token != null) {
              options.headers["Authorization"] = "Bearer $token";
            }
            return options;
          },
          onResponse: (Response response) {
            return response;
          },
          onError: (DioError error) async {
            if (error.response?.statusCode == 401) {
              dio.interceptors.requestLock.lock();
              dio.interceptors.responseLock.lock();

              RequestOptions options = error.response.request;
              dio.interceptors.requestLock.unlock();
              dio.interceptors.responseLock.unlock();

              return dio.request(options.path, options: options);
            } else {
              return error;
            }
          },
        ),
      );
  }
}
