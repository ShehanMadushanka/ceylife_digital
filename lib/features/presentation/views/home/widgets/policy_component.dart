import 'dart:math' as math;

import 'package:ceylife_digital/features/domain/entities/response/policy_details_response_entity.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_icons_icons.dart';
import 'package:ceylife_digital/features/presentation/views/home/widgets/badge_container_clip_path.dart';
import 'package:ceylife_digital/features/presentation/views/home/widgets/policy_container_clip_path.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/app_extensions.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PolicyComponent extends StatelessWidget {
  final PolicyDetailItemEntity policyDetailItemEntity;

  PolicyComponent({this.policyDetailItemEntity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: policyDetailItemEntity.policyStatusEnum == PolicyStatus.BUYONLINE
          ? Stack(
              fit: StackFit.expand,
              children: [
                ClipPath(
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.5),
                            Color(0xFF790013).withOpacity(0.5),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0.4, 1]),
                    ),
                  ),
                  clipper: PolicyContainerClipPath(),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ClipPath(
                    child: Container(
                        height: 300,
                        width: 100,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Color(0xFF790013),
                                Color(0xFF38030B),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0, 1]),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 64,
                            ),
                            Image(
                              image: AssetImage(AppImages.icCart),
                              height: 98,
                              width: 98,
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  AppLocalizations.of(context).translate(
                                      "products_services_buy_now_button_label"),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Transform.rotate(
                                  angle: 270 * math.pi / 180,
                                  alignment: Alignment.center,
                                  child: Icon(
                                    CeylifeIcons.ic_rounded_arrow_down,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            )
                          ],
                        )),
                    clipper: PolicyContainerClipPath(),
                  ),
                ),
              ],
            )
          : Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: _policyPadding(
                          policyDetailItemEntity.policyStatusEnum)),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipPath(
                        child: Container(
                          height: 300,
                          width: 100,
                          color: _generatePolicyBorderColor(
                              policyDetailItemEntity.policyStatusEnum),
                        ),
                        clipper: PolicyContainerClipPath(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ClipPath(
                          child: Container(
                            height: 300,
                            width: 100,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.white,
                                    Color(0xBAA9AC).withOpacity(0.9),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  stops: [0.39, 0.95]),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(17.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Ceylinco Life',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.primaryBlackColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    policyDetailItemEntity.planName,
                                    style: TextStyle(
                                        color: AppColors.textColorMaroon,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)
                                        .translate("policy_number_label"),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.primaryBlackColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    policyDetailItemEntity.policyNo,
                                    style: TextStyle(
                                        color: AppColors.textColorMaroon,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)
                                        .translate("insurance_premium_label"),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.primaryBlackColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text.rich(
                                    TextSpan(
                                        text: 'LKR  ',
                                        style: TextStyle(
                                            color: AppColors.textColorMaroon,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400),
                                        children: [
                                          TextSpan(
                                              text: NumberFormat.currency(
                                                      symbol: '')
                                                  .format(
                                                policyDetailItemEntity.premium,
                                              ),
                                              style: TextStyle(
                                                  color:
                                                      AppColors.textColorMaroon,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500))
                                        ]),
                                  ),
                                  Spacer(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate("view_more_label"),
                                        style: TextStyle(
                                          color: AppColors.textColorMaroon,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Transform.rotate(
                                        angle: 270 * math.pi / 180,
                                        alignment: Alignment.center,
                                        child: Icon(
                                          CeylifeIcons.ic_rounded_arrow_down,
                                          color: AppColors.textColorMaroon,
                                          size: 20,
                                        ),
                                      )
                                    ],
                                  ),
                                  Spacer()
                                ],
                              ),
                            ),
                          ),
                          clipper: PolicyContainerClipPath(),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    right: 16,
                    child: Wrap(
                      children: [
                        ClipPath(
                          child: Container(
                            height: 13,
                            width: 19,
                            color: _generatePolicyBadgeBackgroundColor(
                                policyDetailItemEntity.policyStatusEnum),
                          ),
                          clipper: BadgeContainerClipPath(),
                        ),
                        ClipPath(
                          child: Container(
                              height: AppConstants.APP_LANGUAGE==Languages.ENGLISH?45:40,
                              width: AppConstants.APP_LANGUAGE==Languages.ENGLISH?62:100,
                              color: _generatePolicyBadgeColor(
                                  policyDetailItemEntity.policyStatusEnum),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 9,
                                  ),
                                  Text(
                                    policyDetailItemEntity
                                        .policyStatusEnum.value,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: (policyDetailItemEntity
                                                        .policyStatusEnum ==
                                                    PolicyStatus.MATURED ||
                                                policyDetailItemEntity
                                                        .policyStatusEnum ==
                                                    PolicyStatus.PAIDUP)
                                            ? AppColors.primaryBlackColor
                                            : Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              )),
                          clipper: PolicyContainerClipPath(isBadge: true),
                        )
                      ],
                    )),
              ],
            ),
    );
  }

  Color _generatePolicyBorderColor(PolicyStatus policyStatus) {
    switch (policyStatus) {
      case PolicyStatus.ACTIVE:
        return Colors.transparent;
        break;
      case PolicyStatus.LAPSED:
        return AppColors.dialogFailedColor;
        break;
      case PolicyStatus.PROPOSAL:
        return Colors.transparent;
        break;
      case PolicyStatus.MATURED:
        return AppColors.policyMaturedColor;
        break;
      case PolicyStatus.PAIDUP:
        return AppColors.policyPaidUpColor;
        break;
    }
  }

  Color _generatePolicyBadgeColor(PolicyStatus policyStatus) {
    switch (policyStatus) {
      case PolicyStatus.ACTIVE:
        return AppColors.policyActiveColor;
        break;
      case PolicyStatus.LAPSED:
        return AppColors.dialogFailedColor;
        break;
      case PolicyStatus.PROPOSAL:
        return AppColors.primaryTextColor;
        break;
      case PolicyStatus.MATURED:
        return AppColors.policyMaturedColor;
        break;
      case PolicyStatus.PAIDUP:
        return AppColors.policyPaidUpColor;
        break;
    }
  }

  Color _generatePolicyBadgeBackgroundColor(PolicyStatus policyStatus) {
    switch (policyStatus) {
      case PolicyStatus.ACTIVE:
        return AppColors.policyBackgroundActiveColor;
        break;
      case PolicyStatus.LAPSED:
        return AppColors.policyBackgroundLapsedColor;
        break;
      case PolicyStatus.PROPOSAL:
        return AppColors.policyBackgroundProposalColor;
        break;
      case PolicyStatus.MATURED:
        return AppColors.policyBackgroundMaturedColor;
        break;
      case PolicyStatus.PAIDUP:
        return AppColors.policyBackgroundPaidUpColor;
        break;
    }
  }

  double _policyPadding(PolicyStatus policyStatus) {
    switch (policyStatus) {
      case PolicyStatus.ACTIVE:
      case PolicyStatus.PROPOSAL:
        return 9;
        break;
      case PolicyStatus.LAPSED:
      case PolicyStatus.MATURED:
      case PolicyStatus.PAIDUP:
        return 13;
        break;
    }
  }
}
