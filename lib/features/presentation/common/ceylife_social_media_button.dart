import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CeylifeSocialMediaButton extends StatelessWidget {
  final String icon;
  final bool isIconSVG;
  final VoidCallback onTap;

  const CeylifeSocialMediaButton({Key key, this.icon, this.onTap, this.isIconSVG = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        child: isIconSVG?SvgPicture.asset(SVG_IMAGE_PATH + icon + SVG_TYPE,
            width: 40, height: 40):Image.asset(icon, width: 40, height: 40,),
      ),
    );
  }
}
