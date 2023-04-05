import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CeyLifeButton extends StatelessWidget {
  final String buttonText;
  final Function onTapButton;
  final double width;
  final ButtonType buttonType;

  const CeyLifeButton(
      {Key key,
      this.buttonText,
      this.onTapButton,
      this.width = 0,
      this.buttonType = ButtonType.ENABLED})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 29),
      child: InkWell(
        onTap: () {
          if (buttonType == ButtonType.ENABLED) onTapButton();
        },
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.zero,
            color: buttonType == ButtonType.ENABLED
                ? AppColors.appBarTitle
                : AppColors.buttonDisabledColor,
          ),
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                  color: AppColors.appbarPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
