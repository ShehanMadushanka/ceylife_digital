import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BenefitsTableItem extends StatelessWidget {
  final bool isHeader;
  final String name;
  final double amount;
  final String coveredDescription;

  BenefitsTableItem(
      {this.isHeader = false, this.name, this.amount, this.coveredDescription});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              isHeader
                  ? Expanded(
                      child: Text(
                        AppLocalizations.of(context)
                            .translate("label_life_name"),
                        style: TextStyle(
                            fontSize: 12,
                            color: AppColors.primaryHeadingTextColor,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.start,
                      ),
                    )
                  : Expanded(
                      child: Text(
                        name,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: AppColors.primaryAshColor),
                      ),
                    ),
              isHeader
                  ? Expanded(
                      child: Text.rich(
                        TextSpan(
                            text: AppLocalizations.of(context)
                                .translate("label_amount_benefits"),
                            style: TextStyle(
                                fontSize: 12,
                                color: AppColors.primaryHeadingTextColor,
                                fontWeight: FontWeight.w500),
                            children: [
                              TextSpan(
                                  text: ' (LKR)',
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: AppColors.primaryHeadingTextColor,
                                      fontWeight: FontWeight.w500))
                            ]),
                        textAlign: TextAlign.start,
                      ),
                    )
                  : Expanded(
                      child: Text(
                        NumberFormat.currency(symbol: '').format(
                          amount,
                        ),
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: AppColors.primaryAshColor),
                      ),
                    ),
              isHeader
                  ? Expanded(
                      child: Text(
                        AppLocalizations.of(context)
                            .translate("label_covered_description"),
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.primaryHeadingTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    )
                  : Expanded(
                      child: Text(
                        coveredDescription,
                        maxLines: 4,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: AppColors.primaryAshColor),
                      ),
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
