// To parse this JSON data, do
//
//     final customerInitiatedServiceRequest = customerInitiatedServiceRequestFromJson(jsonString);

import 'dart:convert';

import 'package:ceylife_digital/features/data/models/requests/customer_initiated_service_request.dart';

class CustomerInitiatedServiceRequestEntity
    extends CustomerInitiatedServiceRequest {
  CustomerInitiatedServiceRequestEntity({
    this.mobileUserId,
  }) : super(mobileUserId: mobileUserId);

  int mobileUserId;

  factory CustomerInitiatedServiceRequestEntity.fromRawJson(String str) =>
      CustomerInitiatedServiceRequestEntity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomerInitiatedServiceRequestEntity.fromJson(
          Map<String, dynamic> json) =>
      CustomerInitiatedServiceRequestEntity(
        mobileUserId: json["mobileUserId"],
      );

  Map<String, dynamic> toJson() => {
        "mobileUserId": mobileUserId,
      };
}
