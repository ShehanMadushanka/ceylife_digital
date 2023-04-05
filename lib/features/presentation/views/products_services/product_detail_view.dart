import 'package:ceylife_digital/features/domain/entities/response/product_category_entity.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_appbar.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_empty_view.dart';
import 'package:ceylife_digital/features/presentation/common/expandable_text.dart';
import 'package:ceylife_digital/features/presentation/views/products_services/widgets/plan_item.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:ceylife_digital/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProductDetailView extends StatelessWidget {
  final ProductCategoryEntity product;

  const ProductDetailView({this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: product!=null?SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SvgPicture.asset(SVG_IMAGE_PATH + 'ceylife_logo' + SVG_TYPE),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.productCategoryName,
                      style: TextStyle(
                        color: AppColors.textColorMaroon,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 11,
                    ),
                    ExpandableText(
                      product.content,
                      expandText: '\n${AppLocalizations.of(context)
                          .translate("label_read_more")}',
                      collapseText: '\n${AppLocalizations.of(context)
                          .translate("label_read_less")}',
                      linkEllipsis: false,
                      maxLines: 5,
                      linkColor: AppColors.textColorAmber,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              _buildPlansView(context)
            ],
          ),
        ),
      ):CeylifeEmptyView(
        status: EmptyStatus.PRODUCT_DETAILS,
      ),
    );
  }

  _buildPlansView(BuildContext context) {
    List<Widget> plans = List();

    product.productTypeData.forEach((element) {
      plans.add(
        Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    element.productTypeName,
                    style: TextStyle(
                      color: AppColors.textColorMaroon,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1, color: AppColors.primaryBackgroundColor),
                    ),
                    child: Text(
                      '${element.productDetailEntityList != null ? element.productDetailEntityList.length : 0} ${AppLocalizations.of(context)
                          .translate("label_available")}',
                      style: TextStyle(
                        color: AppColors.primaryHeadingTextColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 130,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      element.productDetailEntityList[index]
                          .productCategoryName = product.productCategoryName;
                      Navigator.pushNamed(
                          context, Routes.PRODUCTS_SERVICES_PLAN_DETAIL_VIEW,
                          arguments: element.productDetailEntityList[index]);
                    },
                    child: PlanItem(
                        productDetail: element.productDetailEntityList[index]),
                  );
                },
                itemCount: element.productDetailEntityList.length,
              ),
            )
          ],
        ),
      );
      plans.add(SizedBox(
        height: 40,
      ));
    });

    return Column(
      children: plans,
    );
  }
}
