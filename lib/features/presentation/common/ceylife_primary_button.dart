import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:flutter/material.dart';

class CeylifePrimaryButton extends StatelessWidget {
  final String buttonLabel;
  final VoidCallback onTap;
  final ButtonType buttonType;
  final double width;

  const CeylifePrimaryButton(
      {@required this.buttonLabel,
      this.onTap,
      this.width,
      this.buttonType = ButtonType.ENABLED});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      height: 45,
      highlightColor: (buttonType == ButtonType.DISABLED)
          ? Colors.transparent
          : AppColors.appHighlightColor,
      minWidth: width == null ? MediaQuery.of(context).size.width - 100 : width,
      onPressed: () => (buttonType == ButtonType.ENABLED) ? onTap() : null,
      child: Text(
        buttonLabel,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
        textAlign: TextAlign.center,
      ),
      color: buttonType == ButtonType.DISABLED
          ? AppColors.primaryBackgroundColor.withOpacity(0.2)
          : AppColors.primaryBackgroundColor,
    );
  }
}
