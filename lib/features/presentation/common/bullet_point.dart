import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:flutter/material.dart';

class BulletPoint extends StatelessWidget {
  final String bullet;
  final Color bulletColor;
  final String text;
  final Color textColor;

  const BulletPoint(
      {Key key,
      this.bullet = '•',
      this.bulletColor = AppColors.textColorAshDark2,
      @required this.text,
      this.textColor = AppColors.textColorAshDark2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(bullet,
                  style: TextStyle(fontSize: 14, color: bulletColor)),
              flex: 1,
            ),
            Expanded(
              flex: 20,
              child: Text(
                text,
                style: TextStyle(
                    color: textColor,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
