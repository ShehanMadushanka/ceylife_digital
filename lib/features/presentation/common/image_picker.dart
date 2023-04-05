import 'dart:io';
import 'dart:ui';

import 'package:ceylife_digital/core/service/app_permission.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_icons_icons.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/image_cropper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerComponent extends StatelessWidget {
  final Function(File) onItemSelected;

  ImagePickerComponent(this.onItemSelected);

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
                    padding: const EdgeInsets.only(
                        top: 25, left: 30, right: 30, bottom: 30),
                    child: Column(
                      children: [
                        Text(
                          AppLocalizations.of(context).translate('label_change_profile_picture'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: AppColors.appbarPrimary),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            AppPermissionManager.requestCameraPermission(
                                context, () async {
                              PickedFile file = await ImagePicker()
                                  .getImage(source: ImageSource.camera, imageQuality: 15,);
                              File cropped =
                                  await AppImageCropper().getCroppedImage(file);
                              onItemSelected(cropped);
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.buttonBorderColor)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 12, top: 21, bottom: 21, right: 18),
                                  child: Icon(
                                    CeylifeIcons.ic_camera,
                                    color: AppColors.primaryHeadingTextColor,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    AppLocalizations.of(context).translate('label_change_profile_picture_camera'),
                                    maxLines: 3,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            AppColors.primaryHeadingTextColor),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            AppPermissionManager.requestGalleryPermission(
                                context, () async {
                              PickedFile file = await ImagePicker()
                                  .getImage(source: ImageSource.gallery, imageQuality: 15);
                              File cropped =
                                  await AppImageCropper().getCroppedImage(file);
                              onItemSelected(cropped);
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.buttonBorderColor)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 12, top: 21, bottom: 21, right: 18),
                                  child: Icon(
                                    CeylifeIcons.ic_gallery,
                                    color: AppColors.primaryHeadingTextColor,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    AppLocalizations.of(context).translate('label_change_profile_picture_gallery'),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            AppColors.primaryHeadingTextColor),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
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

class ImagePickerDialog {
  final BuildContext context;
  final Function(File) onItemSelected;

  ImagePickerDialog(this.context, {this.onItemSelected});

  showImagePicker() {
    showGeneralDialog(
        context: context,
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: ImagePickerComponent(onItemSelected),
            ),
          );
        },
        barrierDismissible: true,
        barrierLabel: '',
        transitionDuration: Duration(milliseconds: 200),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {});
  }
}
