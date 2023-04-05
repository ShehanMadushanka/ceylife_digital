import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CeylifeNoBorderButton extends StatelessWidget {
  final String buttonLabel;
  final VoidCallback onTap;

  const CeylifeNoBorderButton({this.buttonLabel, this.onTap});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      highlightColor: Colors.transparent,
      height: 45,
      minWidth: MediaQuery.of(context).size.width - 100,
      onPressed: () => onTap(),
      child: Text(
        buttonLabel,
        style: TextStyle(
          color: AppColors.textColorMaroon,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
