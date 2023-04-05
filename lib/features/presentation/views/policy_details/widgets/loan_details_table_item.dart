import 'dart:math' as math;

import 'package:ceylife_digital/features/presentation/common/ceylife_icons_icons.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LoanDetailsTableItem extends StatelessWidget {
  final bool isHeader;
  final String loanNumber;
  final double outstanding;
  final VoidCallback onTap;

  LoanDetailsTableItem(
      {this.isHeader = false, this.loanNumber, this.outstanding, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isHeader
                  ? Text(
                AppLocalizations.of(context)
                    .translate("label_load_number"),
                      style: TextStyle(
                          fontSize: 16,
                          color: AppColors.primaryHeadingTextColor,
                          fontWeight: FontWeight.w700),
                    )
                  : Text(
                      loanNumber,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                          color: AppColors.textColorMaroon),
                    ),
              isHeader
                  ? Text.rich(
                      TextSpan(
                          text: AppLocalizations.of(context)
        .translate("label_capital_outstanding"),
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
                                  fontWeight: FontWeight.w500),
                            )
                          ]),
                      textAlign: TextAlign.end,
                    )
                  : Row(
                      children: [
                        Text(
                          NumberFormat.currency(symbol: '').format(
                            outstanding,
                          ),
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: AppColors.primaryAshColor),
                        ),
                        Transform.rotate(
                          angle: 270 * math.pi / 180,
                          alignment: Alignment.center,
                          child: Icon(
                            CeylifeIcons.ic_rounded_arrow_down,
                            color: AppColors.primaryBackgroundColor,
                            size: 30,
                          ),
                        ),
                      ],
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
