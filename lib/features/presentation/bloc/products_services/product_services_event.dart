import 'package:ceylife_digital/features/domain/entities/request/production_detail_request_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_event.dart';

abstract class ProductsEvent extends BaseEvent {}

class GetProductCategoriesEvent extends ProductsEvent {}

class GetProductDetailEvent extends ProductsEvent {
  final ProductDetailRequestEntity productDetailRequestEntity;

  GetProductDetailEvent({this.productDetailRequestEntity});
}
