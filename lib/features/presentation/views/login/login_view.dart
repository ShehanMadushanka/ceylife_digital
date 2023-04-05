import 'dart:io';
import 'dart:ui';

import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/features/domain/entities/response/login_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/login/login_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/login/login_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/login/login_state.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_button.dart';
import 'package:ceylife_digital/features/presentation/common/ceylinco_edit_text_field.dart';
import 'package:ceylife_digital/features/presentation/views/base_view.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/device_info.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:ceylife_digital/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginView extends BaseView {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends BaseViewState<LoginView>
    with TickerProviderStateMixin {
  final loginBloc = injection<LoginBloc>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  DeviceInfo _deviceInfo;
  String _username = "";
  ProfileEntity _profile;
  bool _isBiometricEnrolled = false;
  bool _isBiometricEnabled = false;
  bool _isInitialBiometricPrompted = false;
  Biometric _biometricType = Biometric.NONE;

  @override
  void initState() {
    super.initState();
    initDeviceInfo();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  initDeviceInfo() async {
    _deviceInfo = DeviceInfo();
    _deviceInfo.initDeviceInfo();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    biometricServices.isEnrolled().then((enrolled) {
      setState(() {
        _isBiometricEnrolled = enrolled;
      });
    });

    setState(() {
      _isBiometricEnabled = AppConstants.IS_BIOMETRIC_ENABLED;
    });

    biometricServices.getAvailableType().then((value) {
      setState(() {
        _biometricType = value;
      });
    });

    loginBloc.add(GetCacheUser());
  }

  @override
  Widget buildView(BuildContext context) {
    if (!_isInitialBiometricPrompted) {
      if (_isBiometricEnrolled && _isBiometricEnabled) {
        biometricServices.authenticate().then((success) {
          _isInitialBiometricPrompted = true;
          if (success) {
            loginBloc.add(GetLoginEvent(
                signInType: SignInType.BIOMETRIC, deviceInfo: _deviceInfo));
          }
        });
      }
    }
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocProvider(
          create: (_) => loginBloc,
          child: BlocListener<LoginBloc, BaseState<LoginState>>(
            cubit: loginBloc,
            listener: (context, state) async {
              if (state is CacheUserSuccessState) {
                if (state.user != null &&
                    state.user.username != null &&
                    state.user.username.isNotEmpty) {
                  setState(() {
                    _profile = state.user;
                    _username = state.user.username;
                  });
                }
              } else if (state is LoginLoadedState) {
                await loginBloc.appSharedData.setCacheUser(
                    mobileUserId: state.loginResponseEntity.mobileUserId,
                    nickname: state.loginResponseEntity.profile.nickName,
                    profileImage:
                        state.loginResponseEntity.profile.profilePictureUrl,
                    fullName: state.loginResponseEntity.profile.fullName,
                    dateOfBirth: state.loginResponseEntity.profile.dateOfBirth,
                    email: state.loginResponseEntity.profile.email,
                    city: state.loginResponseEntity.profile.city,
                    nic: state.loginResponseEntity.profile.nicNo,
                    username: _usernameController.text,
                    leadGenerationId:
                        state.loginResponseEntity.profile.leadGeneratorId,
                    isLeadGenerator:
                        state.loginResponseEntity.profile.leadGeneratorId != 0,
                    mobileNumber: state.loginResponseEntity.profile.mobileNo,
                    address1: state.loginResponseEntity.profile.addressLine1,
                    address2: state.loginResponseEntity.profile.addressLine2);

                /*(state.loginResponseEntity.profile.leadGeneratorId != 0)
                    ? Navigator.pushReplacementNamed(
                    context, Routes.LEAD_GENERATOR_DASHBOARD_VIEW)
                    : Navigator.pushReplacementNamed(context, Routes.HOME_VIEW);*/

                Navigator.pushReplacementNamed(
                  context,
                  Routes.HOME_VIEW,
                );
              } else if (state is ValidationFailedState) {
                showCeylifeDialog(
                    title:
                        AppLocalizations.of(context).translate('title_error'),
                    message:
                        AppLocalizations.of(context).translate(state.error));
              } else if (state is LoginFailedState) {
                showCeylifeDialog(
                  title: AppLocalizations.of(context).translate('title_error'),
                  message: state.error,
                );
              }
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(
                      0xff790013,
                    ),
                    Color(0xff370009),
                  ],
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 10,
                    child: Container(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                              minWidth: MediaQuery.of(context).size.width,
                              minHeight:
                                  MediaQuery.of(context).size.height - 100),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 45.h,
                              ),

                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, Routes.LANGUAGE_VIEW);
                                    },
                                    child: Wrap(
                                      alignment: WrapAlignment.center,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.language,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 7,
                                        ),
                                        Text(
                                          AppLocalizations.of(context)
                                              .translate(
                                                  'label_language_login'),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14),
                                        ),

                                        /* SizedBox(
                                          width: 4,
                                        ),*/

                                        Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 25.h,
                              ),

                              Container(
                                child: SvgPicture.asset(
                                  AppImages.icBrandLogo,
                                ),
                              ),
                              SizedBox(
                                height: 40.h,
                              ),
                              (_username != null && _username.isNotEmpty)
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 29),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${AppLocalizations.of(context).translate("label_hello")} ${_username}..!",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: AppColors.appBarTitle,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    )
                                  : CeyLifeTextField(
                                      controller: _usernameController,
                                      hint: AppLocalizations.of(context)
                                          .translate("login_user_id"),
                                    ),
                              SizedBox(
                                height: 30.h,
                              ),
                              CeyLifeTextField(
                                controller: _passwordController,
                                obscureText: true,
                                hint: AppLocalizations.of(context)
                                    .translate("login_password"),
                              ),
                              SizedBox(height: 14),
                              Padding(
                                padding: const EdgeInsets.only(right: 29),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context,
                                            Routes
                                                .FORGET_PASSWORD_USER_VERIFICATION_VIEW);
                                      },
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .translate("login_forgot_password"),
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.appBarTitle),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              CeyLifeButton(
                                onTapButton: () {
                                  loginBloc.add(GetLoginEvent(
                                      username: (_username != null &&
                                              _username.isNotEmpty)
                                          ? _username
                                          : _usernameController.text,
                                      password: _passwordController.text,
                                      signInType: SignInType.PASSWORD,
                                      deviceInfo: _deviceInfo));
                                },
                                buttonText: AppLocalizations.of(context)
                                    .translate("login_login_button"),
                              ),
                              SizedBox(height: 30.h),
                              /*Wrap(
                                alignment: WrapAlignment.center,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                direction: Axis.vertical,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)
                                        .translate("login_user_id_empty"),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.appBarTitle),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context,
                                          Routes
                                              .USER_REGISTRATION_POLICY_VERIFICATION_VIEW);
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate("login_register_now"),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 14,
                                          decoration: TextDecoration.underline,
                                          decorationThickness: 1,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.appBarTitle),
                                    ),
                                  ),
                                ],
                              ),*/
                              // SizedBox(height: 8),

                              Text(
                                AppLocalizations.of(context)
                                    .translate("login_or"),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.appBarTitle),
                              ),

                              SizedBox(
                                  height: (_isBiometricEnrolled &&
                                          _isBiometricEnabled)
                                      ? 12
                                      : 20),

                              (_isBiometricEnrolled && _isBiometricEnabled)
                                  ? Column(
                                      children: [
                                        Text(
                                          _biometricDescription(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.appBarTitle),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        InkWell(
                                          child: _biometricIcon(),
                                          onTap: () {
                                            biometricServices
                                                .authenticate()
                                                .then((success) {
                                              if (success) {
                                                loginBloc.add(GetLoginEvent(
                                                    signInType:
                                                        SignInType.BIOMETRIC,
                                                    deviceInfo: _deviceInfo));
                                              }
                                            });
                                          },
                                        )
                                      ],
                                    )
                                  : SizedBox.shrink(),
                              /*Wrap(
                                alignment: WrapAlignment.center,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                direction: Axis.vertical,
                                children: [
                                  Text(
                                    'Earn extra from the app even without a policy ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.appBarTitle),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context,
                                          Routes
                                              .LEAD_GENERATOR_REGISTRATION_VIEW);
                                    },
                                    child: Text(
                                      'Become a Lead Generator',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 14,
                                          decoration: TextDecoration.underline,
                                          decorationThickness: 1,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.appBarTitle),
                                    ),
                                  ),
                                ],
                              ),*/

                              SizedBox(
                                height: (_isBiometricEnrolled &&
                                        _isBiometricEnabled)
                                    ? 37
                                    : 0,
                              ),
                              Wrap(
                                alignment: WrapAlignment.center,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)
                                        .translate((_username != null &&
                                        _username.isNotEmpty)
                                        ?"label_desc_not_you":"label_desc_user_it_not_exists"),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.appBarTitle),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context,
                                          Routes
                                              .USER_REGISTRATION_POLICY_VERIFICATION_VIEW);
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate((_username != null &&
                                                  _username.isNotEmpty)
                                              ? "label_login_desc"
                                              : "label_desc_register_now")
                                          .toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 14,
                                          decoration: TextDecoration.underline,
                                          decorationThickness: 1,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.appBarTitle),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                        onTap: () async {
                          Navigator.pushNamed(
                              context, Routes.PRE_LOGIN_MENU_VIEW,
                              arguments: false);
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
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate('menu_label'),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color:
                                            AppColors.primaryHeadingTextColor,
                                        fontSize: 12),
                                  ),
                                ),
                              )
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
  }

  @override
  Bloc getBloc() {
    return loginBloc;
  }

  String _biometricDescription() {
    switch (_biometricType) {
      case Biometric.FINGERPRINT:
        return Platform.isAndroid
            ? ErrorMessages()
                .mapAPIErrorCode(ErrorMessages.APP_BIOMETRIC_FINGER_ID, "")
            : ErrorMessages()
                .mapAPIErrorCode(ErrorMessages.APP_BIOMETRIC_TOUCH_ID, "");
        break;
      case Biometric.FACE:
        return ErrorMessages()
            .mapAPIErrorCode(ErrorMessages.APP_BIOMETRIC_FACE_ID, "");
        break;
      case Biometric.BOTH:
        return ErrorMessages()
            .mapAPIErrorCode(ErrorMessages.APP_BIOMETRIC_BIOMETRIC, "");
        break;
      case Biometric.NONE:
        return "";
        break;
    }
  }

  Widget _biometricIcon() {
    switch (_biometricType) {
      case Biometric.FINGERPRINT:
        return SvgPicture.asset(
          Platform.isIOS ? AppImages.icTouchId : AppImages.icFingerprint,
          color: AppColors.biometricColor,
        );
        break;
      case Biometric.FACE:
        return SvgPicture.asset(
          AppImages.icFaceID,
          color: AppColors.biometricColor,
        );
        break;
      case Biometric.BOTH:
        return Row(
          children: [
            SvgPicture.asset(
              Platform.isIOS ? AppImages.icTouchId : AppImages.icFingerprint,
              color: AppColors.biometricColor,
            ),
            SizedBox(
              width: 32,
            ),
            SvgPicture.asset(
              AppImages.icFaceID,
              color: AppColors.biometricColor,
            )
          ],
        );
        break;
      case Biometric.NONE:
        return SizedBox.shrink();
        break;
    }
  }
}
