import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CeylifeActionButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final String label;
  final bool isVertical;

  const CeylifeActionButton(
      {Key key, this.onTap, this.icon, this.label, this.isVertical = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      highlightColor: Colors.transparent,
      onPressed: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isVertical
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: AppColors.newsItemButtonColor),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    label,
                    style: TextStyle(
                      color: AppColors.textColorMaroon,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              )
            : Row(
                children: [
                  Icon(icon, color: AppColors.newsItemButtonColor),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    label,
                    style: TextStyle(
                      color: AppColors.textColorMaroon,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
      ),
    );
  }
}
