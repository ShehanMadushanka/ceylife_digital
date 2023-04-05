import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:flutter/material.dart';

class CeylifeOutlineButton extends StatelessWidget {
  final IconData leading;
  final String text;
  final VoidCallback onTap;
  final ButtonType buttonType;

  const CeylifeOutlineButton(
      {Key key,
      this.leading,
      this.text,
      this.onTap,
      this.buttonType = ButtonType.ENABLED})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: MediaQuery.removeViewPadding(
        context: context,
        child: OutlineButton(
          color: buttonType == ButtonType.ENABLED
              ? AppColors.primaryBackgroundColor
              : AppColors.textColorAsh,
          borderSide:
              BorderSide(color: buttonType == ButtonType.ENABLED
                  ? AppColors.primaryBackgroundColor
                  : AppColors.textColorAsh, width: 1),
          highlightedBorderColor: AppColors.primaryBackgroundColor,
          highlightColor: AppColors.appHighlightColor,
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(0.0)),
          onPressed: (){
            if(buttonType == ButtonType.ENABLED)
              onTap();
          },
          child: Row(
            children: [
              Icon(leading,
                  color: buttonType == ButtonType.ENABLED
                      ? AppColors.primaryBackgroundColor
                      : AppColors.textColorAsh,
                  size: 18),
              SizedBox(width: 5),
              Text(text,
                  style: TextStyle(
                      color: buttonType == ButtonType.ENABLED
                          ? AppColors.primaryHeadingTextColor
                          : AppColors.textColorAsh,
                      fontSize: 12))
            ],
          ),
        ),
      ),
    );
  }
}
