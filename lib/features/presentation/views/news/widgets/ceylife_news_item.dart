import 'dart:math' as math;

import 'package:ceylife_digital/features/domain/entities/response/news_response_entity.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_icons_icons.dart';
import 'package:ceylife_digital/features/presentation/common/image_loading_indicator.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:flutter/material.dart';

class CeylifeNewsItem extends StatelessWidget {
  final CeylifeNewsEntity news;
  final VoidCallback onTap;

  const CeylifeNewsItem({Key key, this.news, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () => onTap(),
        child: Container(
          height: 150,
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: Color(0x4010111F), blurRadius: 4, offset: Offset(0, 0))
          ]),
          child: Stack(
            children: [
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  color: AppColors.newsItemButtonColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: Text(
                          AppLocalizations.of(context)
                              .translate("view_more_label"),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Hero(
                      tag: '${news.newsUpdateDetailsId}',
                      child: Container(
                        child: Image.network(
                          (news.thumbnail == null || news.thumbnail.isEmpty)
                              ? news.image
                              : news.thumbnail,
                          fit: BoxFit.fill,
                          height: 120,
                          width: 102,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent loadingProgress) {
                            if (loadingProgress == null) return child;
                            return ImageLoadingIndicator(
                                loadingProgress: loadingProgress);
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                news.newsTitle,
                                style: TextStyle(
                                  color: AppColors.primaryHeadingTextColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 4,
                                textAlign: TextAlign.start,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              news.dateTime,
                              style: TextStyle(
                                color: AppColors.newsItemDateTimeColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
