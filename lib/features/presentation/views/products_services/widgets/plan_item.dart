import 'package:ceylife_digital/features/domain/entities/response/product_detail_entity.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:flutter/material.dart';

class PlanItem extends StatelessWidget {
  final ProductDetailEntity productDetail;

  const PlanItem({this.productDetail});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(7),
        height: 80,
        width: 150,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            end: Alignment.centerRight,
            begin: Alignment.centerLeft,
            colors: [AppColors.primaryBackgroundColor, Color(0xff631829)],
            stops: [0.2, 1],
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xffD4A5A6), width: 1),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Ceylinco Life',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
                Text(
                  productDetail.productName,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
