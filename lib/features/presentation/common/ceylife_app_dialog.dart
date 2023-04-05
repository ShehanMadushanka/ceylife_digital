import 'dart:ui';

import 'package:ceylife_digital/features/presentation/common/ceylife_primary_button.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CeyLifeAppDialog extends StatelessWidget {
  final String title;
  final String description;
  final Color descriptionColor;
  final String subDescription;
  final Color subDescriptionColor;
  final AlertType alertType;
  final String positiveButtonText;
  final String negativeButtonText;
  final VoidCallback onPositiveCallback;
  final VoidCallback onNegativeCallback;
  final Widget dialogContentWidget;

  final bool isSessionTimeout;

  CeyLifeAppDialog(
      {this.title,
      this.description,
      this.descriptionColor,
      this.subDescription,
      this.subDescriptionColor,
      this.alertType,
      this.onPositiveCallback,
      this.onNegativeCallback,
      this.positiveButtonText,
      this.negativeButtonText,
      this.dialogContentWidget,
      this.isSessionTimeout});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {},
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
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            title != null ? title : "",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: alertType == AlertType.SUCCESS
                                    ? AppColors.textColorMaroon
                                    : AppColors.dialogFailedColor),
                          ),
                          dialogContentWidget != null
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      top: 12, left: 9, right: 9),
                                  child: dialogContentWidget,
                                )
                              : SizedBox(),
                          description != null
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 25),
                                  child: Text(
                                    description != null ? description : "",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: descriptionColor != null
                                            ? descriptionColor
                                            : AppColors.primaryBlackColor),
                                  ),
                                )
                              : SizedBox(),
                          subDescription != null
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: Text(
                                    subDescription != null
                                        ? subDescription
                                        : "",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: subDescriptionColor != null
                                            ? subDescriptionColor
                                            : AppColors.dialogFailedColor),
                                  ),
                                )
                              : SizedBox(),
                          Padding(
                            padding: const EdgeInsets.only(top: 42),
                            child: CeylifePrimaryButton(
                              buttonLabel: positiveButtonText != null
                                  ? positiveButtonText
                                  : AppLocalizations.of(context).translate('ok_label'),
                              onTap: () {
                                Navigator.pop(context);
                                if (onPositiveCallback != null)
                                  onPositiveCallback();
                              },
                            ),
                          ),
                          negativeButtonText != null
                              ? InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    if (onNegativeCallback != null)
                                      onNegativeCallback();
                                  },
                                  child: Container(
                                    height: 57,
                                    child: Center(
                                      child: Text(
                                        negativeButtonText,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: AppColors.newsHeadlineColor),
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
