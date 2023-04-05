import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:flutter/material.dart';

class RateDataRowItem extends StatelessWidget {
  final bool isHeader;
  final String date;
  final String rate;

  RateDataRowItem({this.isHeader = false, this.date, this.rate});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 47, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isHeader
                  ? Text(
                      AppLocalizations.of(context).translate("label_date"),
                      style: TextStyle(
                          fontSize: 16,
                          color: AppColors.primaryHeadingTextColor,
                          fontWeight: FontWeight.w700),
                    )
                  : Text(
                      date.split(' ')[0],
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColors.primaryAshColor),
                    ),
              isHeader
                  ? Text(
                      ErrorMessages().mapAPIErrorCode(
                          ErrorMessages.APP_EMPTY_STATUS_RATE, ''),
                      style: TextStyle(
                          fontSize: 16,
                          color: AppColors.primaryHeadingTextColor,
                          fontWeight: FontWeight.w700),
                    )
                  : Text(
                      '$rate%',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColors.primaryAshColor),
                    ),
            ],
          ),
          SizedBox(height: 10),
          isHeader
              ? SizedBox.shrink()
              : SizedBox(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    color: AppColors.dividerColor,
                  ),
                )
        ],
      ),
    );
  }
}
