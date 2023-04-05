import 'dart:ui';

import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/features/domain/entities/request/production_detail_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/product_category_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/products_services/product_services_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/products_services/product_services_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/products_services/product_services_status.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_appbar.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_primary_button.dart';
import 'package:ceylife_digital/features/presentation/common/ui_consts.dart';
import 'package:ceylife_digital/features/presentation/views/base_view.dart';
import 'package:ceylife_digital/features/presentation/views/products_services/widgets/product_item.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:ceylife_digital/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

const String BUY_NOW = 'https://www.ceylincolife.com/buy-online/';

class ProductsServicesView extends BaseView {
  @override
  _ProductsServicesViewState createState() => _ProductsServicesViewState();
}

class _ProductsServicesViewState extends BaseViewState<ProductsServicesView> {
  final bloc = injection<ProductsBloc>();
  List<ProductCategoryEntity> products = List();
  ProductCategoryEntity selectedProduct;

  @override
  void initState() {
    super.initState();
    bloc.add(GetProductCategoriesEvent());
  }

  @override
  Widget buildView(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = 280;
    final double itemWidth = (size.width) / 2;

    return Scaffold(
      appBar: CeylifeAppbar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)
              .translate("products_services_appbar_title"),
          style: TextStyle(color: AppColors.appBarTitle, fontSize: 18),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(AppImages.appBarBackIcon),
        ),
      ),
      body: BlocProvider<ProductsBloc>(
        create: (_) => bloc,
        child: BlocListener<ProductsBloc, BaseState<ProductsState>>(
          cubit: bloc,
          listener: (context, state) {
            if (state is ProductCategoriesLoadedState) {
              products.clear();
              products.addAll(state
                  .productCategoryEntityResponse.productCategoryDataResponse);
              setState(() {});
            } else if (state is ProductDetailLoadedState) {
              selectedProduct.productTypeData.clear();
              if (state.productDetailResponseEntity.productTypeDataEntities
                      .length ==
                  0)
                Navigator.pushNamed(
                    context, Routes.PRODUCTS_SERVICES_DETAIL_VIEW,
                    arguments: null);
              else {
                selectedProduct.productTypeData.addAll(
                    state.productDetailResponseEntity.productTypeDataEntities);
                Navigator.pushNamed(
                    context, Routes.PRODUCTS_SERVICES_DETAIL_VIEW,
                    arguments: selectedProduct);
              }
            } else if (state is ProductsFailedState) {
              showCeylifeDialog(
                  title: AppLocalizations.of(context).translate('title_error'),
                  message: state.error,
                  onPositiveCallback: () {
                    Navigator.pop(context);
                  });
            } else if (state is InitialProductsState) {}
          },
          child: Container(
            decoration: BoxDecoration(
              gradient: kBackgroundGradient,
            ),
            child: Stack(
              children: [
                Container(
                  child: ListView(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    children: [
                      SvgPicture.asset(
                          SVG_IMAGE_PATH + 'ceylife_logo' + SVG_TYPE),
                      GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        primary: false,
                        itemCount: products.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(30),
                        itemBuilder: _buildCategoryItems,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 30,
                          childAspectRatio: (itemWidth / itemHeight),
                          mainAxisSpacing: 30,
                          crossAxisCount: 2,
                        ),
                      ),
                      SizedBox(height: 80)
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: new ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                      child: Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                        ),
                        child: Wrap(
                          direction: Axis.vertical,
                          runAlignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            SizedBox(height: 9),
                            Text(
                              AppLocalizations.of(context)
                                  .translate('products_services_bottom_label'),
                              style: TextStyle(
                                color: AppColors.primaryBlackColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 8),
                            CeylifePrimaryButton(
                              buttonLabel: AppLocalizations.of(context)
                                  .translate(
                                      'products_services_buy_now_button_label'),
                              onTap: () => launch(BUY_NOW, enableJavaScript: false),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryItems(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        selectedProduct = products[index];
        bloc.add(
          GetProductDetailEvent(
            productDetailRequestEntity: ProductDetailRequestEntity(
              categoryCode: selectedProduct.productCategoryCode,
            ),
          ),
        );
      },
      child: ProductCategoryItem(product: products[index]),
    );
  }

  @override
  Bloc getBloc() {
    return bloc;
  }
}
