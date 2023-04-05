import 'package:ceylife_digital/features/domain/entities/response/login_response_entity.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/navigation_routes.dart';
import 'package:flutter/material.dart';

class CeylifeDrawerHeader extends StatelessWidget {
  final ProfileEntity profile;
  final String userName;
  final String lastLogin;

  const CeylifeDrawerHeader(
      {Key key, this.profile, this.userName, this.lastLogin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryBackgroundColor.withOpacity(0.91),
            Color(0xFF5F101E).withOpacity(0.91)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0, 1],
        ),
      ),
      padding: EdgeInsets.all(15),
      child: Wrap(
        direction: Axis.vertical,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.appHighlightColor,
                  child: CircleAvatar(
                    radius: 38,
                    backgroundColor: Colors.white,
                    backgroundImage: (profile.profilePictureUrl == null ||
                            profile.profilePictureUrl.isEmpty)
                        ? AssetImage(
                            AppImages.icDefaultAvatar,
                          )
                        : NetworkImage(
                            profile.profilePictureUrl,
                          ),
                  ),
                ),
              ),
              SizedBox(
                width: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        userName!=null?userName:"",
                        style: TextStyle(
                          color: AppColors.textColorRedwood,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),

                      SizedBox(height: 8,),
                      Text(
                        '${AppLocalizations.of(context).translate("login_user_id")} : ${profile.username}',
                        style: TextStyle(
                          color: AppColors.textColorRedwood,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.start,
                      ),

                      Text(
                        '${AppLocalizations.of(context).translate("label_last_login")} : ' + lastLogin,
                        style: TextStyle(
                          color: AppColors.textColorRedwood,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  OutlineButton(
                    color: Colors.white,
                    borderSide: BorderSide(color: Colors.white, width: 1),
                    highlightedBorderColor: AppColors.primaryBackgroundColor,
                    highlightColor: AppColors.appHighlightColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(0.0)),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, Routes.USER_PROFILE_VIEW,
                          arguments: profile);
                    },
                    child: Text(
                      AppLocalizations.of(context).translate("label_my_profile"),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
