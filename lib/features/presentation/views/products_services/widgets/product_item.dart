import 'package:ceylife_digital/features/domain/entities/response/product_category_entity.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_icons_icons.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProductCategoryItem extends StatelessWidget {
  final ProductCategoryEntity product;

  const ProductCategoryItem({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x4D86504E),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: SvgPicture.asset(product.productIcon),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: AppColors.primaryBackgroundColor,
              padding: EdgeInsets.all(8),
              child: Center(
                child: Text.rich(
                  TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    text: product.productCategoryName,
                    children: [
                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 2.0, bottom: 2),
                          child: Icon(CeylifeIcons.ic_thick_arrow,
                              color: Colors.white, size: 12),
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
