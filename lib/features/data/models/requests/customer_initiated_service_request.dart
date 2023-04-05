// To parse this JSON data, do
//
//     final customerInitiatedServiceRequest = customerInitiatedServiceRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

class CustomerInitiatedServiceRequest extends Equatable {
  CustomerInitiatedServiceRequest({
    this.mobileUserId,
  });

  int mobileUserId;

  factory CustomerInitiatedServiceRequest.fromRawJson(String str) =>
      CustomerInitiatedServiceRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomerInitiatedServiceRequest.fromJson(Map<String, dynamic> json) =>
      CustomerInitiatedServiceRequest(
        mobileUserId: json["mobileUserId"],
      );

  Map<String, dynamic> toJson() => {
        "mobileUserId": mobileUserId,
      };

  @override
  List<Object> get props => [mobileUserId];
}
