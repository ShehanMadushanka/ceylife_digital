import 'package:ceylife_digital/features/domain/entities/response/health_tip_response_entity.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_icons_icons.dart';
import 'package:ceylife_digital/features/presentation/common/image_loading_indicator.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HealthDetail extends StatelessWidget {
  final HealthTipEntity healthTip;

  const HealthDetail({Key key, this.healthTip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 17),
      child: Material(
        type: MaterialType.transparency,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Color(0x40000000), blurRadius: 6)],
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    healthTip.title,
                    style: TextStyle(
                        color: AppColors.primaryHeadingTextColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 16),
                Hero(
                  tag: '${healthTip.title}',
                  child: Image.network(
                    healthTip.imageUrl,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return ImageLoadingIndicator(
                          loadingProgress: loadingProgress);
                    },
                  ),
                ),
                SvgPicture.asset(
                  AppImages.ceylinco_brand,
                  fit: BoxFit.fill,
                ),
                SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Text(
                    healthTip.content,
                    style: TextStyle(
                        color: AppColors.primaryAshColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
