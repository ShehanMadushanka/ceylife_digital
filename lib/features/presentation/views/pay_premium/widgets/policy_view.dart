import 'package:ceylife_digital/features/domain/entities/response/policy_details_response_entity.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:marquee_widget/marquee_widget.dart';

class PayPremiumPolicyView extends StatelessWidget {
  final PolicyDetailItemEntity policy;

  const PayPremiumPolicyView({Key key, this.policy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFF8D8D7), Color(0xFFFCF1F0)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.37, 1.0],
        ),
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Color(0xFFA0424A),
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                end: Alignment.centerRight,
                begin: Alignment.centerLeft,
                colors: [AppColors.primaryBackgroundColor, Color(0xff631829)],
                stops: [0.2, 1],
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffD4A5A6), width: 1),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            CEYLINCO_LIFE,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Marquee(
                            child: Text(
                              policy.planName,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.center,
                            ),
                            textDirection: TextDirection.ltr,
                            animationDuration: Duration(seconds: 2),
                            backDuration: Duration(seconds: 2),
                            pauseDuration: Duration(milliseconds: 500),
                            directionMarguee: DirectionMarguee.TwoDirection,
                            direction: Axis.horizontal,
                            forwardAnimation: Curves.easeOut,
                            backwardAnimation: Curves.easeOut,
                          ),
                          Text(
                            policy.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Wrap(
                              direction: Axis.vertical,
                              crossAxisAlignment: WrapCrossAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)
                                      .translate('policy_number_label'),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  policy.policyNo,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ),
                          fit: FlexFit.loose,
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Wrap(
                              direction: Axis.vertical,
                              crossAxisAlignment: WrapCrossAlignment.end,
                              children: [
                                Text(
                                  AppLocalizations.of(context)
                                      .translate('insurance_premium_label'),
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text.rich(
                                  new TextSpan(
                                    text: CURRENCY_CODE,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10,
                                    ),
                                    children: <TextSpan>[
                                      new TextSpan(
                                        text: intl.NumberFormat.currency(
                                                symbol: '')
                                            .format(
                                          policy.premium,
                                        ),
                                        style: new TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          fit: FlexFit.loose,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Text.rich(
            new TextSpan(
              text: AppLocalizations.of(context).translate('amount_due_label'),
              style: TextStyle(
                color: AppColors.primaryBlackColor,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              children: <TextSpan>[
                new TextSpan(
                  text: '  (LKR)',
                  style: new TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                    color: AppColors.primaryBlackColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            intl.NumberFormat.currency(symbol: '').format(
              policy.totalDue,
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.primaryHeadingTextColor,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 13,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context).translate('paid_up_date_label') +
                    ' : ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primaryBlackColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                policy.paidUpDate,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primaryBlackColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
