import 'dart:ui';

import 'package:ceylife_digital/features/presentation/common/ceylife_primary_button.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:flutter/material.dart';

class RequestInfoChangeDialog extends StatefulWidget {
  final Function(InfoChangeRequestData, String) onUpdateRequestChangeData;
  final List<InfoChangeRequestData> infoChangeRequestDataList;

  RequestInfoChangeDialog(
      {@required this.onUpdateRequestChangeData,
      this.infoChangeRequestDataList});

  @override
  _RequestInfoChangeDialogState createState() =>
      _RequestInfoChangeDialogState();
}

class _RequestInfoChangeDialogState extends State<RequestInfoChangeDialog> {
  final TextEditingController _commentController = TextEditingController();
  ButtonType _buttonType = ButtonType.DISABLED;
  InfoChangeRequestData _selectedRequestChange;
  int value;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
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
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Material(
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
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            AppLocalizations.of(context)
                                .translate('request_change_dialog_title'),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: AppColors.textColorMaroon,
                            ),
                          ),
                          ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              Column(
                                children:
                                    widget.infoChangeRequestDataList.isNotEmpty
                                        ? _loadInfo()
                                        : SizedBox.shrink(),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: TextFormField(
                                  minLines: 3,
                                  maxLines: 5,
                                  textAlign: TextAlign.start,
                                  controller: _commentController,
                                  keyboardType: TextInputType.multiline,
                                  style: TextStyle(
                                    color: AppColors.primaryAshColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  cursorColor: AppColors.appHighlightColor,
                                  decoration: InputDecoration(
                                    focusColor: Colors.white,
                                    hoverColor: Colors.white,
                                    filled: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 18),
                                    hintText: AppLocalizations.of(context)
                                        .translate(
                                            'request_change_comment_hint'),
                                    fillColor: Colors.white,
                                    hintStyle: TextStyle(
                                        color: AppColors.textColorAsh,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0),
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: AppColors.primaryBackgroundColor,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0),
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: AppColors.primaryBackgroundColor,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0),
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: AppColors.primaryBackgroundColor,
                                      ),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0),
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: AppColors.primaryBackgroundColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CeylifePrimaryButton(
                            buttonLabel: AppLocalizations.of(context)
                                .translate('submit_request_button'),
                            buttonType: _buttonType,
                            onTap: () {
                              Navigator.pop(context);
                              widget.onUpdateRequestChangeData(
                                  _selectedRequestChange,
                                  _commentController.text);
                            },
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 57,
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate('cancel_button_label'),
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
              ),
            )),
      ),
    );
  }

  List<Widget> _loadInfo() {
    List<Widget> _requestDataList = List();

    for (int i = 0; i < widget.infoChangeRequestDataList.length; i++) {
      _requestDataList.add(
        Theme(
          data: ThemeData(
            unselectedWidgetColor: AppColors.primaryBackgroundColor,
          ),
          child: RadioListTile(
            dense: true,
            title: Text(
              widget.infoChangeRequestDataList[i].requestType,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: AppColors.primaryBlackColor,
                fontFamily: AppConstants.fontFamily,
              ),
            ),
            value: i,
            activeColor: AppColors.primaryBackgroundColor,
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (val) {
              setState(() {
                value = val;
                _selectedRequestChange =
                    widget.infoChangeRequestDataList.elementAt(val);
                _buttonType = ButtonType.ENABLED;
              });
            },
            groupValue: value,
          ),
        ),
      );
    }

    return _requestDataList;
  }
}

class InfoChangeRequestData {
  String requestType;
  int id;

  InfoChangeRequestData({@required this.requestType, this.id});
}
