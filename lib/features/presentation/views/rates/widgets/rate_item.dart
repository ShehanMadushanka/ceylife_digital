import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:marquee_widget/marquee_widget.dart';

class RatesItemUI extends StatelessWidget {
  final String planName;
  final String rate;

  RatesItemUI({@required this.planName, @required this.rate});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7),
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
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Marquee(
                      child: Text(
                        planName,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
                      // textDirection: TextDirection.ltr,
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
                padding: const EdgeInsets.only(bottom: 7, top: 4),
                child: Wrap(
                  direction: Axis.vertical,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Text(
                          ErrorMessages().mapAPIErrorCode(
                              ErrorMessages.APP_EMPTY_STATUS_RATE, ''),
                          style: TextStyle(
                            color: AppColors.textColorIndianRedLight,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: 9,
                        ),
                        Text(
                          "$rate%",
                          style: TextStyle(
                            color: AppColors.textColorIndianRedLight,
                            fontWeight: FontWeight.w500,
                            fontSize: 32,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
