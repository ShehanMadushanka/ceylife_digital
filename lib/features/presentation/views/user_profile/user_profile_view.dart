import 'dart:convert';
import 'dart:io';

import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/features/domain/entities/response/customer_initiated_category_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/login_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/profile/profile_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/profile/profile_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/profile/profile_state.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_anim_widget.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_appbar.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_icons_icons.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_primary_button.dart';
import 'package:ceylife_digital/features/presentation/common/image_picker.dart';
import 'package:ceylife_digital/features/presentation/views/base_view.dart';
import 'package:ceylife_digital/features/presentation/views/user_profile/widgets/advice.dart';
import 'package:ceylife_digital/features/presentation/views/user_profile/widgets/nick_change_dialog.dart';
import 'package:ceylife_digital/features/presentation/views/user_profile/widgets/request_info_change_dialog.dart';
import 'package:ceylife_digital/utils/app_animation.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:ceylife_digital/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class UserProfileView extends BaseView {
  final ProfileEntity profile;

  UserProfileView(this.profile);

  @override
  _UserProfileViewState createState() => _UserProfileViewState();
}

class _UserProfileViewState extends BaseViewState<UserProfileView>
    with TickerProviderStateMixin {
  final bloc = injection<ProfileBloc>();
  AnimationController _animationController;
  AnimationController _stepperAnimationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
    _stepperAnimationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _stepperAnimationController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CeylifeAppbar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context).translate("user_profile_appbar_title"),
          style: TextStyle(color: AppColors.appBarTitle, fontSize: 18),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(AppImages.appBarBackIcon),
        ),
      ),
      body: BlocProvider<ProfileBloc>(
        create: (_) => bloc,
        child: BlocListener<ProfileBloc, BaseState<ProfileState>>(
          cubit: bloc,
          listener: (context, state) {
            if (state is UpdateProfileImageSuccessState) {
              bloc.add(CacheProfileDataEvent(
                  dataType: 2, data: state.userProfileResponseEntity.data));
              setState(() {
                widget.profile.profilePictureUrl =
                    state.userProfileResponseEntity.data;
              });
            } else if (state is UpdateNicknameSuccessState) {
              bloc.add(CacheProfileDataEvent(
                  dataType: 1, data: state.userProfileResponseEntity.data));
              setState(() {
                widget.profile.nickName = state.userProfileResponseEntity.data;
              });
            } else if (state is CustomerInitiatedCategoriesSuccessState) {
              if (state.categoryResponseEntity == null ||
                  state.categoryResponseEntity.serviceRequestCategories
                      .isEmpty) {
                showCeylifeDialog(
                  title: AppLocalizations.of(context).translate("title_error"),
                  positiveButtonText:
                      AppLocalizations.of(context).translate("ok_label"),
                  onPositiveCallback: () {},
                  message: AppLocalizations.of(context)
                      .translate("no_data_found_label"),
                );
              } else {
                setState(() {
                  _requestChange(state.categoryResponseEntity);
                });
              }
            } else if (state is InitiateCustomerServiceSuccessState) {
              showCeylifeDialog(
                title:
                    '${AppLocalizations.of(context).translate("title_success")}!',
                positiveButtonText: AppLocalizations.of(context)
                    .translate("got_it_button_label"),
                onPositiveCallback: () {},
                message:
                    '${AppLocalizations.of(context).translate("label_your")} ${state.requestType} ${AppLocalizations.of(context).translate("label_change_request_success")}',
                dialogContentWidget: Column(
                  children: [
                    CeylifeAnimWidget(
                        controller: _animationController,
                        anim: AppAnimation.animSuccess)
                  ],
                ),
              );
            } else if (state is RequestPendingErrorState) {
              showCeylifeDialog(
                title: AppLocalizations.of(context)
                    .translate("title_previous_request_pending"),
                positiveButtonText: AppLocalizations.of(context)
                    .translate("label_check_previous_requests"),
                onPositiveCallback: () {
                  Navigator.pushNamed(
                      context, Routes.CUSTOMER_SERVICE_REQUEST_ROOT_VIEW,
                      arguments: true);
                },
                onNegativeCallback: () {},
                alertType: AlertType.FAIL,
                negativeButtonText: AppLocalizations.of(context)
                    .translate('cancel_button_label'),
                message:
                    '${AppLocalizations.of(context).translate('label_previous_request_pending_desc_sorry')} ${state.nickname}, ${AppLocalizations.of(context).translate('label_multiple_request_failed')}',
                dialogContentWidget: Column(
                  children: [
                    CeylifeAnimWidget(
                        controller: _animationController,
                        anim: AppAnimation.animFailed)
                  ],
                ),
              );
            }
          },
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) =>
                SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minWidth: constraints.maxWidth,
                    minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 21, vertical: 20),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ProfileImageWidget(
                                imageURL: widget.profile.profilePictureUrl,
                                onTap: (File imgData) {
                                  bloc.add(UpdateProfileImageEvent(
                                      imageData: base64Encode(
                                          imgData.readAsBytesSync())));
                                }),
                            _NicknameWidget(
                              nickname: widget.profile.nickName != null
                                  ? widget.profile.nickName
                                  : "",
                              onChange: (updatedNickname) {
                                bloc.add(UpdateNicknameEvent(
                                    nickname: updatedNickname));
                              },
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            AdviceWidget(
                              advice: AppLocalizations.of(context)
                                  .translate('user_profile_top_info'),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            widget.profile.fullName != null &&
                                    widget.profile.fullName.isNotEmpty
                                ? ProfileData(
                                    title: AppLocalizations.of(context)
                                        .translate('label_name_initial'),
                                    value: widget.profile.fullName,
                                  )
                                : SizedBox.shrink(),
                            widget.profile.email != null &&
                                    widget.profile.email.isNotEmpty
                                ? ProfileData(
                                    title: AppLocalizations.of(context)
                                        .translate('label_email'),
                                    value: widget.profile.email,
                                  )
                                : SizedBox.shrink(),
                            widget.profile.nicNo != null &&
                                    widget.profile.nicNo.isNotEmpty
                                ? ProfileData(
                                    title: AppLocalizations.of(context)
                                        .translate('label_nic'),
                                    value: widget.profile.nicNo,
                                  )
                                : SizedBox.shrink(),
                            widget.profile.dateOfBirth != null &&
                                    widget.profile.dateOfBirth.isNotEmpty
                                ? ProfileData(
                                    title: AppLocalizations.of(context)
                                        .translate('label_dob'),
                                    value: widget.profile.dateOfBirth,
                                  )
                                : SizedBox.shrink(),
                            widget.profile.mobileNo != null &&
                                    widget.profile.mobileNo.isNotEmpty
                                ? ProfileData(
                                    title: AppLocalizations.of(context)
                                        .translate('label_mobile'),
                                    value: widget.profile.mobileNo,
                                  )
                                : SizedBox.shrink(),
                            ProfileData(
                              title: AppLocalizations.of(context)
                                  .translate('label_permenent_address'),
                              value:
                                  "${widget.profile.addressLine1}, ${widget.profile.addressLine2}, ${widget.profile.city}",
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        /*Spacer(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: CeylifePrimaryButton(
                            buttonLabel: AppLocalizations.of(context)
                                .translate('request_change_button'),
                            onTap: () {
                              bloc.add(GetCustomerInitiatedCategoriesEvent(
                                  serviceType:
                                      AppConstants.SERVICE_REQUEST_PROFILE));
                            },
                          ),
                        ),*/
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _requestChange(
      CustomerInitiatedCategoryResponseEntity categoryResponseEntity) {
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: GestureDetector(
                onTap: () =>
                    FocusScope.of(context).requestFocus(new FocusNode()),
                child: RequestInfoChangeDialog(
                  infoChangeRequestDataList: categoryResponseEntity
                      .serviceRequestCategories
                      .map((e) => InfoChangeRequestData(
                          requestType: e.description,
                          id: e.serviceRequestCategoryId))
                      .toList(),
                  onUpdateRequestChangeData: (updatedData, comment) {
                    bloc.add(InitiateCustomerServiceEvent(
                        comment: comment,
                        requestType: updatedData.requestType,
                        serviceRequestCategoryId: updatedData.id));
                  },
                ),
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {});
  }

  @override
  Bloc getBloc() {
    return bloc;
  }
}

class ProfileData extends StatelessWidget {
  final String title;
  final String value;

  const ProfileData({this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.primaryBlackColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryHeadingTextColor,
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class _NicknameWidget extends StatelessWidget {
  final Function(String) onChange;
  final String nickname;

  const _NicknameWidget({this.onChange, this.nickname});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          AppLocalizations.of(context)
              .translate("user_details_hint_nickname"),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.textColorAmber,
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          nickname,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.textColorAmber,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        InkWell(
          onTap: () => nickChange(context),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(CeylifeIcons.ic_pencil, size: 12),
                SizedBox(
                  width: 8,
                ),
                Text(
                  AppLocalizations.of(context)
                      .translate("change_label"),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryBlackColor,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  void nickChange(BuildContext context) {
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: NickChangeDialog(
                currentNickname: nickname,
                onUpdate: (updatedNick) {
                  onChange(updatedNick);
                },
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {});
  }
}

class ProfileImageWidget extends StatefulWidget {
  final Function(File) onTap;
  final String imageURL;

  ProfileImageWidget({this.onTap, this.imageURL});

  @override
  _ProfileImageWidgetState createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {
  File _localImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ImagePickerDialog(context, onItemSelected: (file) {
          setState(() {
            _localImage = file;
            widget.onTap(file);
          });
        }).showImagePicker();
      },
      child: SizedBox(
        child: CircleAvatar(
          radius: 45.0,
          backgroundColor: AppColors.redwoodOne,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Align(
              alignment: Alignment(1.2, 1.2),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: SvgPicture.asset(
                  AppImages.icChangePicture,
                  width: 30,
                  height: 30,
                ),
              ),
            ),
            radius: 42.0,
            backgroundImage: setProfileImage(),
          ),
        ),
      ),
    );
  }

  Object setProfileImage() {
    if (widget.imageURL != null && widget.imageURL.isNotEmpty) {
      return NetworkImage(widget.imageURL);
    } else {
      return AssetImage(
        AppImages.icDefaultAvatar,
      );
    }
  }
}
