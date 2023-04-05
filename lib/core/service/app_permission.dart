import 'dart:ui';

import 'package:ceylife_digital/features/presentation/common/ceylife_primary_button.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:easy_permission_validator/easy_permission_validator.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AppPermissionManager {
  static final String appName = 'Ceylife Digital';

  static requestCameraPermission(
      BuildContext context, VoidCallback onGranted) async {
    final permissionValidator = EasyPermissionValidator(
        context: context,
        appName: appName,
        customDialog: AppPermissionDialog());
    var result = await permissionValidator.camera();
    if (result) onGranted();
  }

  static requestExternalStoragePermission(
      BuildContext context, VoidCallback onGranted) async {
    final permissionValidator = EasyPermissionValidator(
        context: context,
        appName: appName,
        customDialog: AppPermissionDialog());
    var result = await permissionValidator.storage();
    if (result) onGranted();
  }

  static requestGalleryPermission(
      BuildContext context, VoidCallback onGranted) async {
    final permissionValidator = EasyPermissionValidator(
        context: context,
        appName: appName,
        customDialog: AppPermissionDialog());
    var result = await permissionValidator.mediaLibrary();
    if (result) onGranted();
  }
}

class AppPermissionDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
      child: Container(
          alignment: FractionalOffset.center,
          padding: const EdgeInsets.all(20.0),
          child: Wrap(
            children: [
              Material(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Colors.white,
                          Color(0xFFE1E1E1),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.11, 0.58]),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          "Ceylife Digital",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: AppColors.textColorMaroon),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: Text(
                            "You have to enable the required\npermissions to use the action.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: AppColors.primaryBlackColor),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 42),
                          child: CeylifePrimaryButton(
                            buttonLabel: "Go to settings",
                            onTap: () {
                              openAppSettings();
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 57,
                            child: Center(
                              child: Text(
                                'Cancel',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: AppColors.newsHeadlineColor),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
