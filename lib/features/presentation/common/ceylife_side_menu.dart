import 'dart:ui';

import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/features/domain/entities/response/login_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/home/home_bloc.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_icons_icons.dart';
import 'package:ceylife_digital/features/presentation/common/drawer_header.dart';
import 'package:ceylife_digital/features/presentation/common/drawer_tile.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

List<DrawerTile> _postLoginDrawerList = List();

const List<DrawerTile> _leadGeneratorDrawerList = [
  DrawerTile(
      drawerItem: DrawerItem.FEATURE1, icon: CeylifeIcons.ic_payment_history),
  DrawerTile(
      drawerItem: DrawerItem.FEATURE2, icon: CeylifeIcons.ic_customer_request),
  DrawerTile(drawerItem: DrawerItem.SETTINGS, icon: CeylifeIcons.ic_settings),
];

class CeylifeSideMenu extends StatefulWidget {
  final VoidCallback logout;
  final DrawerHeaderModel header;
  final VoidCallback onSwitchTapped;
  final VoidCallback onPasswordResetTapped;

  CeylifeSideMenu({Key key, this.logout, this.header, this.onSwitchTapped, this.onPasswordResetTapped})
      : super(key: key);

  @override
  _CeylifeSideMenuState createState() => _CeylifeSideMenuState();
}

class _CeylifeSideMenuState extends State<CeylifeSideMenu> {
  final _bloc = injection<HomeBloc>();

  bool _mode = false;
  bool _isEnabled = false;

  @override
  void initState() {
    super.initState();
    // initMode();
    initPostLoginDrawerList();
  }

  initMode() async {
    final cacheUser = await _bloc.appSharedData.getCacheUser();
    _mode = cacheUser.isLeadGenerator;
  }

  initPostLoginDrawerList(){
    _postLoginDrawerList.clear();
    _postLoginDrawerList.addAll([
      DrawerTile(
          drawerItem: DrawerItem.PAYMENT_HISTORY,
          icon: CeylifeIcons.ic_payment_history),
      DrawerTile(
          drawerItem: DrawerItem.CUSTOMER_SERVICE_REQUEST,
          icon: CeylifeIcons.ic_customer_request),
      DrawerTile(drawerItem: DrawerItem.SETTINGS, icon: CeylifeIcons.ic_settings),
      DrawerTile(drawerItem: DrawerItem.PASSWORD_RESET, icon: CeylifeIcons.ic_password_reset, callback: widget.onPasswordResetTapped,),
      DrawerTile(
          drawerItem: DrawerItem.BRANCH_LOCATOR,
          icon: CeylifeIcons.ic_branch_locator),
      DrawerTile(
          drawerItem: DrawerItem.CONTACT_US, icon: CeylifeIcons.ic_contact_us),
      DrawerTile(drawerItem: DrawerItem.FAQ, icon: CeylifeIcons.ic_faq),
      DrawerTile(drawerItem: DrawerItem.LANGUAGE_SELECTION, icon: Icons.language_sharp),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
        return BackdropFilter(
          key: widget.key,
          filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            child: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors.transparent,
              ),
              child: Drawer(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryBackgroundColor.withOpacity(0.8),
                        Color(0xFF5F101E).withOpacity(0.8)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0, 1],
                    ),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 30, bottom: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            CeylifeDrawerHeader(
                              profile: widget.header.profile,
                              lastLogin: widget.header.lastLogin,
                              userName: widget.header.userName,
                            ),
                            /* Container(
                              height: 65,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: AppColors.inactiveIndicatorColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xC95F101E),
                                      offset: Offset(0, 43),
                                      blurRadius: 60,
                                    ),
                                  ]),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Lead Generator Mode',
                                        style: TextStyle(
                                          color:
                                              AppColors.primaryHeadingTextColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      Text(
                                        _mode
                                            ? 'Turn off to switch Policyholder Mode'
                                            : 'Turn on to switch Lead Generator Mode',
                                        style: TextStyle(
                                          color: AppColors.textColorAmber,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                  CeylifeSwitch(
                                    value: _mode != null ? _mode : true,
                                    borderRadius: 30.0,
                                    width: 53,
                                    height: 26,
                                    isEnabled: _isEnabled,
                                    toggleColor: _isEnabled
                                        ? AppColors.redwoodOne
                                        : Color(0xFF92858B),
                                    inactiveColor: Colors.white,
                                    activeColor: _isEnabled
                                        ? AppColors.appHighlightColor
                                        : Color(0xFFA8AAAD).withOpacity(0.40),
                                    activeText: 'ON',
                                    inactiveText: 'OFF',
                                    inactiveTextColor:
                                        AppColors.textColorMaroon,
                                    inactiveTextFontWeight: FontWeight.w400,
                                    activeTextFontWeight: FontWeight.w400,
                                    activeTextColor: _isEnabled
                                        ? Colors.white
                                        : AppColors.primaryBlackColor
                                            .withOpacity(0.40),
                                    valueFontSize: 11,
                                    padding: 0,
                                    showOnOff: true,
                                    toggleSize: 26,
                                    onToggle: (val) {
                                      if (_isEnabled) {
                                        setState(() {
                                          _mode = val;
                                        });
                                        Future.delayed(
                                                Duration(milliseconds: 300))
                                            .then((value) {
                                          Navigator.pop(context);
                                          Navigator.pushNamed(
                                              context, Routes.SWITCH_VIEW,
                                              arguments: _mode);
                                        });
                                      } else {
                                        if (widget.onSwitchTapped != null)
                                          widget.onSwitchTapped();
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),*/
                            SizedBox(height: 10),
                            Expanded(
                              child: ListView.builder(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                itemCount: _mode
                                    ? _leadGeneratorDrawerList.length
                                    : _postLoginDrawerList.length,
                                itemBuilder: (context, index) {
                                  return _mode
                                      ? _leadGeneratorDrawerList[index]
                                      : _postLoginDrawerList[index];
                                },
                                physics: BouncingScrollPhysics(),
                              ),
                            ),
                            SizedBox(height: 65,)
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          child: ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: widget.logout,
                                    child: Container(
                                      height: 45,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.zero,
                                          color: AppColors.buttonDisabledColor
                                              .withOpacity(0.8)),
                                      child: Center(
                                        child: Text(
                                          AppLocalizations.of(context).translate("label_logout"),
                                          style: TextStyle(
                                              color: AppColors.appbarPrimary,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    snapshot.hasData
                                        ? 'version ${snapshot.data.version}'
                                        : '',
                                    style: TextStyle(
                                        color: AppColors.textColorRedwood,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      future: PackageInfo.fromPlatform(),
    );
  }
}

class DrawerHeaderModel {
  final String userName;
  final String lastLogin;
  final ProfileEntity profile;

  DrawerHeaderModel({this.userName, this.lastLogin, this.profile});
}
