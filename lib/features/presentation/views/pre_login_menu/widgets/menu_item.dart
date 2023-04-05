import 'package:ceylife_digital/features/presentation/views/pre_login_menu/pre_login_view.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:flutter/material.dart';

class PreLoginMenuItem extends StatelessWidget {
  final PreLogin menuItem;
  final int index;

  const PreLoginMenuItem({Key key, this.menuItem, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
            right: (index == 2 || index == 5 || index == 8)
                ? BorderSide.none
                : BorderSide(
                    color: Color(0xffA0424A).withOpacity(0.12),
                    width: 1,
                  ),
            bottom: index > 5
                ? BorderSide.none
                : BorderSide(
                    color: Color(0xffA0424A).withOpacity(0.12),
                    width: 1,
                  ),
            left: index == 7
                ? BorderSide(
                    color: Color(0xffA0424A).withOpacity(0.12),
                    width: 1,
                  )
                : BorderSide.none),
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        direction: Axis.vertical,
        children: <Widget>[
          Container(
            child: Icon(menuItem.icon,
                color: AppColors.primaryBackgroundColor, size: 48),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            AppLocalizations.of(context).translate(menuItem.key),
            style: TextStyle(
                color: AppColors.primaryHeadingTextColor,
                fontWeight: FontWeight.w500,
                fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
