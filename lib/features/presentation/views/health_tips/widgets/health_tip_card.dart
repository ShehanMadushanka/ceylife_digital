import 'dart:math' as math;

import 'package:ceylife_digital/features/domain/entities/response/health_tip_response_entity.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_icons_icons.dart';
import 'package:ceylife_digital/features/presentation/common/image_loading_indicator.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:flutter/material.dart';

class HealthTipCard extends StatelessWidget {
  final HealthTipEntity healthTipResponseEntity;

  HealthTipCard({this.healthTipResponseEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          healthTipResponseEntity.imageUrl != null
              ? Image.network(
                  healthTipResponseEntity.imageUrl,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) return child;
                    return ImageLoadingIndicator(
                        loadingProgress: loadingProgress);
                  },
                )
              : SizedBox.shrink(),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Text(healthTipResponseEntity.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.textColorMaroon,
                    fontWeight: FontWeight.w700,
                    fontSize: 18)),
          ),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Text(generateDescription(healthTipResponseEntity.content),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.textColorAshDark4,
                    fontWeight: FontWeight.w500,
                    fontSize: 12)),
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
    );
  }

  String generateDescription(String description) {
    if (description.length > 126)
      return "${description.substring(0, 126)}...";
    else
      return description;
  }
}
