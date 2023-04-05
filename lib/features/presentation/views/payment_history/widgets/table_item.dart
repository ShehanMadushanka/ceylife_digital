import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DataRowItem extends StatelessWidget {
  final bool isHeader;
  final String date;
  final double amount;

  DataRowItem({this.isHeader = false, this.date, this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 43, vertical: 10),
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
                      date,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColors.primaryAshColor),
                    ),
              isHeader
                  ? Text.rich(
                      TextSpan(
                          text: AppLocalizations.of(context)
                              .translate("label_amount"),
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColors.primaryHeadingTextColor,
                              fontWeight: FontWeight.w700),
                          children: [
                            TextSpan(
                                text: ' (LKR)',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: AppColors.primaryHeadingTextColor,
                                    fontWeight: FontWeight.w500))
                          ]),
                    )
                  : Text(
                      NumberFormat.currency(symbol: '').format(
                        amount,
                      ),
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColors.primaryAshColor),
                    )
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
