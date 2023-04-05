// To parse this JSON data, do
//
//     final getProductDetailsResponse = getProductDetailsResponseFromJson(jsonString);

import 'dart:convert';

GetProductDetailsResponse getProductDetailsResponseFromJson(String str) =>
    GetProductDetailsResponse.fromJson(json.decode(str));

String getProductDetailsResponseToJson(GetProductDetailsResponse data) =>
    json.encode(data.toJson());

class GetProductDetailsResponse {
  GetProductDetailsResponse({
    this.responseCode,
    this.responseError,
    this.productTypeData,
  });

  String responseCode;
  String responseError;
  List<ProductTypeDatum> productTypeData;

  factory GetProductDetailsResponse.fromJson(Map<String, dynamic> json) =>
      GetProductDetailsResponse(
        responseCode: json["response_code"],
        responseError: json["response_error"],
        productTypeData: json["productTypeData"] != null
            ? List<ProductTypeDatum>.from(json["productTypeData"]
                .map((x) => ProductTypeDatum.fromJson(x)))
            : List.empty(),
      );

  Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "response_error": responseError,
        "productTypeData":
            List<dynamic>.from(productTypeData.map((x) => x.toJson())),
      };
}

class ProductTypeDatum {
  ProductTypeDatum({
    this.productTypeId,
    this.productTypeName,
    this.status,
    this.productDetailList,
  });

  int productTypeId;
  String productTypeName;
  String status;
  List<ProductDetailList> productDetailList;

  factory ProductTypeDatum.fromJson(Map<String, dynamic> json) =>
      ProductTypeDatum(
        productTypeId: json["productTypeId"],
        productTypeName: json["productTypeName"],
        status: json["status"],
        productDetailList: json["productDetailList"] != null
            ? List<ProductDetailList>.from(json["productDetailList"]
                .map((x) => ProductDetailList.fromJson(x)))
            : List.empty(),
      );

  Map<String, dynamic> toJson() => {
        "productTypeId": productTypeId,
        "productTypeName": productTypeName,
        "status": status,
        "productDetailList":
            List<dynamic>.from(productDetailList.map((x) => x.toJson())),
      };
}

class ProductDetailList {
  ProductDetailList({
    this.productId,
    this.productName,
    this.content,
    this.detailSummaryLink,
    this.brochureUrl,
    this.status,
  });

  int productId;
  String productName;
  String content;
  dynamic detailSummaryLink;
  dynamic brochureUrl;
  String status;

  factory ProductDetailList.fromJson(Map<String, dynamic> json) =>
      ProductDetailList(
        productId: json["productId"],
        productName: json["productName"],
        content: json["content"],
        detailSummaryLink: json["detailSummaryLink"],
        brochureUrl: json["brochureUrl"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "productName": productName,
        "content": content,
        "detailSummaryLink": detailSummaryLink,
        "brochureUrl": brochureUrl,
        "status": status,
      };
}
