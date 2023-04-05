import 'dart:async';

import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:flutter/material.dart';

class FileUploadProgressDialog extends StatefulWidget {
  @override
  _FileUploadProgressDialogState createState() =>
      _FileUploadProgressDialogState();
}

class _FileUploadProgressDialogState extends State<FileUploadProgressDialog> {
  double pValue = 0.0;

  startTimer() {
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      try{
        setState(() {
          pValue = AppConstants.LOADING_PROGRESS;
        });
      }catch(e){}

      if (pValue == 100) {
        timer.cancel();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: FractionalOffset.center,
        padding: const EdgeInsets.all(30.0),
        child: Wrap(
          children: [
            Material(
              child: Container(
                width: double.infinity,
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context).translate("title_file_upload"),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: AppColors.textColorMaroon),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: pValue != 100
                                ? CircularProgressIndicator(
                                    value: pValue / 100,
                                    strokeWidth: 5,
                                    backgroundColor:
                                        AppColors.circularProgressColor,
                                    valueColor: AlwaysStoppedAnimation(
                                        AppColors.activeIndicatorColor),
                                  )
                                : CircularProgressIndicator(
                                    strokeWidth: 5,
                                    backgroundColor:
                                        AppColors.circularProgressColor,
                                    valueColor: AlwaysStoppedAnimation(
                                        AppColors.activeIndicatorColor)),
                          ),
                          Text(
                            "${pValue.toStringAsFixed(0)}%",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: AppColors.textColorMaroon),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Text(
                        AppLocalizations.of(context).translate("desc_file_upload"),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: AppColors.primaryBlackColor),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
