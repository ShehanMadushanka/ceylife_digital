import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/utils/app_animation.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_extensions.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CeylifeEmptyView extends StatelessWidget {
  final EmptyStatus status;

  const CeylifeEmptyView({Key key, this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: (status == EmptyStatus.PAYMENT_HISTORY ||
              status == EmptyStatus.RATE_HISTORY)
          ? Colors.transparent
          : Color(0xffE5E5E5),
      padding: EdgeInsets.all(21),
      child: Center(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            status == EmptyStatus.PAYMENT_HISTORY ||
                    status == EmptyStatus.RATE_HISTORY
                ? SizedBox(
                    height: 10,
                  )
                : SizedBox(
                    height: 30,
                  ),
            Text(
              ErrorMessages().mapAPIErrorCode(
                  ErrorMessages.APP_EMPTY_STATUS_TITLE, status.getValue()),
              style: TextStyle(
                color: AppColors.primaryHeadingTextColor,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            status == EmptyStatus.PAYMENT_HISTORY ||
                    status == EmptyStatus.RATE_HISTORY
                ? SizedBox(
                    height: 10,
                  )
                : SizedBox(
                    height: 50,
                  ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Lottie.asset(
                AppAnimation.animEmpty,
                repeat: false,
                onLoaded: (composition) {},
              ),
            ),
            status == EmptyStatus.PAYMENT_HISTORY ||
                    status == EmptyStatus.RATE_HISTORY
                ? SizedBox(
                    height: 10,
                  )
                : SizedBox(
                    height: 60,
                  ),
            Text(
              ErrorMessages().mapAPIErrorCode(
                  ErrorMessages.APP_EMPTY_STATUS_DESCRIPTION,
                  status.getValue()),
              style: TextStyle(
                color: AppColors.primaryHeadingTextColor,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
