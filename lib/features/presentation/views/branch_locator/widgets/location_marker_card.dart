import 'package:ceylife_digital/features/domain/entities/response/branch_response_entity.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_icons_icons.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationMarkerCard extends StatelessWidget {
  const LocationMarkerCard({
    Key key,
    this.branchResponseEntity,
    this.closeFunction,
  }) : super(key: key);

  final BranchEntity branchResponseEntity;
  final Function closeFunction;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(12),
      elevation: 1,
      child: Wrap(
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(15),
                  spreadRadius: 0,
                  blurRadius: 12,
                  offset: Offset(0, 5), // changes position of shadow
                ),
              ],
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        branchResponseEntity.title,
                        style: TextStyle(
                          color: AppColors.textColorBrainRed,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      InkWell(
                        child: SvgPicture.asset(
                          AppImages.close,
                        ),
                        onTap: () {
                          closeFunction.call();
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    branchResponseEntity.address,
                    style: TextStyle(
                      color: AppColors.textColorAshDark2,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: SvgPicture.asset(
                          AppImages.clock,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Text(
                          branchResponseEntity.availableTime,
                          style: TextStyle(
                            color: AppColors.primaryAshColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 25,
                      ),
                      InkWell(
                          onTap: () {
                            launch(
                                "tel:${int.parse(branchResponseEntity.contact)}", enableJavaScript: false);
                          },
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Icon(
                                Icons.call,
                                color: AppColors.primaryHeadingTextColor,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                AppLocalizations.of(context)
                                    .translate("contact"),
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textColorAshDark3),
                              )
                            ],
                          )),
                      Spacer(),
                      InkWell(
                          onTap: () async {
                            await launchMap(
                                double.parse(branchResponseEntity.latitude),
                                double.parse(branchResponseEntity.longitude),
                                branchResponseEntity.title);
                          },
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Icon(
                                CeylifeIcons.ic_direction,
                                color: AppColors.primaryHeadingTextColor,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                AppLocalizations.of(context)
                                    .translate("directions"),
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textColorAshDark3),
                              )
                            ],
                          )),
                      SizedBox(
                        width: 25,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  launchMap(double latitude, double longitude, String title) async {
    final availableMaps = await MapLauncher.installedMaps;
    await availableMaps.first.showMarker(
      coords: Coords(latitude, longitude),
      title: title,
    );
  }
}
