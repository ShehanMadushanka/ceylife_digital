import 'dart:io';
import 'dart:ui';

import 'package:ceylife_digital/core/service/biometric_services.dart';
import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'cetlife_input_widget.dart';
import 'ceylife_primary_button.dart';

class UserVerificationDialog {
  void showDialog(BuildContext context,
      {@required Function(String, String) authCredentials,
        @required Function(bool) biometricStatus,
        @required BiometricServices biometricServices}) {
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: _AuthDialog(
                isAuthSuccess: authCredentials,
                biometricStatus: biometricStatus,
                biometricServices: biometricServices,
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {});
  }
}

class _AuthDialog extends StatefulWidget {
  final Function(String, String) isAuthSuccess;
  final Function(bool) biometricStatus;
  final BiometricServices biometricServices;

  _AuthDialog(
      {this.isAuthSuccess, this.biometricStatus, this.biometricServices});

  @override
  __AuthDialogState createState() => __AuthDialogState();
}

class __AuthDialogState extends State<_AuthDialog> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  ButtonType _buttonType = ButtonType.DISABLED;
  Biometric _biometricType = Biometric.FINGERPRINT;

  @override
  void initState() {
    super.initState();

    if (widget.biometricServices != null)
      widget.biometricServices.getAvailableType().then((value) {
        setState(() {
          _biometricType = value;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Container(
          alignment: FractionalOffset.center,
          padding: const EdgeInsets.all(20.0),
          child: Wrap(
            children: [
              Material(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Colors.white,
                          Color(0xFFE1E1E1),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.11, 0.58]),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            AppLocalizations.of(context).translate(
                                "user_verification_label"),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: AppColors.newsHeadlineColor),
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Text(
                          AppLocalizations.of(context).translate(
                              "label_common_verification_desc"),
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AppColors.textColorAshDark2),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        CeyLifeInputWidget(
                          title: AppLocalizations.of(context).translate(
                              "label_common_verification_username"),
                          controller: _userNameController,
                          onTextChage: (value) {
                            setState(() {
                              if (value.isNotEmpty &&
                                  _passwordController.text.isNotEmpty)
                                _buttonType = ButtonType.ENABLED;
                              else
                                _buttonType = ButtonType.DISABLED;
                            });
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        CeyLifeInputWidget(
                          title: AppLocalizations.of(context).translate(
                              "login_password"),
                          shouldMask: true,
                          controller: _passwordController,
                          onTextChage: (value) {
                            setState(() {
                              if (value.isNotEmpty &&
                                  _userNameController.text.isNotEmpty)
                                _buttonType = ButtonType.ENABLED;
                              else
                                _buttonType = ButtonType.DISABLED;
                            });
                          },
                        ),
                        SizedBox(
                          height: 33,
                        ),
                        widget.biometricServices != null
                            ? Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                ErrorMessages().mapAPIErrorCode(
                                    ErrorMessages.APP_COMMON_VERIFICATION_TYPE,
                                    '${_biometricType == Biometric.FINGERPRINT
                                        ? '${Platform.isIOS
                                        ? AppLocalizations.of(context)
                                        .translate("label_touch_id")
                                        : AppLocalizations.of(context)
                                        .translate("label_fingerprint_id")}'
                                        : AppLocalizations.of(context)
                                        .translate("label_face_id")}'),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColors.appbarPrimary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                widget.biometricServices
                                    .authenticate()
                                    .then(
                                      (value) {
                                    if (value) {
                                      Navigator.pop(context);
                                      widget.biometricStatus(value);
                                    }
                                  },
                                );
                              },
                              child: Center(
                                child: SvgPicture.asset(
                                  _biometricType == Biometric.FINGERPRINT
                                      ? (Platform.isIOS
                                      ? AppImages.icTouchId
                                      : AppImages.icFingerprint)
                                      : AppImages.icFaceID,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 39,
                            ),
                          ],
                        )
                            : SizedBox.shrink(),
                        CeylifePrimaryButton(
                          buttonType: _buttonType,
                          width: double.infinity,
                          buttonLabel: AppLocalizations.of(context).translate(
                              "continue_button_label"),
                          onTap: () {
                            Navigator.pop(context);
                            widget.isAuthSuccess(_userNameController.text,
                                _passwordController.text);
                          },
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 45,
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context).translate(
                                    "cancel_button_label"),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: AppColors.newsHeadlineColor),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
