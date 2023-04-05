// To parse this JSON data, do
//
//     final getLoginResponse = getLoginResponseFromJson(jsonString);

import 'package:equatable/equatable.dart';

class ErrorResponse extends Equatable {
  ErrorResponse({
    this.responseCode,
    this.responseError,
  });

  String responseCode;
  String responseError;

  @override
  List<Object> get props => [responseError, responseCode];
}
