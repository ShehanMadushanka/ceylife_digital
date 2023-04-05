import 'package:ceylife_digital/features/presentation/common/ceylife_icons_icons.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AdviceWidget extends StatelessWidget {
  final String advice;

  const AdviceWidget({this.advice});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: AppColors.adviceBackgroundColor,
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          Icon(CeylifeIcons.ic_info, color: AppColors.primaryBackgroundColor),
          SizedBox(
            width: 10,
          ),
          Flexible(
            child: Text(
              advice,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.primaryHeadingTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
