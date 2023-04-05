import 'dart:math' as math;

import 'package:ceylife_digital/features/domain/entities/response/rates_response_entity.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_icons_icons.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:flutter/material.dart';

class RateExpandedItem extends StatelessWidget {
  final int index;
  final RateEntity rateEntity;
  final VoidCallback onTap;

  const RateExpandedItem({Key key, this.index, this.rateEntity, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _backgroundColor = index % 2 != 0
        ? AppColors.appHighlightColor.withOpacity(0.14)
        : AppColors.indianRedLightColor.withOpacity(0.57);

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        color: _backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              CEYLINCO_LIFE +
                  ' ' +
                  (rateEntity.productType != null
                      ? rateEntity.productType.productName
                      : ''),
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.start,
              maxLines: 2,
            ),
            Row(
              children: [
                Text(
                  rateEntity.rate != null ? rateEntity.rate + "%" : '',
                  softWrap: true,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textColorMaroon,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(width: 5),
                Transform.rotate(
                  angle: 270 * math.pi / 180,
                  child: Icon(
                    CeylifeIcons.ic_rounded_arrow_down,
                    color: AppColors.textColorAmber,
                    size: 20,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
