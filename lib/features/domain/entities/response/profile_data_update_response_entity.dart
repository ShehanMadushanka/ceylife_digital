// To parse this JSON data, do
//
//     final profileDataUpdateResponse = profileDataUpdateResponseFromJson(jsonString);

import 'package:equatable/equatable.dart';

class ProfileDataUpdateResponseEntity extends Equatable {
  ProfileDataUpdateResponseEntity({
    this.responseCode,
    this.responseError,
    this.data,
  });

  String responseCode;
  String responseError;
  String data;

  @override
  List<Object> get props => [responseError, responseCode, data];
}
