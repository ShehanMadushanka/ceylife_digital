import 'package:ceylife_digital/features/presentation/common/ceylife_icons_icons.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CeylifeDropdownView extends StatelessWidget {
  final VoidCallback onTap;
  final String hint;
  final String value;

  const CeylifeDropdownView({Key key, this.onTap, this.hint, this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xff9A6A69), width: 1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                value.isNotEmpty ? value : hint,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: value.isNotEmpty
                      ? AppColors.primaryBlackColor
                      : AppColors.textColorAsh,
                ),
              ),
            ),
            Icon(CeylifeIcons.ic_rounded_arrow_down,
                size: 35, color: AppColors.textColorMaroon)
          ],
        ),
      ),
    );
  }
}
