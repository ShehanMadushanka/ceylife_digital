import 'package:bloc/src/bloc.dart';
import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/features/domain/entities/response/login_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/settings/settings_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/settings/settings_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/settings/settings_state.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_anim_widget.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_appbar.dart';
import 'package:ceylife_digital/features/presentation/common/user_verification_dialog.dart';
import 'package:ceylife_digital/features/presentation/views/base_view.dart';
import 'package:ceylife_digital/utils/app_animation.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/device_info.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:ceylife_digital/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsView extends BaseView {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends BaseViewState<SettingsView>
    with TickerProviderStateMixin {
  final bloc = injection<SettingsBloc>();
  bool _isBiometricEnrolled = false;
  bool _isBiometricEnabled = false;
  AnimationController _animationController;
  ProfileEntity _user;
  DeviceInfo _deviceInfo;

  @override
  void initState() {
    super.initState();
    initDeviceInfo();
    _animationController = AnimationController(vsync: this);
    biometricServices.isEnrolled().then((enrolled) {
      setState(() {
        _isBiometricEnrolled = enrolled;
      });
    });

    bloc.add(GetCacheUserEvent());
  }

  initDeviceInfo() async {
    _deviceInfo = DeviceInfo();
    _deviceInfo.initDeviceInfo();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      _isBiometricEnabled = AppConstants.IS_BIOMETRIC_ENABLED;
    });
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
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
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(AppImages.appBarBackIcon),
        ),
      ),
      body: BlocProvider<SettingsBloc>(
        create: (_) => bloc,
        child: BlocListener<SettingsBloc, BaseState<SettingsState>>(
          cubit: bloc,
          listener: (context, state) {
            if (state is CacheUserSuccessState) {
              setState(() {
                _user = state.profileEntity;
              });
            } else if (state is AuthSuccessState) {
              Navigator.pushReplacementNamed(
                  context, Routes.BIOMETRIC_SETTINGS_VIEW);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: ListView(
              children: [
                SettingItemWidget(
                  label: AppLocalizations.of(context)
                      .translate("biometrics_settings_label"),
                  callback: () {
                    if (_isBiometricEnrolled) {
                      if (_isBiometricEnabled) {
                        biometricServices.authenticate().then((success) async {
                          if (success) {
                            bloc.add(GetLoginEvent(
                                signInType: SignInType.BIOMETRIC,
                                deviceInfo: _deviceInfo));
                          } else {
                            UserVerificationDialog().showDialog(
                              context,
                              biometricServices: biometricServices,
                              authCredentials: (username, password) {
                                bloc.add(GetLoginEvent(
                                    signInType: SignInType.PASSWORD,
                                    deviceInfo: _deviceInfo,
                                    password: password,
                                    username: username));
                              },
                              biometricStatus: (status) {
                                if (status)
                                  bloc.add(GetLoginEvent(
                                      signInType: SignInType.BIOMETRIC,
                                      deviceInfo: _deviceInfo));
                              },
                            );
                          }
                        });
                      } else {
                        UserVerificationDialog()
                            .showDialog(context, biometricServices: null,
                                authCredentials: (username, password) {
                          bloc.add(GetLoginEvent(
                              signInType: SignInType.PASSWORD,
                              deviceInfo: _deviceInfo,
                              password: password,
                              username: username));
                        }, biometricStatus: (status) {
                          if (status)
                            bloc.add(GetLoginEvent(
                                signInType: SignInType.BIOMETRIC,
                                deviceInfo: _deviceInfo));
                        });
                      }
                    } else {
                      showCeylifeDialog(
                        title: AppLocalizations.of(context)
                            .translate("label_title_device_not_supported"),
                        positiveButtonText: AppLocalizations.of(context)
                            .translate("got_it_button_label"),
                        onPositiveCallback: () {},
                        alertType: AlertType.FAIL,
                        message:
                            '${AppLocalizations.of(context).translate('label_previous_request_pending_desc_sorry')} ${_user.nickName}, ${AppLocalizations.of(context).translate('label_desc_device_not_supported')}',
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
                  isSettingEnabled: _isBiometricEnrolled,
                ),
              ],
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
