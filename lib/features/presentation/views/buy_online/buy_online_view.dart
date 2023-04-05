import 'dart:ui';

import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/buy_online/buy_online_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/buy_online/buy_online_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/buy_online/buy_online_state.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_appbar.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_icons_icons.dart';
import 'package:ceylife_digital/features/presentation/common/ui_consts.dart';
import 'package:ceylife_digital/features/presentation/views/base_view.dart';
import 'package:ceylife_digital/features/presentation/views/buy_online/buy_online_data.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class BuyOnlineView extends BaseView {
  @override
  _BuyOnlineViewState createState() => _BuyOnlineViewState();
}

class _BuyOnlineViewState extends BaseViewState<BuyOnlineView> {
  final bloc = injection<BuyOnlineBloc>();
  final List<BuyOnlineData> buyOnlineDataItems = List();

  @override
  void initState() {
    super.initState();
    bloc.add(GetBuyOnlineLinks());
  }

  @override
  Widget buildView(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = 240;
    final double itemWidth = (size.width) / 2;

    return Scaffold(
      appBar: CeylifeAppbar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context).translate('buy_online_appbar_title'),
          style: TextStyle(
              color: AppColors.appBarTitle,
              fontSize: 18,
              fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(AppImages.appBarBackIcon),
        ),
      ),
      body: BlocProvider<BuyOnlineBloc>(
        create: (_) => bloc,
        child: BlocListener<BuyOnlineBloc, BaseState<BuyOnlineState>>(
          cubit: bloc,
          listener: (context, state) {
            if (state is BuyOnlineLinkLoaded) {
              state.configurationData.buyOnlineWebLinks.forEach((element) {
                switch (element.code) {
                  case BUY_ONLINE_LIFE_INSURANCE:
                    buyOnlineDataItems.add(BuyOnlineData(
                        AppLocalizations.of(context)
                            .translate('button_label_life_insurance'),
                        "ic_life",
                        element.link));
                    break;
                  case BUY_ONLINE_CUSTOMIZED_LIFE:
                    buyOnlineDataItems.add(BuyOnlineData(
                        AppLocalizations.of(context)
                            .translate('button_label_custom_insurance'),
                        "ic_customized_life",
                        element.link));
                    break;
                  case BUY_ONLINE_RETIREMENT:
                    buyOnlineDataItems.add(BuyOnlineData(
                        AppLocalizations.of(context)
                            .translate('button_label_retirement_plan'),
                        "ic_retirement",
                        element.link));
                    break;
                  case BUY_ONLINE_INVESTMENT:
                    buyOnlineDataItems.add(BuyOnlineData(
                        AppLocalizations.of(context)
                            .translate('button_label_investment_plan'),
                        "ic_investment",
                        element.link));
                    break;
                }

                setState(() {});
              });
            }
          },
          child: Container(
            decoration: BoxDecoration(gradient: kBackgroundGradient),
            height: MediaQuery.of(context).size.height,
            child: ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: 25,
                ),
                SvgPicture.asset(SVG_IMAGE_PATH + 'ceylife_logo' + SVG_TYPE,
                    height: 100, width: 50),
                SizedBox(
                  height: 15,
                ),
                Text(
                  AppLocalizations.of(context)
                      .translate('get_help_label'),
                  style: TextStyle(
                    color: AppColors.textColorMaroon,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  primary: false,
                  itemCount: 4,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(30),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 30,
                    childAspectRatio: (itemWidth / itemHeight),
                    mainAxisSpacing: 30,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return new Card(
                      child: new InkWell(
                        onTap: () => launch(buyOnlineDataItems[index].web_url, enableJavaScript: false),
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                flex: AppConstants.APP_LANGUAGE ==
                                        Languages.ENGLISH
                                    ? 2
                                    : 3,
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
                                  child: buyOnlineDataItems.isNotEmpty
                                      ? SvgPicture.asset(
                                          SVG_IMAGE_PATH +
                                              buyOnlineDataItems[index]
                                                  .cardimage +
                                              SVG_TYPE,
                                          height: 500,
                                          width: 300)
                                      : SizedBox.shrink(),
                                ),
                              ),
                              Expanded(
                                flex: AppConstants.APP_LANGUAGE ==
                                        Languages.ENGLISH
                                    ? 1
                                    : 2,
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
                                        text: buyOnlineDataItems.isNotEmpty
                                            ? buyOnlineDataItems[index].cardname
                                            : '',
                                        children: [
                                          WidgetSpan(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 2.0, bottom: 2),
                                              child: Icon(
                                                  CeylifeIcons.ic_thick_arrow,
                                                  color: Colors.white,
                                                  size: 8),
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
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Bloc getBloc() {
    return bloc;
  }
}
