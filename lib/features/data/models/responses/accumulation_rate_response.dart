// To parse this JSON data, do
//
//     final accumulationRateResponse = accumulationRateResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ceylife_digital/features/domain/entities/response/product_category_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/rates_response_entity.dart';

class AccumulationRateResponse extends AccumulationRateResponseEntity {
  AccumulationRateResponse({
    this.responseCode,
    this.responseError,
    this.ratesObj,
  }) : super(
            rates: ratesObj,
            responseError: responseError,
            responseCode: responseCode);

  String responseCode;
  String responseError;
  List<Rate> ratesObj;

  factory AccumulationRateResponse.fromRawJson(String str) =>
      AccumulationRateResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AccumulationRateResponse.fromJson(Map<String, dynamic> json) =>
      AccumulationRateResponse(
        responseCode: json["response_code"],
        responseError: json["response_error"],
        ratesObj: json["rates"] != null
            ? List<Rate>.from(json["rates"].map((x) => Rate.fromJson(x)))
            : List.empty(),
      );

  Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "response_error": responseError,
        "rates": List<dynamic>.from(ratesObj.map((x) => x.toJson())),
      };
}

class Rate extends RateEntity {
  Rate({
    this.rateId,
    this.productCategoryObj,
    this.rate,
    this.status,
    this.productTypeObj,
  }) : super(
            status: status,
            rateId: rateId,
            rate: rate,
            productType: productTypeObj,
            productCategory: productCategoryObj);

  int rateId;
  ProductCategory productCategoryObj;
  String rate;
  String status;
  ProductType productTypeObj;

  factory Rate.fromRawJson(String str) => Rate.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Rate.fromJson(Map<String, dynamic> json) => Rate(
        rateId: json["rateId"],
        productCategoryObj: json["productCategory"] != null
            ? ProductCategory.fromJson(json["productCategory"])
            : ProductCategory(),
        rate: json["rate"],
        status: json["status"],
        productTypeObj: json["productDetail"] != null
            ? ProductType.fromJson(json["productDetail"])
            : ProductType(),
      );

  Map<String, dynamic> toJson() => {
        "rateId": rateId,
        "productCategory": productCategoryObj.toJson(),
        "rate": rate,
        "status": status,
        "productDetail": productTypeObj.toJson(),
      };
}

class ProductCategory extends ProductCategoryEntity {
  ProductCategory({
    this.productCategoryId,
    this.productCategoryCode,
    this.productCategoryName,
    this.content,
    this.status,
  }) : super(
            content: content,
            productCategoryName: productCategoryName,
            status: status,
            productCategoryId: productCategoryId,
            productCategoryCode: productCategoryCode);

  int productCategoryId;
  String productCategoryCode;
  String productCategoryName;
  String content;
  String status;

  factory ProductCategory.fromRawJson(String str) =>
      ProductCategory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      ProductCategory(
        productCategoryId: json["productCategoryId"],
        productCategoryCode: json["productCategoryCode"],
        productCategoryName: json["productCategoryName"],
        content: json["content"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "productCategoryId": productCategoryId,
        "productCategoryCode": productCategoryCode,
        "productCategoryName": productCategoryName,
        "content": content,
        "status": status,
      };
}

class ProductType extends ProductTypeEntity {
  ProductType({
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
  String detailSummaryLink;
  String brochureUrl;
  String status;

  factory ProductType.fromRawJson(String str) =>
      ProductType.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductType.fromJson(Map<String, dynamic> json) => ProductType(
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
