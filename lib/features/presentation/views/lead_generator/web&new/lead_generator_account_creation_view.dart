import 'package:bloc/src/bloc.dart';
import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/features/data/models/common/configuration_data.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/lead_generation/lead_generation_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/lead_generation/lead_generation_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/lead_generation/lead_generation_state.dart';
import 'package:ceylife_digital/features/presentation/common/bullet_point.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_button.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_icons_icons.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_info.dart';
import 'package:ceylife_digital/features/presentation/common/ceylinco_edit_text_field.dart';
import 'package:ceylife_digital/features/presentation/views/base_view.dart';
import 'package:ceylife_digital/features/presentation/views/lead_generator/data/lead_data_bean.dart';
import 'package:ceylife_digital/utils/app_animation.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:ceylife_digital/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

class LeadGeneratorAccountCreationView extends BaseView {
  final LeadData leadData;

  LeadGeneratorAccountCreationView({this.leadData});

  @override
  _LeadGeneratorAccountCreationViewState createState() =>
      _LeadGeneratorAccountCreationViewState();
}

class _LeadGeneratorAccountCreationViewState
    extends BaseViewState<LeadGeneratorAccountCreationView> {
  final bloc = injection<LeadGenerationBloc>();
  ButtonType _buttonType = ButtonType.DISABLED;
  TextEditingController _userIdController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _repeatController = TextEditingController();
  ConfigurationData _configurationData;
  String _passwordError = '';
  String _usernameError = '';

  @override
  void initState() {
    super.initState();
    bloc.add(GetConfigData());
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)
              .translate("lead_generator_registration_app_bar_title"),
          style: TextStyle(color: AppColors.appBarTitle, fontSize: 18),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(AppImages.appBarBackIcon),
        ),
      ),
      body: BlocProvider<LeadGenerationBloc>(
        create: (_) => bloc,
        child: BlocListener<LeadGenerationBloc, BaseState<LeadGenerationState>>(
          cubit: bloc,
          listener: (context, state) {
            if (state is ConfigDataSuccessState) {
              setState(() {
                _configurationData = state.configurationData;
              });
            } else if (state is RegisterLeadGeneratorSuccessState) {
              Navigator.pushNamed(context, Routes.LEAD_GENERATOR_LOGIN_VIEW,
                  arguments: widget.leadData);
            } else if (state is RegisterLeadGeneratorFailedState) {
              showCeylifeDialog(
                  title: AppLocalizations.of(context).translate('title_error'),
                  message: state.error,
                  onPositiveCallback: () {
                    Navigator.pop(context);
                  });
            }else if(state is PasswordMatchingFailedState){
              setState(() {
                _passwordError = state.error;
              });
            } else if (state is ExistingUserFailedState) {
              setState(() {
                _usernameError = state.error;
                _passwordError = '';
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
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          minWidth: constraints.maxWidth,
                          minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
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
                              height: 15,
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
                              height: 15,
                            ),
                            Text(
                              'Hi ${widget.leadData.nickname}',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 29),
                              child: Material(
                                type: MaterialType.transparency,
                                child: (widget.leadData != null &&
                                        widget.leadData.userType ==
                                            AppConstants
                                                .CLIENT_USER_TYPE_NEW_USER)
                                    ? Text.rich(
                                        TextSpan(
                                            text:
                                                'You have to create your own User ID and a Password to login the app. To read our User ID and Password policies tap on  " ',
                                            children: [
                                              WidgetSpan(
                                                child: Icon(
                                                  CeylifeIcons.ic_help_white_bg,
                                                  color: Colors.white,
                                                  size: 18,
                                                ),
                                              ),
                                              TextSpan(
                                                  text: ' "  buttons below.')
                                            ]),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                        ),
                                        textAlign: TextAlign.center,
                                      )
                                    : Text(
                                        AppLocalizations.of(context).translate(
                                            "account_creation_web_description"),
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
                              errorMessage: _usernameError,
                              inputFormatter: r'[0-9a-zA-Z@]',
                              onTextChanged: (value){
                                if (_userIdController.text.length >= 8) {
                                  if (!(widget.leadData != null &&
                                      widget.leadData.userType ==
                                          AppConstants.CLIENT_USER_TYPE_NEW_USER)) {
                                    setState(() {
                                      _usernameError = '';
                                      _buttonType = ButtonType.ENABLED;
                                    });
                                  } else {
                                    setState(() {
                                      _usernameError = '';
                                    });
                                    if (_passwordController.text.length != 0 &&
                                        _repeatController.text.length != 0) {
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
                                icon: Icon(CeylifeIcons.ic_help_white_bg,
                                    color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            (widget.leadData != null &&
                                    widget.leadData.userType ==
                                        AppConstants.CLIENT_USER_TYPE_NEW_USER)
                                ? Column(
                                    children: [
                                      CeyLifeTextField(
                                        controller: _passwordController,
                                        errorMessage: _passwordError,
                                        onTextChanged: (value) {
                                          setState(() {
                                            _passwordError = "";
                                          });
                                        },
                                        hint: AppLocalizations.of(context)
                                            .translate(
                                                "account_creation_hint_password"),
                                        floatingEnabled: true,
                                        obscureText: true,
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                              CeylifeIcons.ic_help_white_bg,
                                              color: Colors.white),
                                          onPressed: () {
                                            showCeylifeDialog(
                                              title: AppLocalizations.of(
                                                      context)
                                                  .translate(
                                                      "setting_your_password"),
                                              positiveButtonText:
                                                  AppLocalizations.of(context)
                                                      .translate(
                                                          "got_it_button_label"),
                                              dialogContentWidget: Column(
                                                children: [
                                                  BulletPoint(
                                                      text:
                                                          'Passwords must be at least ${_configurationData.passwordPolicy.minLength} characters.'),
                                                  BulletPoint(
                                                    text:
                                                        'Should contain at least ${_configurationData.passwordPolicy.minNumChars} numeral, ${_configurationData.passwordPolicy.minUpperChars} uppercase, and ${_configurationData.passwordPolicy.minLowerChars} lowercase letter.',
                                                  ),
                                                  BulletPoint(
                                                    text:
                                                        'Password should not  contain the username.',
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      CeyLifeTextField(
                                        controller: _repeatController,
                                        onTextChanged: (value) {
                                          setState(() {
                                            _passwordError = "";
                                          });
                                        },
                                        hint: AppLocalizations.of(context)
                                            .translate(
                                                "account_creation_hint_confirm_password"),
                                        floatingEnabled: true,
                                        obscureText: true,
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                    ],
                                  )
                                : SizedBox.shrink(),
                            SizedBox(
                              height: 20,
                            ),
                            (widget.leadData != null &&
                                    widget.leadData.userType ==
                                        AppConstants.CLIENT_USER_TYPE_NEW_USER)
                                ? SizedBox.shrink()
                                : CeylifeInfo(
                                    description: AppLocalizations.of(context)
                                        .translate(
                                            "account_creation_web_advice_description"),
                                    title: AppLocalizations.of(context)
                                        .translate(
                                            "account_creation_web_advice_title"),
                                    icon: CeylifeIcons.ic_info,
                                  ),
                            (widget.leadData != null &&
                                    widget.leadData.userType ==
                                        AppConstants.CLIENT_USER_TYPE_NEW_USER)
                                ? SizedBox.shrink()
                                : SizedBox(
                                    height: 60,
                                  ),
                            Column(
                              children: [
                                CeyLifeButton(
                                  buttonText: AppLocalizations.of(context)
                                      .translate("create_account_button_label"),
                                  buttonType: _buttonType,
                                  onTapButton: () {
                                    bloc.add(
                                      RegisterLeadGeneratorEvent(
                                          isNewUser: widget.leadData.userType ==
                                              AppConstants
                                                  .CLIENT_USER_TYPE_NEW_USER,
                                          userName: _userIdController.text,
                                          nickName: widget.leadData.nickname,
                                          nic: widget.leadData.key,
                                          addressCity: widget.leadData.address3,
                                          addressLine1:
                                              widget.leadData.address1,
                                          addressLine2:
                                              widget.leadData.address2,
                                          branchId:
                                              widget.leadData.nearestBranchId,
                                          contactNo2:
                                              widget.leadData.telephoneNumber,
                                          contactNo:
                                              widget.leadData.mobileNumber,
                                          email: widget.leadData.email,
                                          fullName: widget.leadData.fullName,
                                          password: _passwordController.text,
                                          repeatPassword:
                                              _repeatController.text),
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(CeylifeIcons.ic_help,
                                        color: Colors.white),
                                    SizedBox(width: 8),
                                    Text(
                                      'Having Trouble? Click here to get help',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
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
