import 'package:ceylife_digital/features/presentation/common/ceylife_appbar.dart';
import 'package:ceylife_digital/features/presentation/views/news/widgets/news_detail.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'news_view.dart';

// ignore: must_be_immutable
class NewsDetailView extends StatefulWidget {
  int index;
  PageController controller;

  NewsDetailView(this.index) {
    controller = PageController(initialPage: index, viewportFraction: 1);
  }

  @override
  _NewsDetailViewState createState() => _NewsDetailViewState();
}

class _NewsDetailViewState extends State<NewsDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CeylifeAppbar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context).translate("news_detail_appbar_title"),
          style: TextStyle(color: AppColors.appBarTitle, fontSize: 18),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(AppImages.appBarBackIcon),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: PageView(
              controller: widget.controller,
              children: _generateNewsList(),
            ),
          ),
          _pageIndicator(context)
        ],
      ),
    );
  }

  List<NewsDetail> _generateNewsList() {
    List<NewsDetail> newsList = List();

    news.forEach((element) {
      newsList.add(NewsDetail(news: element));
    });

    return newsList;
  }

  Widget _pageIndicator(BuildContext context) {
    return Container(
      height: 34,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x26000000),
            offset: Offset(0, -2),
            blurRadius: 4,
          )
        ],
      ),
      child: Center(
        child: SmoothPageIndicator(
          controller: widget.controller,
          count: news.length,
          effect: ScaleEffect(
            activeDotColor: AppColors.activeIndicatorColor,
            dotColor: AppColors.inactiveIndicatorColor,
            dotHeight: 8,
            dotWidth: 8,
            scale: 1.5,
          ),
        ),
      ),
    );
  }
}
