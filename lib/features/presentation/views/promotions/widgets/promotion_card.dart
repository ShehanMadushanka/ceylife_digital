import 'dart:math' as math;

import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/features/domain/entities/response/promotion_response_entity.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_icons_icons.dart';
import 'package:ceylife_digital/features/presentation/common/image_loading_indicator.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:flutter/material.dart';

class PromotionCard extends StatelessWidget {
  final PromotionsEntity promotionsResponseEntity;
  final VoidCallback callback;

  PromotionCard({this.promotionsResponseEntity, this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        margin: EdgeInsets.only(bottom: 16, left: 16, right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(15),
              spreadRadius: 0,
              blurRadius: 10,
              offset: Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                promotionsResponseEntity.imageURL == null
                    ? SizedBox()
                    : Image.network(
                        promotionsResponseEntity.imageURL,
                        fit: BoxFit.fill,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) return child;
                          return ImageLoadingIndicator(
                              loadingProgress: loadingProgress);
                        },
                      ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    color: AppColors.appbarSecondary,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 6, bottom: 6, left: 8, right: 8),
                      child: Text(
                          ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_VALID_TILL, promotionsResponseEntity.validDate),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.appBarTitle,
                              fontWeight: FontWeight.w500,
                              fontSize: 12)),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(promotionsResponseEntity.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.textColorMaroon,
                      fontWeight: FontWeight.w700,
                      fontSize: 18)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                      AppLocalizations.of(context)
                          .translate("promotions_learn_more"),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.textColorAmber,
                          fontWeight: FontWeight.w500,
                          fontSize: 12)),
                  Transform.rotate(
                    angle: 270 * math.pi / 180,
                    child: Icon(
                      CeylifeIcons.ic_rounded_arrow_down,
                      color: AppColors.textColorAmber,
                      size: 25,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
