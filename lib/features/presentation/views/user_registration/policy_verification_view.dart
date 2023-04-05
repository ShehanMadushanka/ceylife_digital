import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/policy/policy_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/policy/policy_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/policy/policy_state.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_anim_widget.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_button.dart';
import 'package:ceylife_digital/features/presentation/common/ceylinco_edit_text_field.dart';
import 'package:ceylife_digital/features/presentation/views/base_view.dart';
import 'package:ceylife_digital/features/presentation/views/common/data/otp_request_data.dart';
import 'package:ceylife_digital/features/presentation/views/common/data/otp_response_data.dart';
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

class PolicyVerificationView extends BaseView {
  @override
  _PolicyVerificationViewState createState() => _PolicyVerificationViewState();
}

class _PolicyVerificationViewState extends BaseViewState<PolicyVerificationView>
    with TickerProviderStateMixin {
  // ignore: close_sinks
  // ignore: close_sinks
  ButtonType _buttonType = ButtonType.DISABLED;
  final policyBloc = injection<PolicyBloc>();
  AnimationController _animationController;
  AnimationController _stepperAnimationController;
  TextEditingController _nicController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
        body: BlocProvider(
          create: (_) => policyBloc,
          child: BlocListener<PolicyBloc, BaseState<PolicyState>>(
            cubit: policyBloc,
            listener: (context, state) {
              if (state is InitialPolicyState) {
              } else if (state is PolicyLoadedState) {
                Navigator.pushNamed(
                        context, Routes.COMMON_OTP_VERIFICATION_VIEW,
                        arguments: OTPRequestData(
                            keyType: 1,
                            otpReference: state.policyResponseEntity.otpRef,
                            maskedEmail: state.policyResponseEntity.email,
                            maskedMobile: state.policyResponseEntity.mobileNo,
                            key: _nicController.text,
                            appBarTitle: AppLocalizations.of(context)
                                .translate("user_registration_app_bar_title")))
                    .then((otpResponseData) {
                  if (otpResponseData is OTPResponseData) {
                    if (otpResponseData.isVerificationSuccess) {
                      RegistrationData registrationData = RegistrationData(
                        userType: state.policyResponseEntity.userType,
                        nickname: otpResponseData.payload.nickName,
                        nic: _nicController.text,
                      );

                      Navigator.pushReplacementNamed(
                          context, Routes.USER_REGISTRATION_USER_DETAILS_VIEW,
                          arguments: registrationData);
                    } else
                      Navigator.pop(context);
                  }
                });
              } else if (state is ValidationFailedState) {
                showCeylifeDialog(
                    title:
                        AppLocalizations.of(context).translate('title_error'),
                    message:
                        AppLocalizations.of(context).translate(state.error));
              } else if (state is PolicyFailedState) {
                showCeylifeDialog(
                  title: AppLocalizations.of(context).translate('label_policy_verification_failed'),
                  positiveButtonText: AppLocalizations.of(context).translate('try_again_button_label'),
                  alertType: AlertType.FAIL,
                  onPositiveCallback: () {},
                  message: state.error,
                  dialogContentWidget: Column(
                    children: [
                      CeylifeAnimWidget(
                          controller: _animationController,
                          anim: AppAnimation.animError)
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
                child: LayoutBuilder(
                  builder: (context, constraints) {
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
                                  AppAnimation.getStepperAnim(1),
                                  controller: _stepperAnimationController,
                                  onLoaded: (composition) {},
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
                                    AppAnimation.animIDCard,
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
                                        .translate("policy_verification_label"),
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
                                    AppLocalizations.of(context).translate(
                                        "policy_verification_description"),
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
                                height: 80,
                              ),
                              CeyLifeTextField(
                                controller: _nicController,
                                inputFormatter: r'[0-9vVxX]',
                                onTextChanged: (value) {
                                  setState(() {
                                    if (value.length >= 10)
                                      _buttonType = ButtonType.ENABLED;
                                    else
                                      _buttonType = ButtonType.DISABLED;
                                  });
                                },
                                length: 12,
                                hint: AppLocalizations.of(context).translate(
                                    "policy_verification_hint_nic_number"),
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
                                          policyBloc.add(GetPolicyEvent(
                                              registrationType: AppConstants
                                                  .POLICY_HOLDER_REGISTRATION,
                                              key: _nicController.text,
                                              keyType: 1));
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
    return policyBloc;
  }

  @override
  void dispose() {
    _animationController.dispose();
    _stepperAnimationController.dispose();
    super.dispose();
  }
}
