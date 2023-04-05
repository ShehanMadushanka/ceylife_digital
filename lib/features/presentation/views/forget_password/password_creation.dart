import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/features/data/models/common/configuration_data.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/forgot_password/forgot_password_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/forgot_password/forgot_password_state.dart';
import 'package:ceylife_digital/features/presentation/common/bullet_point.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_anim_widget.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_button.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_icons_icons.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_info.dart';
import 'package:ceylife_digital/features/presentation/common/ceylinco_edit_text_field.dart';
import 'package:ceylife_digital/features/presentation/views/user_registration/data/registration_data_bean.dart';
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

class PasswordCreationView extends BaseView {
  final RegistrationData registrationData;

  PasswordCreationView(this.registrationData);

  @override
  _PasswordCreationViewState createState() =>
      _PasswordCreationViewState(registrationData);
}

class _PasswordCreationViewState extends BaseViewState<PasswordCreationView>
    with TickerProviderStateMixin {
  final RegistrationData registrationData;
  ButtonType _buttonType = ButtonType.DISABLED;
  final isWebUser = true;
  final bloc = injection<ForgotPasswordBloc>();
  AnimationController _animationController;
  AnimationController _stepperAnimationController;
  String _stepperAnimation = AppAnimation.getStepperAnim(3);
  TextEditingController _newPwdController = TextEditingController();
  TextEditingController _repeatPwdController = TextEditingController();
  String _passwordError = '';
  ConfigurationData _configurationData;

  _PasswordCreationViewState(this.registrationData);

  @override
  void initState() {
    super.initState();
    bloc.add(GetConfigData());
    _animationController = AnimationController(vsync: this);
    _stepperAnimationController = AnimationController(vsync: this);
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
                .translate("forgot_password_app_bar_title"),
            style: TextStyle(color: AppColors.appBarTitle, fontSize: 18),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(AppImages.appBarBackIcon),
          ),
        ),
        body: Container(
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
          child: BlocProvider<ForgotPasswordBloc>(
            create: (_) => bloc,
            child: BlocListener<ForgotPasswordBloc,
                BaseState<ForgotPasswordState>>(
              listener: (context, state) {
                if (state is UpdatePasswordSuccessState) {
                  showCeylifeDialog(
                    title:
                        '${AppLocalizations.of(context).translate("title_success")}!',
                    positiveButtonText: AppLocalizations.of(context)
                        .translate("login_login_button"),
                    onPositiveCallback: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, Routes.LOGIN_VIEW, (route) => false);
                    },
                    message:
                        '${registrationData.nickname}, ${AppLocalizations.of(context).translate("label_password_creation_success")}',
                    dialogContentWidget: Column(
                      children: [
                        CeylifeAnimWidget(
                            controller: _animationController,
                            anim: AppAnimation.animSuccess)
                      ],
                    ),
                  );
                } else if (state is UpdatePasswordFailedState) {
                  showCeylifeDialog(
                    title: AppLocalizations.of(context)
                        .translate("label_password_creation_failed"),
                    positiveButtonText: AppLocalizations.of(context)
                        .translate("try_again_button_label"),
                    onPositiveCallback: () {
                      setState(() {
                        _stepperAnimation = AppAnimation.getStepperAnim(4);
                        _passwordError = '';
                      });
                      _stepperAnimationController.reset();
                      _stepperAnimationController.forward();
                    },
                    onNegativeCallback: () {
                      Navigator.pushNamed(context, Routes.CONTACT_US_VIEW);
                    },
                    alertType: AlertType.FAIL,
                    negativeButtonText: AppLocalizations.of(context)
                        .translate("contact_customer_support"),
                    message:
                        '${AppLocalizations.of(context).translate("label_previous_request_pending_desc_sorry")} ${registrationData.nickname}, ${AppLocalizations.of(context).translate("desc_password_creation_failed")}',
                    dialogContentWidget: Column(
                      children: [
                        CeylifeAnimWidget(
                            controller: _animationController,
                            anim: AppAnimation.animFailed)
                      ],
                    ),
                  );
                } else if (state is PasswordMatchingFailedState) {
                  setState(() {
                    _passwordError = state.error;
                  });
                } else if (state is ConfigDataSuccessState) {
                  setState(() {
                    _configurationData = state.configurationData;
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.only(bottom: 30),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 20),
                        child: Lottie.asset(
                          AppAnimation.getStepperAnim(2),
                          controller: _stepperAnimationController,
                          onLoaded: (composition) {
                            _stepperAnimationController
                              ..duration = composition.duration
                              ..forward();
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Hero(
                        tag: 'icon',
                        child: Material(
                          type: MaterialType.transparency,
                          child: Lottie.asset(
                            AppAnimation.animForgotPassword,
                            repeat: false,
                            width: 200,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Hero(
                        tag: 'title',
                        child: Material(
                          type: MaterialType.transparency,
                          child: Text(
                            AppLocalizations.of(context)
                                .translate("password_creation_label"),
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
                        height: 10,
                      ),
                      Material(
                        type: MaterialType.transparency,
                        child: Text(
                          'Hi ${registrationData.nickname},',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 29),
                        child: Material(
                          type: MaterialType.transparency,
                          child: Text(
                            AppLocalizations.of(context)
                                .translate("password_creation_description"),
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
                        height: 30,
                      ),
                      CeyLifeTextField(
                        controller: _newPwdController,
                        obscureText: true,
                        hint: AppLocalizations.of(context)
                            .translate("password_creation_new_password"),
                        floatingEnabled: true,
                        onTextChanged: (value) {
                          setState(() {
                            _passwordError = '';
                            if (_newPwdController.text.length != 0 &&
                                _repeatPwdController.text.length != 0)
                              _buttonType = ButtonType.ENABLED;
                            else
                              _buttonType = ButtonType.DISABLED;
                          });
                        },
                        suffixIcon: IconButton(
                          icon: Icon(CeylifeIcons.ic_help_white_bg,
                              color: Colors.white),
                          onPressed: () {
                            showCeylifeDialog(
                              title: AppLocalizations.of(context)
                                  .translate("setting_your_password"),
                              positiveButtonText: AppLocalizations.of(context)
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
                                  _configurationData
                                              .passwordPolicy.minSpecialChars >
                                          0
                                      ? BulletPoint(
                                          text: ErrorMessages().mapAPIErrorCode(
                                              ErrorMessages
                                                  .APP_PASSWORD_MINIMUM_SPECIAL_CHARACTERS,
                                              _configurationData.passwordPolicy
                                                  .minSpecialChars
                                                  .toString()))
                                      : SizedBox.shrink(),
                                  (_configurationData.passwordPolicy
                                                  .minSpecialChars >
                                              0 &&
                                          (_configurationData.passwordPolicy
                                                      .specialChars !=
                                                  null &&
                                              _configurationData.passwordPolicy
                                                  .specialChars.isNotEmpty))
                                      ? BulletPoint(
                                          text: ErrorMessages().mapAPIErrorCode(
                                              ErrorMessages
                                                  .APP_PASSWORD_SPECIAL_CHARACTERS,
                                              _configurationData
                                                  .passwordPolicy.specialChars
                                                  .toString()))
                                      : SizedBox.shrink(),
                                  BulletPoint(
                                      text: ErrorMessages().mapAPIErrorCode(
                                          ErrorMessages
                                              .APP_PASSWORD_NO_USER_NAME,
                                          "")),
                                ],
                              ),
                            );
                          },
                        ),
                        errorMessage: _passwordError,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      CeyLifeTextField(
                        controller: _repeatPwdController,
                        onTextChanged: (value) {
                          setState(() {
                            _passwordError = '';
                            if (_newPwdController.text.length != 0 &&
                                _repeatPwdController.text.length != 0)
                              _buttonType = ButtonType.ENABLED;
                            else
                              _buttonType = ButtonType.DISABLED;
                          });
                        },
                        obscureText: true,
                        hint: AppLocalizations.of(context)
                            .translate("password_creation_confirm_password"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      isWebUser
                          ? SizedBox.shrink()
                          : Column(
                              children: [
                                CeyLifeTextField(
                                  hint: AppLocalizations.of(context).translate(
                                      "password_creation_web_advice_title"),
                                  floatingEnabled: true,
                                  obscureText: true,
                                  suffixIcon: IconButton(
                                    icon: Icon(CeylifeIcons.ic_help_white_bg,
                                        color: Colors.white),
                                    onPressed: () {
                                      showCeylifeDialog(
                                        title: AppLocalizations.of(context)
                                            .translate("setting_your_password"),
                                        positiveButtonText: AppLocalizations.of(
                                                context)
                                            .translate("got_it_button_label"),
                                        dialogContentWidget: Column(
                                          children: [
                                            BulletPoint(
                                                text: ErrorMessages()
                                                    .mapAPIErrorCode(
                                                        ErrorMessages
                                                            .APP_PASSWORD_MINIMUM_CHARACTERS,
                                                        _configurationData
                                                            .passwordPolicy
                                                            .minLength
                                                            .toString())),
                                            BulletPoint(
                                              text: ErrorMessages().mapAPIErrorCode(
                                                  ErrorMessages
                                                      .APP_PASSWORD_MINIMUM_CASES,
                                                  "${_configurationData.passwordPolicy.minNumChars}|${_configurationData.passwordPolicy.minUpperChars}|${_configurationData.passwordPolicy.minLowerChars}"),
                                            ),
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
                                  errorMessage: ErrorMessages().mapAPIErrorCode(
                                      ErrorMessages
                                          .APP_PASSWORD_POLICY_MISMATCH,
                                      ""),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                CeyLifeTextField(
                                  hint: AppLocalizations.of(context).translate(
                                      "password_creation_confirm_password"),
                                  floatingEnabled: true,
                                  obscureText: true,
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                              ],
                            ),
                      CeylifeInfo(
                        description: AppLocalizations.of(context).translate(
                            "password_creation_web_advice_description"),
                        title: AppLocalizations.of(context)
                            .translate("password_creation_web_advice_title"),
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
                                  .translate("create_password_button_label"),
                              buttonType: _buttonType,
                              onTapButton: () {
                                bloc.add(UpdatePassword(
                                    password: _newPwdController.text,
                                    repeatPassword: _repeatPwdController.text));
                              },
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
    _stepperAnimationController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Bloc getBloc() {
    return bloc;
  }
}
