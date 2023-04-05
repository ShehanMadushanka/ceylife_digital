import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CeylifeSocialButton extends StatelessWidget {
  final String buttonText;
  final String icon;
  final bool isTango;
  final VoidCallback onTap;

  const CeylifeSocialButton(
      {Key key, this.buttonText, this.icon, this.isTango = false, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        width: 145,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xffF5F5F5)],
            stops: [0, 1],
          ),
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
              !isTango
                  ? SvgPicture.asset(icon)
                  : Image.asset(icon, width: 20, height: 20),
              SizedBox(width: 8),
              Text(
                buttonText,
                style: TextStyle(
                  color: AppColors.textColorAshDark4,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
