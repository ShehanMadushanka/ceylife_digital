import 'dart:io';

import 'package:ceylife_digital/features/presentation/common/ceylife_icons_icons.dart';
import 'package:ceylife_digital/features/presentation/views/pre_login_menu/widgets/menu_item.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PreLogin {
  final String key;
  final IconData icon;

  PreLogin(this.key, this.icon);
}

List<PreLogin> preLoginMenuItems = [
  PreLogin('pre_login_menu_promotions', CeylifeIcons.ic_promotions),
  PreLogin('pre_login_menu_news', CeylifeIcons.ic_news),
  PreLogin('pre_login_menu_products_services', CeylifeIcons.ic_products),
  PreLogin('pre_login_menu_buy_online', CeylifeIcons.ic_buy_online),
  PreLogin('pre_login_menu_faq', CeylifeIcons.ic_faq),
  PreLogin('pre_login_menu_contact_us', CeylifeIcons.ic_contact_us),
  PreLogin('pre_login_menu_health_tips', CeylifeIcons.ic_health_tips),
  PreLogin('pre_login_menu_branch_locator', CeylifeIcons.ic_branch_locator),
  PreLogin('pre_login_menu_rates', CeylifeIcons.ic_rates),
];

class PreLoginMenuView extends StatelessWidget {
  bool isFromHome;

  PreLoginMenuView(this.isFromHome);

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              elevation: 0,
              brightness: Brightness.light,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: Text(
                AppLocalizations.of(context).translate("menu_label"),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: AppColors.primaryHeadingTextColor,
                ),
              ),
            ),
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0, 1],
                  colors: [
                    Colors.white,
                    Color(0xffFBECEC),
                  ],
                ),
              ),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        primary: false,
                        padding: EdgeInsets.only(left: 5, right: 5, top: 120.h),
                        itemCount: preLoginMenuItems.length,
                        itemBuilder: _buildMenuItem,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.8,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                AppImages.closePreLogin,
                                color: AppColors.primaryBackgroundColor,
                                width: 24,
                                height: 24,
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                AppLocalizations.of(context)
                                    .translate("close_label"),
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                  color: AppColors.primaryHeadingTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        : SafeArea(
            top: false,
            left: false,
            right: false,
            bottom: false,
            minimum: EdgeInsets.only(bottom: 10),
            child: Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                elevation: 0,
                brightness: Brightness.light,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                centerTitle: true,
                title: Text(
                  AppLocalizations.of(context).translate("menu_label"),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: AppColors.primaryHeadingTextColor,
                  ),
                ),
              ),
              body: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0, 1],
                    colors: [
                      Colors.white,
                      Color(0xffFBECEC),
                    ],
                  ),
                ),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          primary: false,
                          padding:
                              EdgeInsets.only(left: 5, right: 5, top: 120.h),
                          itemCount: preLoginMenuItems.length,
                          itemBuilder: _buildMenuItem,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.8,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  AppImages.closePreLogin,
                                  color: AppColors.primaryBackgroundColor,
                                  width: 24,
                                  height: 24,
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  AppLocalizations.of(context)
                                      .translate("close_label"),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                    color: AppColors.primaryHeadingTextColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).translate("menu_label"),
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: AppColors.primaryHeadingTextColor,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0, 1],
            colors: [
              Colors.white,
              Color(0xffFBECEC),
            ],
          ),
        ),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  primary: false,
                  padding: EdgeInsets.only(left: 5, right: 5, top: 120.h),
                  itemCount: preLoginMenuItems.length,
                  itemBuilder: _buildMenuItem,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.8,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          AppImages.closePreLogin,
                          color: AppColors.primaryBackgroundColor,
                          width: 24,
                          height: 24,
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          AppLocalizations.of(context).translate("close_label"),
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            color: AppColors.primaryHeadingTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, Routes.PROMOTIONS_VIEW);
            break;
          case 1:
            Navigator.pushNamed(context, Routes.NEWS_VIEW);
            break;
          case 2:
            Navigator.pushNamed(context, Routes.PRODUCTS_SERVICES_VIEW);
            break;
          case 3:
            Navigator.pushNamed(context, Routes.BUY_ONLINE_VIEW);
            break;
          case 4:
            Navigator.pushNamed(context, Routes.FAQ_VIEW);
            break;
          case 5:
            Navigator.pushNamed(context, Routes.CONTACT_US_VIEW);
            break;
          case 6:
            Navigator.pushNamed(context, Routes.HEALTH_TIPS_VIEW,
                arguments: isFromHome);
            break;
          case 7:
            Navigator.pushNamed(context, Routes.BRANCH_VIEW);
            break;
          case 8:
            Navigator.pushNamed(context, Routes.RATES_VIEW);
            break;
        }
      },
      child: PreLoginMenuItem(
        menuItem: preLoginMenuItems[index],
        index: index,
      ),
    );
  }
}
