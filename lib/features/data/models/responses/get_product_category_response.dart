// To parse this JSON data, do
//
//     final getProductCategoryResponse = getProductCategoryResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ceylife_digital/features/domain/entities/response/product_category_entity.dart';
import 'package:ceylife_digital/utils/string_util.dart';

GetProductCategoryResponse getProductCategoryResponseFromJson(String str) =>
    GetProductCategoryResponse.fromJson(json.decode(str));

String getProductCategoryResponseToJson(GetProductCategoryResponse data) =>
    json.encode(data.toJson());

class GetProductCategoryResponse {
  GetProductCategoryResponse({
    this.responseCode,
    this.responseError,
    this.productCategoryData,
  });

  String responseCode;
  String responseError;
  List<ProductCategoryData> productCategoryData;

  factory GetProductCategoryResponse.fromJson(Map<String, dynamic> json) =>
      GetProductCategoryResponse(
        responseCode: json["response_code"],
        responseError: json["response_error"],
        productCategoryData: json["productCategoryData"] != null
            ? List<ProductCategoryData>.from(json["productCategoryData"]
                .map((x) => ProductCategoryData.fromJson(x)))
            : List.empty(),
      );

  Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "response_error": responseError,
        "productCategoryData":
            List<dynamic>.from(productCategoryData.map((x) => x.toJson())),
      };
}

class ProductCategoryData extends ProductCategoryEntity {
  ProductCategoryData({
    this.productCategoryId,
    this.productCategoryCode,
    this.productCategoryName,
    this.content,
    this.status,
  }) : super(
            productCategoryName: productCategoryName,
            productIcon:
                StringUtils.mapProductCategoryToIcon(productCategoryCode),
            content: content,
            productTypeData: List());

  int productCategoryId;
  String productCategoryCode;
  String productCategoryName;
  String content;
  String status;

  factory ProductCategoryData.fromJson(Map<String, dynamic> json) =>
      ProductCategoryData(
        productCategoryId: json["productCategoryId"],
        productCategoryCode: json["productCategoryCode"],
        productCategoryName: json["productCategoryName"],
        content: json["content"] == null ? null : json["content"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "productCategoryId": productCategoryId,
        "productCategoryCode": productCategoryCode,
        "productCategoryName": productCategoryName,
        "content": content == null ? null : content,
        "status": status,
      };
}
