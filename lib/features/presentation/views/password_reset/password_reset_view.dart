import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/features/data/models/common/configuration_data.dart';
import 'package:ceylife_digital/features/domain/entities/response/login_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/password_reset/password_reset_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/password_reset/password_reset_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/password_reset/password_reset_state.dart';
import 'package:ceylife_digital/features/presentation/common/bullet_point.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_anim_widget.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_button.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_icons_icons.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_info.dart';
import 'package:ceylife_digital/features/presentation/common/ceylinco_edit_text_field.dart';
import 'package:ceylife_digital/features/presentation/views/user_registration/widgets/get_help.dart';
import 'package:ceylife_digital/utils/app_animation.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:ceylife_digital/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

import '../base_view.dart';

class PasswordResetView extends BaseView {
  @override
  _PasswordResetViewState createState() => _PasswordResetViewState();
}

class _PasswordResetViewState extends BaseViewState<PasswordResetView>
    with TickerProviderStateMixin {
  final bloc = injection<PasswordResetBloc>();
  AnimationController _animationController;

  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _repeatPasswordController = TextEditingController();
  ButtonType _buttonType = ButtonType.DISABLED;
  ConfigurationData _configurationData;
  ProfileEntity _cacheUser;
  String _passwordError = '';

  @override
  void initState() {
    super.initState();
    bloc.add(GetConfigDataEvent());
    _animationController = AnimationController(vsync: this);
  }

  @override
  Widget buildView(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)
                .translate("title_app_bar_password_reset"),
            style: TextStyle(color: AppColors.appBarTitle, fontSize: 18),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(AppImages.appBarBackIcon),
          ),
        ),
        body: BlocProvider<PasswordResetBloc>(
          create: (_) => bloc,
          child: BlocListener<PasswordResetBloc, BaseState<PasswordResetState>>(
            cubit: bloc,
            listener: (context, state) {
              if (state is PasswordMatchingFailedState) {
                setState(() {
                  _passwordError = state.error;
                });
              } else if (state is PasswordResetFailedState) {
                showCeylifeDialog(
                  title: AppLocalizations.of(context)
                      .translate("password_reset_failed_title"),
                  positiveButtonText: AppLocalizations.of(context)
                      .translate("try_again_button_label"),
                  onPositiveCallback: () {},
                  onNegativeCallback: () {},
                  alertType: AlertType.FAIL,
                  negativeButtonText: AppLocalizations.of(context)
                      .translate("contact_customer_support"),
                  message:
                      '${AppLocalizations.of(context).translate("label_previous_request_pending_desc_sorry")} ${_cacheUser.nickName}, ${AppLocalizations.of(context).translate("password_reset_failed_message")}',
                  dialogContentWidget: Column(
                    children: [
                      CeylifeAnimWidget(
                          controller: _animationController,
                          anim: AppAnimation.animFailed)
                    ],
                  ),
                );
              } else if (state is UserDataSuccessState) {
                setState(() {
                  _configurationData = state.configurationData;
                  _cacheUser = state.cacheUser;
                });
              } else if (state is PasswordResetSuccessState) {
                showCeylifeDialog(
                  title:
                      AppLocalizations.of(context).translate("title_success"),
                  positiveButtonText: AppLocalizations.of(context)
                      .translate("got_it_button_label"),
                  onPositiveCallback: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.LOGIN_VIEW, (route) => false);
                  },
                  message:
                      '${_cacheUser.nickName}, ${AppLocalizations.of(context).translate("label_desc_password_reset_success")}',
                  dialogContentWidget: Column(
                    children: [
                      CeylifeAnimWidget(
                          controller: _animationController,
                          anim: AppAnimation.animSuccess)
                    ],
                  ),
                );
              }
            },
            child: Container(
              padding: EdgeInsets.only(top: 100),
              height: MediaQuery.of(context).size.height,
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
              child: Container(
                padding: EdgeInsets.only(bottom: 30),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Hero(
                        tag: 'icon',
                        child: Material(
                          type: MaterialType.transparency,
                          child: Lottie.asset(
                            AppAnimation.animAccountCreate,
                            repeat: false,
                            width: 200,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Hero(
                        tag: 'title',
                        child: Material(
                          type: MaterialType.transparency,
                          child: Text(
                            AppLocalizations.of(context)
                                .translate("account_creation_hint_password"),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Material(
                        type: MaterialType.transparency,
                        child: Text(
                          'Hi ${_cacheUser != null ? _cacheUser.nickName : ""},',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 29),
                        child: Material(
                          type: MaterialType.transparency,
                          child: Text(
                            AppLocalizations.of(context)
                                .translate("label_desc_password_reset"),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      CeyLifeTextField(
                        controller: _oldPasswordController,
                        obscureText: true,
                        onTextChanged: (value) {
                          if (_oldPasswordController.text.length != 0) {
                            if (_passwordController.text.length != 0 &&
                                _repeatPasswordController.text.length != 0) {
                              setState(() {
                                _buttonType = ButtonType.ENABLED;
                              });
                            } else {
                              setState(() {
                                _buttonType = ButtonType.DISABLED;
                              });
                            }
                          } else {
                            setState(() {
                              _buttonType = ButtonType.DISABLED;
                            });
                          }
                        },
                        hint: AppLocalizations.of(context)
                            .translate("password_reset_hint_old_password"),
                        floatingEnabled: true,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          CeyLifeTextField(
                            controller: _passwordController,
                            onTextChanged: (value) {
                              if (_oldPasswordController.text.length != 0) {
                                if (_passwordController.text.length != 0 &&
                                    _repeatPasswordController.text.length !=
                                        0) {
                                  setState(() {
                                    _passwordError = '';
                                    _buttonType = ButtonType.ENABLED;
                                  });
                                } else {
                                  setState(() {
                                    _buttonType = ButtonType.DISABLED;
                                  });
                                }
                              }
                            },
                            hint: AppLocalizations.of(context)
                                .translate("password_creation_new_password"),
                            floatingEnabled: true,
                            obscureText: true,
                            suffixIcon: IconButton(
                              icon: Icon(CeylifeIcons.ic_help_white_bg,
                                  color: Colors.white),
                              onPressed: () {
                                showCeylifeDialog(
                                  title: AppLocalizations.of(context)
                                      .translate("setting_your_password"),
                                  positiveButtonText:
                                      AppLocalizations.of(context)
                                          .translate("got_it_button_label"),
                                  dialogContentWidget: Column(
                                    children: [
                                      BulletPoint(
                                          text: ErrorMessages().mapAPIErrorCode(
                                              ErrorMessages
                                                  .APP_PASSWORD_MINIMUM_CHARACTERS,
                                              _configurationData
                                                  .passwordPolicy.minLength
                                                  .toString())),
                                      BulletPoint(
                                        text: ErrorMessages().mapAPIErrorCode(
                                            ErrorMessages
                                                .APP_PASSWORD_MINIMUM_CASES,
                                            "${_configurationData.passwordPolicy.minNumChars}|${_configurationData.passwordPolicy.minUpperChars}|${_configurationData.passwordPolicy.minLowerChars}"),
                                      ),
                                      _configurationData.passwordPolicy
                                                  .minSpecialChars >
                                              0
                                          ? BulletPoint(
                                              text: ErrorMessages().mapAPIErrorCode(
                                                  ErrorMessages
                                                      .APP_PASSWORD_MINIMUM_SPECIAL_CHARACTERS,
                                                  _configurationData
                                                      .passwordPolicy
                                                      .minSpecialChars
                                                      .toString()),
                                            )
                                          : SizedBox.shrink(),
                                      (_configurationData.passwordPolicy
                                                      .minSpecialChars >
                                                  0 &&
                                              (_configurationData.passwordPolicy
                                                          .specialChars !=
                                                      null &&
                                                  _configurationData
                                                      .passwordPolicy
                                                      .specialChars
                                                      .isNotEmpty))
                                          ? BulletPoint(
                                              text: ErrorMessages().mapAPIErrorCode(
                                                  ErrorMessages
                                                      .APP_PASSWORD_SPECIAL_CHARACTERS,
                                                  _configurationData
                                                      .passwordPolicy
                                                      .specialChars
                                                      .toString()),
                                            )
                                          : SizedBox.shrink(),
                                      BulletPoint(
                                        text: ErrorMessages().mapAPIErrorCode(
                                            ErrorMessages
                                                .APP_PASSWORD_NO_USER_NAME,
                                            ""),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            errorMessage: _passwordError,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CeyLifeTextField(
                            controller: _repeatPasswordController,
                            onTextChanged: (value) {
                              if (_oldPasswordController.text.length != 0) {
                                if (_passwordController.text.length != 0 &&
                                    _repeatPasswordController.text.length !=
                                        0) {
                                  setState(() {
                                    _passwordError = '';
                                    _buttonType = ButtonType.ENABLED;
                                  });
                                } else {
                                  setState(() {
                                    _buttonType = ButtonType.DISABLED;
                                  });
                                }
                              }
                            },
                            hint: AppLocalizations.of(context).translate(
                                "account_creation_hint_confirm_password"),
                            floatingEnabled: true,
                            obscureText: true,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                      CeylifeInfo(
                        description: AppLocalizations.of(context)
                            .translate("password_reset_label_secret"),
                        title: AppLocalizations.of(context)
                            .translate("account_creation_fresh_advice_title"),
                        icon: CeylifeIcons.ic_info,
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Material(
                        type: MaterialType.transparency,
                        child: Column(
                          children: [
                            CeyLifeButton(
                              buttonText: AppLocalizations.of(context)
                                  .translate("account_creation_hint_password"),
                              onTapButton: () {
                                bloc.add(
                                  ResetPasswordEvent(
                                      oldPassword: _oldPasswordController.text,
                                      newPassword: _passwordController.text,
                                      repeatPassword:
                                          _repeatPasswordController.text),
                                );
                              },
                              buttonType: _buttonType,
                            ),
                            GetHelpView(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Bloc getBloc() {
    return bloc;
  }
}
