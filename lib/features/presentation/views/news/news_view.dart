import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/features/domain/entities/response/news_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/news/news_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/news/news_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/news/news_state.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_appbar.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_empty_view.dart';
import 'package:ceylife_digital/features/presentation/views/base_view.dart';
import 'package:ceylife_digital/features/presentation/views/news/widgets/ceylife_news_headline.dart';
import 'package:ceylife_digital/features/presentation/views/news/widgets/ceylife_news_item.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:ceylife_digital/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

List<CeylifeNewsEntity> news = List();

class NewsView extends BaseView {
  @override
  _NewsViewState createState() => _NewsViewState();
}

class _NewsViewState extends BaseViewState<NewsView> {
  final newsBloc = injection<NewsBloc>();
  bool isNewsLoaded = false;

  @override
  void initState() {
    super.initState();
    newsBloc.add(GetNewsEvent());
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CeylifeAppbar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context).translate("news_appbar_title"),
          style: TextStyle(color: AppColors.appBarTitle, fontSize: 18),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(AppImages.appBarBackIcon),
        ),
      ),
      body: BlocProvider<NewsBloc>(
        create: (_) => newsBloc,
        child: BlocListener<NewsBloc, BaseState<NewsState>>(
          cubit: newsBloc,
          listener: (context, state) {
            if (state is NewsLoadedState) {
              news.clear();
              news.addAll(state.newsResponseEntity.newsData);
              if (news.isNotEmpty) {
                try {
                  news.sort((b, a) => a.createdTime.compareTo(b.createdTime));
                  isNewsLoaded = true;
                  news[0].isHeadline = true;
                } catch (e) {
                }
              } else
                isNewsLoaded = false;
              setState(() {});
            } else if (state is NewsFailedState) {
              setState(() {
                isNewsLoaded = false;
              });
            }
          },
          child: isNewsLoaded
              ? Column(
                  children: [
                    news.length > 0
                        ? CeylifeNewsHeadline(
                            headline: news[0],
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Routes.NEWS_DETAIL_VIEW,
                                arguments: 0,
                              );
                            },
                          )
                        : SizedBox(),
                    news.length > 1
                        ? Expanded(
                            child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              padding: const EdgeInsets.all(16.0),
                              itemBuilder: (context, index) {
                                return CeylifeNewsItem(
                                  news: news[index + 1],
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, Routes.NEWS_DETAIL_VIEW,
                                        arguments: index + 1);
                                  },
                                );
                              },
                              itemCount: news.length - 1,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  height: 10,
                                );
                              },
                            ),
                          )
                        : SizedBox(),
                  ],
                )
              : CeylifeEmptyView(
                  status: EmptyStatus.NEWS,
                ),
        ),
      ),
    );
  }

  @override
  Bloc getBloc() {
    return newsBloc;
  }
}
