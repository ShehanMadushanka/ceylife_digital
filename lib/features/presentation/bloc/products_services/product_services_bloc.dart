import 'package:ceylife_digital/core/network/network_config.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_product_categories.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_product_detail.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/products_services/product_services_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/products_services/product_services_status.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:huawei_map/constants/param.dart';

class ProductsBloc extends BaseBloc<ProductsEvent, BaseState<ProductsState>> {
  final UseCaseGetProductCategories useCaseGetProductCategories;
  final UseCaseGetProductDetail useCaseGetProductDetail;

  ProductsBloc({this.useCaseGetProductCategories, this.useCaseGetProductDetail})
      : super(InitialProductsState());

  @override
  Stream<BaseState<ProductsState>> mapEventToState(ProductsEvent event) async* {
    if (event is GetProductCategoriesEvent) {
      yield APILoadingState();
      final result = await useCaseGetProductCategories(Param());
      yield result.fold((l) {
        if (l is AuthorizedFailure) {
          if (AppConstants.IS_USER_LOGGED)
            return SessionExpireState();
          else
            return ProductsFailedState(
                error: ErrorMessages().mapFailureToMessage(l));
        } else
          return ProductsFailedState(
              error: ErrorMessages().mapFailureToMessage(l));
      }, (r) {
        if (r.responseCode == APIResponse.RESPONSE_SUCCESS)
          return ProductCategoriesLoadedState(productCategoryEntityResponse: r);
        else
          return ProductsFailedState(error: ErrorMessages().mapAPIErrorCode(r.responseCode, r.responseError));
      });
    } else if (event is GetProductDetailEvent) {
      yield APILoadingState();
      final result =
          await useCaseGetProductDetail(event.productDetailRequestEntity);
      yield result.fold((l) {
        if (l is AuthorizedFailure) {
          if (AppConstants.IS_USER_LOGGED)
            return SessionExpireState();
          else
            return ProductsFailedState(
                error: ErrorMessages().mapFailureToMessage(l));
        } else
          return ProductsFailedState(
              error: ErrorMessages().mapFailureToMessage(l));
      }, (r) {
        if (r.responseCode == APIResponse.RESPONSE_SUCCESS)
          return ProductDetailLoadedState(productDetailResponseEntity: r);
        else
          return ProductsFailedState(error: ErrorMessages().mapAPIErrorCode(r.responseCode, r.responseError));
      });
    }
  }
}
