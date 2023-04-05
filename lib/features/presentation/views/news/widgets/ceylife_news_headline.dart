import 'dart:math' as math;

import 'package:ceylife_digital/features/domain/entities/response/news_response_entity.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_icons_icons.dart';
import 'package:ceylife_digital/features/presentation/common/image_loading_indicator.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:flutter/material.dart';

class CeylifeNewsHeadline extends StatelessWidget {
  final CeylifeNewsEntity headline;
  final VoidCallback onTap;

  const CeylifeNewsHeadline({Key key, this.headline, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () => onTap(),
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Color(0x8010111F), blurRadius: 8, offset: Offset(0, 1))
          ]),
          child: Stack(
            children: [
              Hero(
                tag: '${headline.newsTitle}',
                child: Image.network(
                  headline.image,
                  fit: BoxFit.fill,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) return child;
                    return ImageLoadingIndicator(
                        loadingProgress: loadingProgress);
                  },
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                      color: AppColors.newsHeadlineColor.withOpacity(0.9)),
                  child: Wrap(
                    runSpacing: 10,
                    runAlignment: WrapAlignment.spaceBetween,
                    children: [
                      Text(
                        headline.newsTitle,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            headline.dateTime,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 2.0),
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate("view_more_label"),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Transform.rotate(
                                angle: 270 * math.pi / 180,
                                child: Icon(
                                  CeylifeIcons.ic_rounded_arrow_down,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
