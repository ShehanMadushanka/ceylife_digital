import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/features/presentation/bloc/health_tips/health_tips_bloc.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_appbar.dart';
import 'package:ceylife_digital/features/presentation/views/base_view.dart';
import 'package:ceylife_digital/features/presentation/views/health_tips/widgets/health_detail.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'health_tip_view.dart';

// ignore: must_be_immutable
class HealthTipsDetailView extends BaseView {
  int index;

  HealthTipsDetailView(this.index);

  @override
  _HealthTipsDetailViewState createState() => _HealthTipsDetailViewState(index);
}

class _HealthTipsDetailViewState extends BaseViewState<HealthTipsDetailView> {
  final bloc = injection<HealthTipsBloc>();
  PageController controller;
  int index;

  _HealthTipsDetailViewState(this.index);

  @override
  void initState() {
    controller = PageController(initialPage: index, viewportFraction: 1);
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CeylifeAppbar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)
              .translate("health_tips_detail_appbar_title"),
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
              controller: controller,
              children: _generateHealthTipsList(),
            ),
          ),
          _pageIndicator(context)
        ],
      ),
    );
  }

  List<HealthDetail> _generateHealthTipsList() {
    List<HealthDetail> healthTips = List();

    filteredHealthTips.forEach((element) {
      healthTips.add(HealthDetail(healthTip: element));
    });

    return healthTips;
  }

  Widget _pageIndicator(BuildContext context) {
    return Container(
      height: 34,
      width: MediaQuery.of(context).size.width,
      /*decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x26000000),
            offset: Offset(0, -2),
            blurRadius: 4,
          )
        ],
      ),*/
      child: Center(
        child: SmoothPageIndicator(
          controller: controller,
          count: filteredHealthTips.length,
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

  @override
  Bloc getBloc() {
    return bloc;
  }
}
