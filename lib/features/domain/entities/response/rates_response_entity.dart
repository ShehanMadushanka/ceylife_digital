// To parse this JSON data, do
//
//     final accumulationRateResponse = accumulationRateResponseFromJson(jsonString);

import 'package:ceylife_digital/features/domain/entities/response/product_category_entity.dart';
import 'package:equatable/equatable.dart';

class AccumulationRateResponseEntity extends Equatable {
  AccumulationRateResponseEntity({
    this.responseCode,
    this.responseError,
    this.rates,
  });

  String responseCode;
  String responseError;
  List<RateEntity> rates;

  @override
  List<Object> get props => [responseError, responseCode, rates];
}

class RateEntity extends Equatable {
  RateEntity({
    this.rateId,
    this.productCategory,
    this.rate,
    this.status,
    this.productType,
    this.createdTime
  });

  int rateId;
  ProductCategoryEntity productCategory;
  String rate;
  String status;
  String createdTime;
  ProductTypeEntity productType;

  @override
  List<Object> get props => [rateId, rate];
}

class ProductTypeEntity extends Equatable {
  ProductTypeEntity({
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

  @override
  List<Object> get props => [productId, productName];
}
