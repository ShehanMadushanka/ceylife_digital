import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/user_details/user_details_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/user_details/user_details_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/user_details/user_details_state.dart';
import 'package:ceylife_digital/features/presentation/common/bullet_point.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_button.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_icons_icons.dart';
import 'package:ceylife_digital/features/presentation/common/ceylinco_edit_text_field.dart';
import 'package:ceylife_digital/features/presentation/views/base_view.dart';
import 'package:ceylife_digital/features/presentation/views/user_registration/data/registration_data_bean.dart';
import 'package:ceylife_digital/features/presentation/views/user_registration/widgets/get_help.dart';
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

class UserDetailsView extends BaseView {
  final RegistrationData registrationData;

  UserDetailsView({this.registrationData});

  @override
  _UserDetailsViewState createState() =>
      _UserDetailsViewState(registrationData);
}

class _UserDetailsViewState extends BaseViewState<UserDetailsView>
    with TickerProviderStateMixin {
  final RegistrationData registrationData;
  bool _isEmailVerified = false;
  final bloc = injection<UserDetailsBloc>();
  AnimationController _stepperAnimationController;
  AnimationController _animationController;

  TextEditingController _nicknameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  ButtonType _buttonType = ButtonType.DISABLED;
  String _emailError = '';

  _UserDetailsViewState(this.registrationData);

  @override
  void initState() {
    super.initState();
    _isEmailVerified = ((registrationData.userType ==
        AppConstants.CLIENT_USER_TYPE_VERIFIED_WEB_USER) || (registrationData.userType ==
        AppConstants.CLIENT_USER_TYPE_VERIFIED_WEB_LEAD_GENERATOR));
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
          child: BlocProvider<UserDetailsBloc>(
            create: (_) => bloc,
            child: BlocListener<UserDetailsBloc, BaseState<UserDetailsState>>(
              cubit: bloc,
              listener: (context, state) {
                if (state is ValidateUserEmailSuccessState) {
                  registrationData.email = _emailController.text;
                  registrationData.nickname = _nicknameController.text;
                  Navigator.pushNamed(
                      context, Routes.USER_REGISTRATION_ACCOUNT_CREATION_VIEW,
                      arguments: registrationData);
                } else if (state is ValidateUserEmailFailedState) {
                  setState(() {
                    _emailError =
                        AppLocalizations.of(context).translate(state.error);
                  });
                }
              },
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
                                    AppAnimation.animDetails,
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
                                        .translate("user_details_label"),
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
                                height: 8,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 29),
                                child: Material(
                                  type: MaterialType.transparency,
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate("user_details_description"),
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
                                controller: _nicknameController,
                                hint: AppLocalizations.of(context)
                                    .translate("user_details_hint_nickname"),
                                floatingEnabled: true,
                                onTextChanged: (value) {
                                  if (value.length != 0) {
                                    setState(() {
                                      _buttonType = ButtonType.ENABLED;
                                    });
                                  }
                                },
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              if (_isEmailVerified)
                                SizedBox.shrink()
                              else
                                VerifyEmail(
                                  emailController: _emailController,
                                  errorMessage: _emailError,
                                  onTextChange: (value) {
                                    setState(() {
                                      _emailError = '';
                                    });
                                  },
                                  onTap: () {
                                    showCeylifeDialog(
                                      title: AppLocalizations.of(context)
                                          .translate("label_setting_email_title"),
                                      dialogContentWidget: Column(
                                        children: [
                                          BulletPoint(
                                              text:
                                              AppLocalizations.of(context)
                                                  .translate("label_setting_email_item_1")),
                                          BulletPoint(
                                            text:
                                            AppLocalizations.of(context)
                                                .translate("label_setting_email_item_2"),
                                          ),
                                          BulletPoint(
                                              text:
                                              AppLocalizations.of(context)
                                                  .translate("label_setting_email_item_3"),
                                              textColor: AppColors.indianRed,
                                              bullet: '*',
                                              bulletColor: AppColors.indianRed),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              SizedBox(
                                height: 80,
                              ),
                              Spacer(),
                              SizedBox(
                                height: 10,
                              ),
                              Hero(
                                tag: 'buttons',
                                child: Material(
                                  type: MaterialType.transparency,
                                  child: Column(
                                    children: [
                                      CeyLifeButton(
                                        buttonType: _buttonType,
                                        buttonText: AppLocalizations.of(context)
                                            .translate("continue_button_label"),
                                        onTapButton: () {
                                          if (_nicknameController
                                              .text.isEmpty) {
                                            showCeylifeDialog(
                                                title: AppLocalizations.of(
                                                        context)
                                                    .translate('title_error'),
                                                message: AppLocalizations.of(
                                                        context)
                                                    .translate(
                                                        'error_nickname_empty'));
                                          } else {
                                            bloc.add(ValidateUserEmailEvent(
                                                email: _emailController.text));
                                          }
                                        },
                                      ),
                                      GetHelpView(),
                                    ],
                                  ),
                                ),
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
      ),
    );
  }

  @override
  Bloc getBloc() {
    return bloc;
  }

  @override
  void dispose() {
    _animationController.dispose();
    _stepperAnimationController.dispose();
    super.dispose();
  }
}

class VerifyEmail extends StatelessWidget {
  final VoidCallback onTap;
  final TextEditingController emailController;
  final Function(String) onTextChange;
  final errorMessage;

  const VerifyEmail(
      {Key key,
      this.onTap,
      this.emailController,
      this.onTextChange,
      this.errorMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CeyLifeTextField(
            controller: emailController,
            length: 50,
            onTextChanged: (value) => onTextChange(value),
            hint: AppLocalizations.of(context)
                .translate("user_details_hint_email"),
            floatingEnabled: true,
            errorMessage: errorMessage,
          ),
          Container(
            padding: const EdgeInsets.all(30.0),
            child: InkWell(
              onTap: () => onTap(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(CeylifeIcons.ic_info_white_bg, color: Colors.white),
                  SizedBox(width: 10),
                  Text(
                    AppLocalizations.of(context)
                        .translate("user_details_email_info"),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
