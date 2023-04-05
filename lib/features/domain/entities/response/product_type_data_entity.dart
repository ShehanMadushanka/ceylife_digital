import 'package:ceylife_digital/features/domain/entities/response/product_detail_entity.dart';
import 'package:equatable/equatable.dart';

class GetProductDetailResponseEntity extends Equatable {
  String responseCode;
  String responseError;
  List<ProductTypeDataEntity> productTypeDataEntities;

  GetProductDetailResponseEntity(
      {this.responseCode, this.responseError, this.productTypeDataEntities});

  @override
  List<Object> get props =>
      [responseCode, responseError, productTypeDataEntities];
}

class ProductTypeDataEntity extends Equatable {
  int productTypeId;
  final String productTypeName;
  String status;
  final List<ProductDetailEntity> productDetailEntityList;

  ProductTypeDataEntity(this.productTypeName, this.productDetailEntityList);

  @override
  List<Object> get props => [productTypeId, productTypeName];
}
