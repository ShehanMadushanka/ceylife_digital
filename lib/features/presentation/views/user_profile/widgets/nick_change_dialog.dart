import 'dart:ui';

import 'package:ceylife_digital/features/presentation/common/ceylife_primary_button.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:flutter/material.dart';

class NickChangeDialog extends StatefulWidget {
  final Function(String) onUpdate;
  final String currentNickname;

  NickChangeDialog({this.onUpdate, this.currentNickname});

  @override
  _NickChangeDialogState createState() => _NickChangeDialogState();
}

class _NickChangeDialogState extends State<NickChangeDialog> {
  final TextEditingController _nicknameController = TextEditingController();
  ButtonType buttonType = ButtonType.DISABLED;

  @override
  void initState() {
    _nicknameController.text = widget.currentNickname;
    super.initState();
  }

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
                            AppLocalizations.of(context).translate('label_change_nickname'),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: AppColors.textColorMaroon),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextField(
                              onChanged: (nick) {
                                if (nick == widget.currentNickname ||
                                    nick.isEmpty) {
                                  buttonType = ButtonType.DISABLED;
                                } else {
                                  buttonType = ButtonType.ENABLED;
                                }
                                setState(() {});
                              },
                              controller: _nicknameController,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryBlackColor,
                              ),
                              textAlign: TextAlign.center,
                              maxLength: 25,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(0),
                                counterText: '',
                                hintText: AppLocalizations.of(context).translate('nickname_label'),
                                focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.appBarTitle, width: 1),
                                ),
                                errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.appBarTitle, width: 1),
                                ),
                                labelStyle: TextStyle(
                                    color: AppColors.primaryBlackColor),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.primaryBlackColor,
                                      width: 1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.primaryBlackColor,
                                      width: 1),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.primaryBlackColor,
                                      width: 1),
                                ),
                                alignLabelWithHint: true,
                                filled: false,
                                hintStyle:
                                    TextStyle(color: AppColors.primaryAshColor),
                                fillColor: AppColors.appBarTitle,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 42),
                            child: CeylifePrimaryButton(
                              buttonLabel: AppLocalizations.of(context).translate('button_label_save'),
                              buttonType: buttonType,
                              onTap: () {
                                Navigator.pop(context);
                                widget.onUpdate(_nicknameController.text);
                              },
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 57,
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context).translate('cancel_button_label'),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: AppColors.newsHeadlineColor),
                                ),
                              ),
                            ),
                          ),
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
