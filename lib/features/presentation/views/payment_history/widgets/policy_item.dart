import 'package:ceylife_digital/features/domain/entities/response/policy_details_response_entity.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:marquee_widget/marquee_widget.dart';

class PolicyItemUI extends StatelessWidget {
  final PolicyDetailItemEntity policyDetailIItemEntity;

  const PolicyItemUI({this.policyDetailIItemEntity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(7),
        height: 144,
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
                        'Ceylinco Life',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Marquee(
                        child: Text(
                          policyDetailIItemEntity.planName,
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
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Wrap(
                    direction: Axis.vertical,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)
                            .translate("policy_number_label"),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        policyDetailIItemEntity.policyNo,
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
