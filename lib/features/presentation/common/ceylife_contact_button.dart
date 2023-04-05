import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CeylifeContactButton extends StatelessWidget {
  final String buttonText;
  final IconData iconData;
  final bool isContact;
  final VoidCallback onTap;

  const CeylifeContactButton(
      {Key key,
      this.buttonText,
      this.iconData,
      this.isContact = true,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Color(0xffF5F5F5)],
              stops: [0, 1]),
          boxShadow: [
            BoxShadow(color: Color(0x33000000), blurRadius: 4),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          child: Wrap(
            direction: Axis.horizontal,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Icon(
                iconData,
                size: isContact ? 14 : 20,
                color: AppColors.primaryBackgroundColor,
              ),
              SizedBox(width: 8),
              Text(
                buttonText,
                style: TextStyle(
                  color: isContact
                      ? AppColors.primaryHeadingTextColor
                      : AppColors.textColorAshDark4,
                  fontSize: isContact ? 12 : 14,
                  fontWeight: isContact ? FontWeight.w500 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
