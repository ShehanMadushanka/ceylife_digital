import 'package:ceylife_digital/features/domain/entities/response/product_type_data_entity.dart';
import 'package:equatable/equatable.dart';

class ProductCategoryEntityResponse extends Equatable {
  String responseCode;
  String responseError;
  List<ProductCategoryEntity> productCategoryDataResponse;

  ProductCategoryEntityResponse(
      {this.responseCode,
      this.responseError,
      this.productCategoryDataResponse});

  @override
  List<Object> get props =>
      [responseError, responseCode, productCategoryDataResponse];
}

class ProductCategoryEntity extends Equatable {
  final String productCategoryName;
  int productCategoryId;
  String productCategoryCode;
  String status;
  final String productIcon;
  final String content;
  final List<ProductTypeDataEntity> productTypeData;

  ProductCategoryEntity(
      {this.productCategoryName,
      this.productIcon,
      this.productTypeData,
      this.content,
      this.status,
      this.productCategoryId,
      this.productCategoryCode});

  @override
  List<Object> get props =>
      [productCategoryName, productCategoryId, productCategoryCode];
}
