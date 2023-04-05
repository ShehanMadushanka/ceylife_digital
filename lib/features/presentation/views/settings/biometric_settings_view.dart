import 'dart:io';

import 'package:bloc/src/bloc.dart';
import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/features/data/datasources/shared_preference.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/settings/settings_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/settings/settings_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/settings/settings_state.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_appbar.dart';
import 'package:ceylife_digital/features/presentation/views/base_view.dart';
import 'package:ceylife_digital/features/presentation/views/settings/widgets/sub_setting_view.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:ceylife_digital/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BiometricSettingsView extends BaseView {
  @override
  _BiometricSettingsState createState() => _BiometricSettingsState();
}

class _BiometricSettingsState extends BaseViewState<BiometricSettingsView> {
  final bloc = injection<SettingsBloc>();
  final _sharedData = injection<AppSharedData>();
  var _biometricType;
  bool _biometricEnable = false;

  @override
  void initState() {
    super.initState();
    biometricServices.getAvailableType().then((value) {
      if (mounted)
        setState(() {
          _biometricType = value;
        });
    });

    setState(() {
      _biometricEnable = AppConstants.IS_BIOMETRIC_ENABLED;
    });
  }

  @override
  Widget buildView(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, Routes.SETTINGS_VIEW);
        return false;
      },
      child: Scaffold(
        appBar: CeylifeAppbar(
          elevation: 0,
          title: Text(
            AppLocalizations.of(context).translate("settings_app_bar_title"),
            style: TextStyle(
              color: AppColors.appBarTitle,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, Routes.SETTINGS_VIEW);
            },
            icon: SvgPicture.asset(AppImages.appBarBackIcon),
          ),
        ),
        body: BlocProvider<SettingsBloc>(
          create: (_) => bloc,
          child: BlocListener<SettingsBloc, BaseState<SettingsState>>(
            cubit: bloc,
            listener: (context, state) {
              if (state is BiometricEnableSuccessState) {
                if (state.shouldEnabled)
                  _sharedData.setBiometric('YES');
                else
                  _sharedData.setBiometric('NO');

                AppConstants.IS_BIOMETRIC_ENABLED = state.shouldEnabled;

                setState(() {
                  _biometricEnable = state.shouldEnabled;
                });
              }else if(state is BiometricEnableFailedState){
                setState(() {
                  _biometricEnable = false;
                });
              }
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 6.0, vertical: 10),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  (_biometricType == Biometric.FACE)
                      ? SubSettingItemWidget(
                          label: AppLocalizations.of(context)
                              .translate("label_face_id"),
                          callback: (value) {
                            bloc.add(BiometricRegistrationEvent(
                                isBiometricEnabled: value));
                          },
                          subLabel: AppLocalizations.of(context)
                              .translate("label_enable_face_id"),
                          defaultValue: _biometricEnable,
                        )
                      : SizedBox.shrink(),
                  (_biometricType == Biometric.FINGERPRINT)
                      ? SubSettingItemWidget(
                          label:
                              '${Platform.isIOS ? AppLocalizations.of(context).translate("label_touch_id") : AppLocalizations.of(context).translate("label_fingerprint_id")}',
                          callback: (value) {
                            bloc.add(BiometricRegistrationEvent(
                                isBiometricEnabled: value));
                          },
                          subLabel: Platform.isIOS
                              ? ErrorMessages().mapAPIErrorCode(
                                  ErrorMessages.APP_ENABLE_DISABLE_TOUCH_ID, "")
                              : ErrorMessages().mapAPIErrorCode(
                                  ErrorMessages
                                      .APP_ENABLE_DISABLE_FINGERPRINT_ID,
                                  ""),
                          defaultValue: _biometricEnable,
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Bloc getBloc() {
    return bloc;
  }
}

class SettingItemWidget extends StatelessWidget {
  final String label;
  final VoidCallback callback;
  final bool isSettingEnabled;

  SettingItemWidget({this.label, this.callback, this.isSettingEnabled = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          highlightColor: Colors.transparent,
          onTap: () {
            callback();
          },
          child: IgnorePointer(
            child: ListTile(
              title: Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: isSettingEnabled
                      ? AppColors.primaryBlackColor
                      : AppColors.primaryBlackColor.withOpacity(0.3),
                ),
              ),
              trailing: IconButton(
                onPressed: callback,
                icon: SvgPicture.asset(
                  AppImages.icFrontArrow,
                  color: isSettingEnabled
                      ? AppColors.primaryBackgroundColor
                      : AppColors.primaryBackgroundColor.withOpacity(0.3),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Divider(
            height: 1,
            thickness: 1,
            color: isSettingEnabled
                ? AppColors.dividerColor.withOpacity(0.6)
                : AppColors.dividerColor.withOpacity(0.3),
          ),
        ),
      ],
    );
  }
}
