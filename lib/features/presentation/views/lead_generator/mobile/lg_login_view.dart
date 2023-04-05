import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/login/login_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/login/login_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/login/login_state.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_button.dart';
import 'package:ceylife_digital/features/presentation/common/ceylinco_edit_text_field.dart';
import 'package:ceylife_digital/features/presentation/views/base_view.dart';
import 'package:ceylife_digital/features/presentation/views/lead_generator/data/lead_data_bean.dart';
import 'package:ceylife_digital/features/presentation/views/user_registration/widgets/get_help.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/device_info.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:ceylife_digital/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class LeadGeneratorLoginView extends BaseView {
  final LeadData leadData;

  LeadGeneratorLoginView({this.leadData});

  @override
  _LeadGeneratorLoginViewState createState() => _LeadGeneratorLoginViewState();
}

class _LeadGeneratorLoginViewState
    extends BaseViewState<LeadGeneratorLoginView> {
  var _bloc = injection<LoginBloc>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  DeviceInfo _deviceInfo;
  String _username = "";

  @override
  void initState() {
    initDeviceInfo();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  initDeviceInfo() async {
    _deviceInfo = DeviceInfo();
    _deviceInfo.initDeviceInfo();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc.add(GetCacheUser());
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Lead Generator Registration',
          style: TextStyle(color: AppColors.appBarTitle, fontSize: 18),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(AppImages.appBarBackIcon),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 100),
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(
                0xff790013,
              ),
              Color(0xff370009),
            ],
          ),
        ),
        child: BlocProvider<LoginBloc>(
          create: (_) => _bloc,
          child: BlocListener<LoginBloc, BaseState<LoginState>>(
            cubit: _bloc,
            listener: (context, state) {
              if (state is CacheUserSuccessState) {
                if (state.user != null &&
                    state.user.username != null &&
                    state.user.username.isNotEmpty) {
                  setState(() {
                    _username = state.user.username;
                  });
                }
              } else if (state is LoginLoadedState) {
                _bloc.appSharedData.setCacheUser(isLeadGenerator: false);

                showCeylifeDialog(
                  alertType: AlertType.FAIL,
                  dialogContentWidget: Column(
                    children: [
                      SvgPicture.asset(AppImages.icSetBankAccount, height: 188),
                    ],
                  ),
                  message:
                      'It is mandatory to set your bank account to earn as a Lead Generator. You can submit account details now or later.',
                  title: 'Set Your Bank Account',
                  negativeButtonText: 'May be later',
                  positiveButtonText: 'Submit  Account Details Now',
                  onNegativeCallback: () {
                    Navigator.pushReplacementNamed(
                      context,
                      Routes.LEAD_GENERATOR_DASHBOARD_VIEW,
                    );
                  },
                  onPositiveCallback: () {
                    Navigator.pushNamed(context, Routes.BANK_DETAILS_VIEW, arguments: widget.leadData);
                  },
                );
              } else if (state is ValidationFailedState) {
                showCeylifeDialog(
                    title:
                        AppLocalizations.of(context).translate('title_error'),
                    message:
                        AppLocalizations.of(context).translate(state.error));
              } else if (state is LoginFailedState) {
                showCeylifeDialog(
                  title: AppLocalizations.of(context).translate('title_error'),
                  message: state.error,
                );
              }
            },
            child: Container(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          minWidth: constraints.maxWidth,
                          minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppImages.icVerify,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Log in to the app to continue',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 29),
                                  child: Text(
                                    'You have registered as a policy holder for Ceylife Digital App. No registration is required.',
                                    style: TextStyle(
                                      color: AppColors.indianRedLightColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            CeyLifeTextField(
                              hint: AppLocalizations.of(context)
                                  .translate("login_user_id"),
                              controller: _usernameController,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            CeyLifeTextField(
                              obscureText: true,
                              hint: AppLocalizations.of(context)
                                  .translate("login_password"),
                              controller: _passwordController,
                            ),
                            Spacer(),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              children: [
                                CeyLifeButton(
                                  buttonType: ButtonType.ENABLED,
                                  buttonText: 'Continue',
                                  onTapButton: () {
                                    _bloc.add(GetLoginEvent(
                                      username: _usernameController.text,
                                      password: _passwordController.text,
                                      deviceInfo: _deviceInfo,
                                      signInType: SignInType.PASSWORD,
                                    ));
                                  },
                                ),
                                GetHelpView(),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Bloc getBloc() => _bloc;
}
