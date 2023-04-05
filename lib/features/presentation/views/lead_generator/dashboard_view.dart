import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/features/domain/entities/response/login_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/home/home_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/home/home_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/home/home_state.dart';
import 'package:ceylife_digital/features/presentation/common/app_data_provider.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_side_menu.dart';
import 'package:ceylife_digital/features/presentation/views/base_view.dart';
import 'package:ceylife_digital/utils/app_animation.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:ceylife_digital/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class LeadGeneratorDashboardView extends BaseView {
  @override
  _LeadGeneratorDashboardViewState createState() =>
      _LeadGeneratorDashboardViewState();
}

class _LeadGeneratorDashboardViewState
    extends BaseViewState<LeadGeneratorDashboardView> {
  final _bloc = injection<HomeBloc>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ProfileEntity _profile;

  @override
  void initState() {
    super.initState();
    _bloc.add(GetProfileDataEvent());
    context
        .read<AppDataProvider>()
        .updateCount(AppConstants.UNREAD_NOTIFICATION_COUNT);
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
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
            message: "Are you sure you want to log out?",
            positiveButtonText: "Yes",
            negativeButtonText: "No",
            onPositiveCallback: () {
              logout();
            },
          );
        },
        onSwitchTapped: () => showCeylifeDialog(
            title: 'You don’t have any policy',
            alertType: AlertType.FAIL,
            dialogContentWidget:
                Lottie.asset(AppAnimation.animFailed, repeat: false),
            message:
                'Sorry Nickname, You need to be a policyholder to switch this mode.  Do you wish to start a policy ?',
            negativeButtonText: 'May be Later',
            positiveButtonText: 'I Want To Start'),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Lead Generator Dashboard',
          style: TextStyle(color: AppColors.appBarTitle, fontSize: 18),
        ),
        leading: IconButton(
          onPressed: () {
            showCeylifeDialog(
                title: 'Switch Between Two Modes',
                positiveButtonText: 'Got It',
                alertType: AlertType.FAIL,
                dialogContentWidget: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Now you can access your policyholder\nfeatures and lead generator features\nwithout logging out.',
                        style: TextStyle(
                          color: AppColors.primaryBlackColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        '1. Access the side menu with the icon on the left upper corner.',
                        style: TextStyle(
                          color: AppColors.primaryBlackColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Image.asset(AppImages.imageTip1),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        '2. Then tap on the toggle switch to change the mode. Enjoy the app as a policyholder and as a lead generator.',
                        style: TextStyle(
                          color: AppColors.primaryBlackColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Image.asset(AppImages.imageTip2),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
                onPositiveCallback: () {
                  _scaffoldKey.currentState.openDrawer();
                });
          },
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
                        Navigator.pushNamed(context, Routes.NOTIFICATIONS_VIEW);
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
        create: (_) => _bloc,
        child: BlocListener<HomeBloc, BaseState<HomeState>>(
          cubit: _bloc,
          listener: (context, state) {
            if (state is ProfileDataLoadedState) {
              setState(() {
                _profile = state.profileEntity;
              });
            } else if (state is ProfileDataFailedState) {
              showCeylifeDialog(
                  title: AppLocalizations.of(context).translate('title_error'),
                  message: state.error,
                  onPositiveCallback: () {
                    AppConstants.IS_USER_LOGGED = false;
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        Routes.SPLASH_VIEW, (route) => false);
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
                Padding(
                  padding: const EdgeInsets.only(top: 200),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Welcome to',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 28,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Text(
                        'CeyLife Digital',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 42,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 31,
                      ),
                      Text(
                        'Lead Generator\nDashboard',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 28,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
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
    );
  }

  @override
  Bloc getBloc() => _bloc;
}
