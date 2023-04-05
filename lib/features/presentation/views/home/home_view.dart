import 'dart:ui';

import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/features/domain/entities/response/login_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/policy_details_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/home/home_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/home/home_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/home/home_state.dart';
import 'package:ceylife_digital/features/presentation/common/app_data_provider.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_button.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_side_menu.dart';
import 'package:ceylife_digital/features/presentation/views/base_view.dart';
import 'package:ceylife_digital/features/presentation/views/common/data/otp_request_data.dart';
import 'package:ceylife_digital/features/presentation/views/common/data/otp_response_data.dart';
import 'package:ceylife_digital/features/presentation/views/home/widgets/policy_component.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:ceylife_digital/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:intl/intl.dart';

class HomeView extends BaseView {
  final List<PolicyDetailItemEntity> policies;

  HomeView({this.policies});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends BaseViewState<HomeView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final bloc = injection<HomeBloc>();
  List<PolicyDetailItemEntity> policies = List();
  PolicyDetailItemEntity _selectedPolicy;
  ProfileEntity _profile;
  DateTime currentBackPressTime;

  @override
  void initState() {
    super.initState();
    bloc.add(GetProfileDataEvent());
    context
        .read<AppDataProvider>()
        .updateCount(AppConstants.UNREAD_NOTIFICATION_COUNT);
  }

  @override
  Widget buildView(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        extendBodyBehindAppBar: true,
        drawer: CeylifeSideMenu(
          header: DrawerHeaderModel(
            profile: _profile,
            lastLogin: AppConstants.LAST_LOGIN,
            userName: _profile != null ? _profile.nickName : "",
          ),
          logout: () {
            Navigator.pop(context);
            showCeylifeDialog(
              title: AppLocalizations.of(context).translate('logout_title'),
              message:
                  AppLocalizations.of(context).translate('label_logout_desc'),
              positiveButtonText:
                  AppLocalizations.of(context).translate('button_label_yes'),
              negativeButtonText:
                  AppLocalizations.of(context).translate('button_label_no'),
              onPositiveCallback: () {
                logout();
              },
            );
          },
          onPasswordResetTapped: () {
            bloc.add(PasswordResetOtpRequestEvent());
          },
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context).translate("home_button_label"),
            style: TextStyle(color: AppColors.appBarTitle, fontSize: 18),
          ),
          leading: IconButton(
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
            icon: SvgPicture.asset(AppImages.icHomeMenu),
          ),
          actions: <Widget>[
            Stack(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    IconButton(
                        icon: SvgPicture.asset(AppImages.icNotificationBell,
                            fit: BoxFit.scaleDown),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, Routes.NOTIFICATIONS_VIEW);
                        }),
                    context.watch<AppDataProvider>().unReadNotificationCount > 0
                        ? Positioned(
                            right: 11,
                            top: 16,
                            child: Container(
                              padding: EdgeInsets.only(left: 2, top: 1),
                              decoration: BoxDecoration(
                                color: AppColors.notificationCountColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              constraints: BoxConstraints(
                                minWidth: 14,
                                minHeight: 14,
                              ),
                              child: Text(
                                '${context.watch<AppDataProvider>().unReadNotificationCount}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        : SizedBox.shrink()
                  ],
                ),
              ],
            ),
          ],
        ),
        body: BlocProvider<HomeBloc>(
          create: (_) => bloc,
          child: BlocListener<HomeBloc, BaseState<HomeState>>(
            cubit: bloc,
            listener: (context, state) {
              if (state is ProfileDataLoadedState) {
                if (widget.policies != null) {
                  policies.clear();
                  policies.addAll(widget.policies);
                  if (policies.isNotEmpty) _selectedPolicy = policies[0];
                  policies.add(PolicyDetailItemEntity(
                      policyStatusEnum: PolicyStatus.BUYONLINE));
                } else
                  bloc.add(GetPoliciesEvent());

                setState(() {
                  _profile = state.profileEntity;
                });
              } else if (state is ProfileDataFailedState) {
                showCeylifeDialog(
                    title:
                        AppLocalizations.of(context).translate('title_error'),
                    message: state.error,
                    onPositiveCallback: () {
                      AppConstants.IS_USER_LOGGED = false;
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          Routes.SPLASH_VIEW, (route) => false);
                    });
              } else if (state is PolicyLoadedState) {
                policies.clear();
                policies.addAll(state.policyDetailsResponseEntity.data);
                if (policies.isNotEmpty) _selectedPolicy = policies[0];
                policies.add(PolicyDetailItemEntity(
                    policyStatusEnum: PolicyStatus.BUYONLINE));
                setState(() {});
              } else if (state is PolicyLoadingFailedState) {
                showCeylifeDialog(
                    isSessionTimeout: true,
                    title:
                        AppLocalizations.of(context).translate('title_error'),
                    message: state.error,
                    positiveButtonText: AppLocalizations.of(context)
                        .translate('try_again_button_label'),
                    negativeButtonText: AppLocalizations.of(context)
                        .translate('cancel_button_label'),
                    onNegativeCallback: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, Routes.SPLASH_VIEW, (route) => false);
                    },
                    onPositiveCallback: () {
                      bloc.add(GetPoliciesEvent());
                    });
              } else if (state is PasswordResetOtpSuccessState) {
                Navigator.pushNamed(
                        context, Routes.COMMON_OTP_VERIFICATION_VIEW,
                        arguments: OTPRequestData(
                            keyType: 3,
                            otpReference:
                                state.passwordResetOtpResponseEntity.otpRef,
                            maskedEmail:
                                state.passwordResetOtpResponseEntity.email,
                            maskedMobile:
                                state.passwordResetOtpResponseEntity.mobileNo,
                            key: _profile.mobileUserId.toString(),
                            shouldHideProgress: true,
                            appBarTitle: AppLocalizations.of(context)
                                .translate("title_app_bar_password_reset")))
                    .then((otpResponseData) {
                  if (otpResponseData is OTPResponseData) {
                    if (otpResponseData.isVerificationSuccess) {
                      Navigator.pushNamed(context, Routes.PASSWORD_RESET_VIEW);
                    }
                  }
                });
              }
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff790013), Color(0xff370009)],
                ),
              ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(height: 100.h,),
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          physics: BouncingScrollPhysics(),
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              AppLocalizations.of(context)
                                  .translate("life_insurance_label"),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 35.h,
                            ),
                            SizedBox(
                              height: 330,
                              child: Swiper(
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return PolicyComponent(
                                      policyDetailItemEntity: policies[index]);
                                },
                                itemCount: policies.length,
                                pagination: policies.length == 1
                                    ? null
                                    : SwiperPagination(
                                        builder: DotSwiperPaginationBuilder(
                                          color: AppColors.inactiveIndicatorColor,
                                          activeColor: AppColors.activeIndicatorColor,
                                        ),
                                        margin: EdgeInsets.only(top: 20)),
                                viewportFraction: 0.7,
                                fade: 0.2,
                                loop: false,
                                scale: 0.8,
                                autoplay: false,
                                layout: SwiperLayout.DEFAULT,
                                onIndexChanged: (index) {
                                  setState(() {
                                    _selectedPolicy = policies[index];
                                  });
                                },
                                onTap: (index) {
                                  if (policies[index].policyStatusEnum ==
                                      PolicyStatus.BUYONLINE)
                                    Navigator.pushNamed(
                                        context, Routes.BUY_ONLINE_VIEW);
                                  else
                                    Navigator.pushNamed(
                                            context, Routes.POLICY_DETAILS_VIEW,
                                            arguments: policies[index]);
                                },
                              ),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            _selectedPolicy != null
                                ? _policyDescription(_selectedPolicy)
                                : SizedBox.shrink(),
                            SizedBox(
                              height: 70,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.PRE_LOGIN_MENU_VIEW,
                            arguments: true);
                      },
                      child: SizedBox(
                        width: 130,
                        height: 60,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            SvgPicture.asset(
                              AppImages.icMenuNew,
                              fit: BoxFit.fill,
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 6),
                                child: Text(AppLocalizations.of(context)
                                    .translate('menu_label'), style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.primaryHeadingTextColor,
                                    fontSize: 12
                                ),),
                              ),
                            )
                          ],
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
  }

  Widget _policyDescription(PolicyDetailItemEntity policyDetailItemEntity) {
    switch (policyDetailItemEntity.policyStatusEnum) {
      case PolicyStatus.ACTIVE:
      case PolicyStatus.LAPSED:
      case PolicyStatus.PAIDUP:
      case PolicyStatus.PROPOSAL:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context).translate("amount_due_label"),
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            Text.rich(
              TextSpan(
                  text: 'LKR  ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                  children: [
                    TextSpan(
                        text: NumberFormat.currency(symbol: '').format(
                          policyDetailItemEntity.totalDue,
                        ),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w500))
                  ]),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              ' ${AppLocalizations.of(context).translate("paid_up_date")} : ${policyDetailItemEntity.paidUpDate}',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.indianRedLightColor),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: CeyLifeButton(
                onTapButton: () {
                  Navigator.pushNamed(context, Routes.PAY_PREMIUM_VIEW,
                          arguments: _selectedPolicy);
                },
                buttonText:
                    AppLocalizations.of(context).translate("label_pay_now"),
              ),
            ),
          ],
        );
      case PolicyStatus.MATURED:
        return Text(
          AppLocalizations.of(context).translate("policy_matured_message"),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
        );
      case PolicyStatus.BUYONLINE:
        return Text(
          AppLocalizations.of(context).translate("purchase_insurance_message"),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
        );
    }
  }

  Future<bool> _onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      showCeylifeDialog(
        title: AppLocalizations.of(context).translate('logout_title'),
        message: AppLocalizations.of(context).translate('label_logout_desc'),
        positiveButtonText:
            AppLocalizations.of(context).translate('button_label_yes'),
        negativeButtonText:
            AppLocalizations.of(context).translate('button_label_no'),
        onPositiveCallback: () {
          logout();
        },
      );
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Bloc getBloc() {
    return bloc;
  }
}
