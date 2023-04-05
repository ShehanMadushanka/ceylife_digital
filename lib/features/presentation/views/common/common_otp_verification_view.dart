import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/features/domain/entities/response/otp_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/otp/otp_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/otp/otp_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/otp/otp_state.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_button.dart';
import 'package:ceylife_digital/features/presentation/common/pin_code_fields.dart';
import 'package:ceylife_digital/features/presentation/views/base_view.dart';
import 'package:ceylife_digital/features/presentation/views/user_registration/widgets/get_help.dart';
import 'package:ceylife_digital/utils/app_animation.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:otp_count_down/otp_count_down.dart';

import 'data/otp_request_data.dart';
import 'data/otp_response_data.dart';

class CommonOTPVerificationView extends BaseView {
  final OTPRequestData otpRequestData;

  CommonOTPVerificationView(this.otpRequestData);

  @override
  _ForgotPasswordSecondaryVerificationViewState createState() =>
      _ForgotPasswordSecondaryVerificationViewState();
}

class _ForgotPasswordSecondaryVerificationViewState
    extends BaseViewState<CommonOTPVerificationView>
    with TickerProviderStateMixin {
  final bloc = injection<OtpBloc>();
  String _countDown;
  ButtonType _buttonType = ButtonType.DISABLED;
  OTPCountDown _otpCountDown;
  int _otpTimeInMS = 1000 * 1 * 60;
  bool _isCountDownFinished = false;
  AnimationController _animationController;
  AnimationController _stepperAnimationController;
  TextEditingController _otpController = TextEditingController();

  OtpResponseEntity otpResponseEntity;
  OTPResponseData otpResponseData = OTPResponseData();

  void _startCountDown() {
    _isCountDownFinished = false;
    _otpCountDown = OTPCountDown.startOTPTimer(
      timeInMS: _otpTimeInMS,
      currentCountDown: (String countDown) {
        _countDown = countDown;
        setState(() {});
      },
      onFinish: () {
        _isCountDownFinished = true;
        setState(() {});
      },
    );
  }

  @override
  void initState() {
    bloc.add(GetConfigurationData());
    otpResponseEntity =
        OtpResponseEntity(otpRef: widget.otpRequestData.otpReference);
    super.initState();
    _animationController = AnimationController(vsync: this);
    _stepperAnimationController = AnimationController(vsync: this);
    _stepperAnimationController.value = 0.3;
  }

  @override
  void dispose() {
    _otpCountDown.cancelTimer();
    _animationController.dispose();
    _stepperAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget buildView(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, otpResponseData);
        return false;
      },
      child: Material(
        type: MaterialType.transparency,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: false,
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              widget.otpRequestData.appBarTitle,
              style: TextStyle(color: AppColors.appBarTitle, fontSize: 18),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context, otpResponseData);
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
            child: BlocProvider<OtpBloc>(
              create: (_) => bloc,
              child: BlocListener<OtpBloc, BaseState<OtpState>>(
                cubit: bloc,
                listener: (context, state) {
                  if (state is OtpLoadedState) {
                    otpResponseEntity = state.otpResponseEntity;
                    otpResponseData.isVerificationSuccess = true;
                    otpResponseData.payload = otpResponseEntity;
                    Navigator.pop(context, otpResponseData);
                  } else if (state is ResendOtpSuccessState) {
                    _startCountDown();
                    otpResponseEntity.otpRef =
                        state.resendOtpResponseEntity.otpRef;
                    _otpController.clear();
                  } else if (state is ConfigDataSuccessState) {
                    setState(() {
                      _otpTimeInMS = state.configurationData.otpServiceTimeout;
                    });

                    _startCountDown();
                  }else if(state is OtpFailedState){
                    showCeylifeDialog(
                        isSessionTimeout: true,
                        title: AppLocalizations.of(context).translate('title_error'),
                        message: state.error,
                        onPositiveCallback: () {
                          _otpController.clear();
                        });
                  }
                },
                child: Container(
                  child: LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                    return SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      reverse: true,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: bottom),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                              minWidth: constraints.maxWidth,
                              minHeight: constraints.maxHeight),
                          child: IntrinsicHeight(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                widget.otpRequestData.shouldHideProgress
                                    ? SizedBox.shrink()
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 50, vertical: 20),
                                        child: Lottie.asset(
                                          AppAnimation.getStepperAnim(1),
                                          controller:
                                              _stepperAnimationController,
                                          onLoaded: (composition) {
                                            _stepperAnimationController
                                              ..duration = composition.duration
                                              ..forward();
                                          },
                                        ),
                                      ),
                                widget.otpRequestData.shouldHideProgress
                                    ? SizedBox.shrink()
                                    : SizedBox(
                                  height: 10,
                                ),
                                Hero(
                                  tag: 'icon',
                                  child: Material(
                                    type: MaterialType.transparency,
                                    child: Lottie.asset(
                                      AppAnimation.animOTP,
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
                                      AppLocalizations.of(context).translate(
                                          "secondary_verification_label"),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 29),
                                  child: Material(
                                    type: MaterialType.transparency,
                                    child: Text(
                                      generateVerificationDescription(),
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
                                  height: 40,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24),
                                  child: CeylifeOTPView(
                                    length: 6,
                                    controller: _otpController,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    activeColor: Colors.white,
                                    backgroundColor: Colors.transparent,
                                    cellBackgroundColor: Colors.white,
                                    inactiveColor: Colors.transparent,
                                    disabledColor: Colors.transparent,
                                    animationType: AnimationType.fade,
                                    shape: PinCodeFieldShape.box,
                                    fieldWidth: 42,
                                    fieldHeight: 42,
                                    borderWidth: 0,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    onCompleted: (value) {},
                                    textInputType: TextInputType.number,
                                    textStyle: TextStyle(
                                      color: AppColors.textColorMaroon,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 24,
                                    ),
                                    onChanged: (String value) {
                                      setState(() {
                                        if (value.length == 6)
                                          _buttonType = ButtonType.ENABLED;
                                        else
                                          _buttonType = ButtonType.DISABLED;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                _isCountDownFinished
                                    ? ResendOTPView(
                                        onTap: () {
                                          // _startCountDown();
                                          bloc.add(ResendOtpEvent(
                                            key: widget.otpRequestData.key,
                                            keyType:
                                                widget.otpRequestData.keyType,
                                          ));
                                        },
                                      )
                                    : Text(
                                        AppLocalizations.of(context).translate(
                                                "otp_resend_code_in") +
                                            ((_countDown != null)
                                                ? _countDown
                                                : ''),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                        ),
                                        textAlign: TextAlign.center,
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
                                          buttonText: AppLocalizations.of(
                                                  context)
                                              .translate("verify_button_label"),
                                          onTapButton: () {
                                            bloc.add(GetOtpEvent(
                                              key: widget.otpRequestData.key,
                                              keyType:
                                                  widget.otpRequestData.keyType,
                                              otpRef: otpResponseEntity.otpRef,
                                              userOtp: _otpController.text,
                                            ));
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
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String generateVerificationDescription() {
    if (widget.otpRequestData.maskedEmail == null ||
        widget.otpRequestData.maskedEmail.isEmpty) {
      return ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_MOBILE_EMAIL_VERIFICATION,'${widget.otpRequestData.maskedMobile}');
    } else {
      return ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_MOBILE_EMAIL_VERIFICATION,'${widget.otpRequestData.maskedMobile}|${widget.otpRequestData.maskedEmail}');
    }
  }

  @override
  Bloc getBloc() {
    return bloc;
  }
}

class ResendOTPView extends StatelessWidget {
  final VoidCallback onTap;

  const ResendOTPView({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context).translate("otp_not_received"),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          GestureDetector(
            onTap: () => onTap(),
            child: Text(
              AppLocalizations.of(context).translate("otp_resend"),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  decoration: TextDecoration.underline),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
