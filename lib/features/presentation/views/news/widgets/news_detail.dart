import 'package:ceylife_digital/features/domain/entities/response/news_response_entity.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_icons_icons.dart';
import 'package:ceylife_digital/features/presentation/common/image_loading_indicator.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:flutter/material.dart';

class NewsDetail extends StatelessWidget {
  final CeylifeNewsEntity news;

  const NewsDetail({Key key, this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 17),
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Color(0x40000000), blurRadius: 6)],
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    news.newsTitle,
                    style: TextStyle(
                        color: AppColors.primaryHeadingTextColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 12),
                  child: Row(
                    children: [
                      Icon(Icons.access_time,
                          size: 12, color: AppColors.newsItemDateTimeColor),
                      SizedBox(width: 4),
                      Text(
                        news.dateTime,
                        style: TextStyle(
                            color: AppColors.newsItemDateTimeColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 12),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Hero(
                  tag: '${news.newsUpdateDetailsId}',
                  child: Image.network(
                    news.image,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return ImageLoadingIndicator(
                          loadingProgress: loadingProgress);
                    },
                  ),
                ),
                SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Text(
                    news.newsDescription,
                    style: TextStyle(
                        color: AppColors.primaryAshColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
