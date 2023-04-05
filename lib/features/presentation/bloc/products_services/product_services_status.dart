import 'package:ceylife_digital/features/domain/entities/response/product_category_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/product_type_data_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';

abstract class ProductsState extends BaseState<ProductsState> {}

class InitialProductsState extends ProductsState {}

class ProductCategoriesLoadedState extends ProductsState {
  final ProductCategoryEntityResponse productCategoryEntityResponse;

  ProductCategoriesLoadedState({this.productCategoryEntityResponse});
}

class ProductDetailLoadedState extends ProductsState {
  final GetProductDetailResponseEntity productDetailResponseEntity;

  ProductDetailLoadedState({this.productDetailResponseEntity});
}

class ProductsFailedState extends ProductsState {
  final String error;

  ProductsFailedState({this.error});
}
