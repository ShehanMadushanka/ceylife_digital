import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/features/data/models/common/configuration_data.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/registration/registration_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/registration/registration_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/registration/registration_state.dart';
import 'package:ceylife_digital/features/presentation/common/bullet_point.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_anim_widget.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_button.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_icons_icons.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_info.dart';
import 'package:ceylife_digital/features/presentation/common/ceylinco_edit_text_field.dart';
import 'package:ceylife_digital/features/presentation/views/user_registration/widgets/get_help.dart';
import 'package:ceylife_digital/utils/app_animation.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/device_info.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:ceylife_digital/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

import '../base_view.dart';
import 'data/registration_data_bean.dart';

class AccountCreationView extends BaseView {
  final RegistrationData registrationData;

  AccountCreationView({this.registrationData});

  @override
  _AccountCreationViewState createState() =>
      _AccountCreationViewState(registrationData);
}

class _AccountCreationViewState extends BaseViewState<AccountCreationView>
    with TickerProviderStateMixin {
  final RegistrationData registrationData;

  _AccountCreationViewState(this.registrationData);

  bool isMobileUser = true;
  final bloc = injection<RegistrationBloc>();
  AnimationController _animationController;
  AnimationController _stepperAnimationController;
  String _stepperAnimation = AppAnimation.getStepperAnim(3);

  TextEditingController _userIdController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _repeatPasswordController = TextEditingController();
  ButtonType _buttonType = ButtonType.DISABLED;
  ConfigurationData _configurationData;
  String _userIdError = '';
  String _passwordError = '';
  DeviceInfo _deviceInfo;

  @override
  void initState() {
    super.initState();
    initDeviceInfo();
    bloc.add(GetConfigData());
    isMobileUser = ((registrationData.userType ==
            AppConstants.CLIENT_USER_TYPE_POLICY_HOLDER) ||
        (registrationData.userType ==
            AppConstants.CLIENT_USER_TYPE_CLIENT_LEAD_GENERATOR));
    _animationController = AnimationController(vsync: this);
    _stepperAnimationController = AnimationController(vsync: this);
  }

  initDeviceInfo() async {
    _deviceInfo = DeviceInfo();
    _deviceInfo.initDeviceInfo();
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
                .translate("user_registration_app_bar_title"),
            style: TextStyle(color: AppColors.appBarTitle, fontSize: 18),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(AppImages.appBarBackIcon),
          ),
        ),
        body: BlocProvider<RegistrationBloc>(
          create: (_) => bloc,
          child: BlocListener<RegistrationBloc, BaseState<RegistrationState>>(
            cubit: bloc,
            listener: (context, state) {
              if (state is CreateUserSuccessState) {
                showCeylifeDialog(
                  title:
                      AppLocalizations.of(context).translate("title_success"),
                  positiveButtonText: AppLocalizations.of(context)
                      .translate("login_login_button"),
                  onPositiveCallback: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.LOGIN_VIEW, (route) => false);
                  },
                  message:
                      '${registrationData.nickname}, ${AppLocalizations.of(context).translate("label_account_creation_success")}',
                  dialogContentWidget: Column(
                    children: [
                      CeylifeAnimWidget(
                          controller: _animationController,
                          anim: AppAnimation.animSuccess)
                    ],
                  ),
                );
              } else if (state is ExistingUserFailedState) {
                setState(() {
                  _userIdError = state.error;
                  _passwordError = '';
                });
              } else if (state is PasswordMatchingFailedState) {
                setState(() {
                  _userIdError = '';
                  _passwordError = state.error;
                });
              } else if (state is CreateUserFailedState) {
                showCeylifeDialog(
                  title: AppLocalizations.of(context)
                      .translate("user_registration_failed_message"),
                  positiveButtonText: AppLocalizations.of(context)
                      .translate("try_again_button_label"),
                  onPositiveCallback: () {
                    setState(() {
                      _stepperAnimation = AppAnimation.getStepperAnim(4);
                    });
                    _stepperAnimationController.reset();
                    _stepperAnimationController.forward();
                  },
                  onNegativeCallback: () {},
                  alertType: AlertType.FAIL,
                  negativeButtonText: AppLocalizations.of(context)
                      .translate("contact_customer_support"),
                  message:
                      '${AppLocalizations.of(context).translate("label_previous_request_pending_desc_sorry")} ${registrationData.nickname}, ${AppLocalizations.of(context).translate("label_account_creation_failed")}',
                  dialogContentWidget: Column(
                    children: [
                      CeylifeAnimWidget(
                          controller: _animationController,
                          anim: AppAnimation.animFailed)
                    ],
                  ),
                );
              } else if (state is ConfigDataSuccessState) {
                setState(() {
                  _configurationData = state.configurationData;
                });
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 20),
                        child: Lottie.asset(
                          _stepperAnimation,
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
                            AppAnimation.animAccountCreate,
                            repeat: false,
                            width: 200,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Hero(
                        tag: 'title',
                        child: Material(
                          type: MaterialType.transparency,
                          child: Text(
                            AppLocalizations.of(context)
                                .translate("account_creation_label"),
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
                        height: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 29),
                        child: Material(
                          type: MaterialType.transparency,
                          child: Text(
                            !isMobileUser
                                ? AppLocalizations.of(context).translate(
                                    "account_creation_web_description")
                                : AppLocalizations.of(context).translate(
                                    "account_creation_fresh_description"),
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
                        controller: _userIdController,
                        inputFormatter: r'[0-9a-zA-Z@]',
                        onTextChanged: (value) {
                          if (_userIdController.text.length >= 8) {
                            if (!isMobileUser) {
                              setState(() {
                                _userIdError = '';
                                _buttonType = ButtonType.ENABLED;
                              });
                            } else {
                              setState(() {
                                _userIdError = '';
                              });
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
                            }
                          } else {
                            setState(() {
                              _buttonType = ButtonType.DISABLED;
                            });
                          }
                        },
                        hint: AppLocalizations.of(context)
                            .translate("account_creation_hint_user_id"),
                        floatingEnabled: true,
                        suffixIcon: IconButton(
                          icon: Icon(CeylifeIcons.ic_help_white_bg,
                              color: Colors.white),
                          onPressed: () {
                            showCeylifeDialog(
                              title: AppLocalizations.of(context)
                                  .translate("account_creation_hint_user_id"),
                              positiveButtonText: AppLocalizations.of(context)
                                  .translate("got_it_button_label"),
                              dialogContentWidget: Column(
                                children: [
                                  BulletPoint(
                                      text: 'Must be at least 8 characters'),
                                  BulletPoint(
                                    text:
                                        'Allowed to use alphanumeric characters (A-z, 0-9)',
                                  ),
                                  BulletPoint(
                                    text: 'Avoid spacing between characters.',
                                  ),
                                  BulletPoint(
                                    text:
                                        'Only \"@\" sign allowed to use from special characters',
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        errorMessage: _userIdError,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      !isMobileUser
                          ? SizedBox.shrink()
                          : Column(
                              children: [
                                CeyLifeTextField(
                                  controller: _passwordController,
                                  onTextChanged: (value) {
                                    if (_userIdController.text.length != 0) {
                                      if (!isMobileUser) {
                                        setState(() {
                                          _buttonType = ButtonType.ENABLED;
                                        });
                                      } else {
                                        if (_passwordController.text.length !=
                                                0 &&
                                            _repeatPasswordController
                                                    .text.length !=
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
                                    }
                                  },
                                  hint: AppLocalizations.of(context).translate(
                                      "account_creation_hint_password"),
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
                                                text:
                                                    'Passwords must be at least ${_configurationData.passwordPolicy.minLength} characters.'),
                                            BulletPoint(
                                              text:
                                                  'Should contain at least ${_configurationData.passwordPolicy.minNumChars} numeral, ${_configurationData.passwordPolicy.minUpperChars} uppercase, and ${_configurationData.passwordPolicy.minLowerChars} lowercase letter.',
                                            ),
                                            _configurationData.passwordPolicy
                                                        .minSpecialChars >
                                                    0
                                                ? BulletPoint(
                                                    text:
                                                        'Should contain at least ${_configurationData.passwordPolicy.minSpecialChars} special characters.',
                                                  )
                                                : SizedBox.shrink(),
                                            (_configurationData.passwordPolicy
                                                            .minSpecialChars >
                                                        0 &&
                                                    (_configurationData
                                                                .passwordPolicy
                                                                .specialChars !=
                                                            null &&
                                                        _configurationData
                                                            .passwordPolicy
                                                            .specialChars
                                                            .isNotEmpty))
                                                ? BulletPoint(
                                                    text:
                                                        'Special characters should be ${_configurationData.passwordPolicy.specialChars}',
                                                  )
                                                : SizedBox.shrink(),
                                            BulletPoint(
                                              text:
                                                  'Password should not  contain the userId.',
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
                                    if (_userIdController.text.length != 0) {
                                      if (!isMobileUser) {
                                        setState(() {
                                          _buttonType = ButtonType.ENABLED;
                                        });
                                      } else {
                                        if (_passwordController.text.length !=
                                                0 &&
                                            _repeatPasswordController
                                                    .text.length !=
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
                      !isMobileUser
                          ? CeylifeInfo(
                              description: AppLocalizations.of(context)
                                  .translate(
                                      "account_creation_web_advice_description"),
                              title: AppLocalizations.of(context).translate(
                                  "account_creation_web_advice_title"),
                              icon: CeylifeIcons.ic_info,
                            )
                          : CeylifeInfo(
                              description: AppLocalizations.of(context).translate(
                                  "account_creation_fresh_advice_description"),
                              title: AppLocalizations.of(context).translate(
                                  "account_creation_fresh_advice_title"),
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
                                  .translate("create_account_button_label"),
                              onTapButton: () {
                                bloc.add(CreateUserEvent(
                                    nic: registrationData.nic,
                                    password: _passwordController.text,
                                    repeatPassword:
                                        _repeatPasswordController.text,
                                    nickname: registrationData.nickname,
                                    email: registrationData.email,
                                    isWebUser: !isMobileUser,
                                    userId: _userIdController.text,
                                    deviceInfo: _deviceInfo));
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
    _stepperAnimationController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Bloc getBloc() {
    return bloc;
  }
}
