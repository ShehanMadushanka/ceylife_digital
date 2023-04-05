// To parse this JSON data, do
//
//     final getProductDetailResponse = getProductDetailResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ceylife_digital/features/domain/entities/response/product_detail_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/product_type_data_entity.dart';

class GetProductDetailResponse extends GetProductDetailResponseEntity {
  GetProductDetailResponse({
    this.responseCode,
    this.responseError,
    this.productTypeData,
  }) : super(
            responseCode: responseCode,
            responseError: responseError,
            productTypeDataEntities: productTypeData);

  String responseCode;
  String responseError;
  List<ProductTypeData> productTypeData;

  factory GetProductDetailResponse.fromRawJson(String str) =>
      GetProductDetailResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetProductDetailResponse.fromJson(Map<String, dynamic> json) =>
      GetProductDetailResponse(
        responseCode: json["response_code"],
        responseError: json["response_error"],
        productTypeData: json["productTypeData"] != null
            ? List<ProductTypeData>.from(
                json["productTypeData"].map((x) => ProductTypeData.fromJson(x)))
            : List.empty(),
      );

  Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "response_error": responseError,
        "productTypeData":
            List<dynamic>.from(productTypeData.map((x) => x.toJson())),
      };
}

class ProductTypeData extends ProductTypeDataEntity {
  ProductTypeData({
    this.productTypeId,
    this.productTypeName,
    this.status,
    this.productDetailList,
  }) : super(productTypeName, productDetailList);

  int productTypeId;
  String productTypeName;
  String status;
  List<ProductDetailList> productDetailList;

  factory ProductTypeData.fromRawJson(String str) =>
      ProductTypeData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductTypeData.fromJson(Map<String, dynamic> json) =>
      ProductTypeData(
        productTypeId: json["productTypeId"],
        productTypeName: json["productTypeName"],
        status: json["status"],
        productDetailList: json["productDetailList"]!=null?List<ProductDetailList>.from(
            json["productDetailList"]
                .map((x) => ProductDetailList.fromJson(x))):List.empty(),
      );

  Map<String, dynamic> toJson() => {
        "productTypeId": productTypeId,
        "productTypeName": productTypeName,
        "status": status,
        "productDetailList":
            List<dynamic>.from(productDetailList.map((x) => x.toJson())),
      };
}

class ProductDetailList extends ProductDetailEntity {
  ProductDetailList({
    this.productId,
    this.productName,
    this.content,
    this.detailSummaryLink,
    this.brochureUrl,
    this.status,
  }) : super(productName, content, detailSummaryLink, brochureUrl);

  int productId;
  String productName;
  String content;
  String detailSummaryLink;
  String brochureUrl;
  String status;

  factory ProductDetailList.fromRawJson(String str) =>
      ProductDetailList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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
