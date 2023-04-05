import 'package:bloc/src/bloc.dart';
import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/policy/policy_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/policy/policy_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/policy/policy_state.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_button.dart';
import 'package:ceylife_digital/features/presentation/common/ceylinco_edit_text_field.dart';
import 'package:ceylife_digital/features/presentation/views/common/data/otp_request_data.dart';
import 'package:ceylife_digital/features/presentation/views/common/data/otp_response_data.dart';
import 'package:ceylife_digital/features/presentation/views/lead_generator/data/lead_data_bean.dart';
import 'package:ceylife_digital/features/presentation/views/user_registration/widgets/get_help.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:ceylife_digital/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../base_view.dart';

class LeadGeneratorRegistrationView extends BaseView {
  @override
  _LeadGeneratorRegistrationViewState createState() =>
      _LeadGeneratorRegistrationViewState();
}

class _LeadGeneratorRegistrationViewState
    extends BaseViewState<LeadGeneratorRegistrationView> {
  final policyBloc = injection<PolicyBloc>();
  TextEditingController _nicController = TextEditingController();

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
      body: BlocProvider<PolicyBloc>(
        create: (_) => policyBloc,
        child: BlocListener<PolicyBloc, BaseState<PolicyState>>(
          cubit: policyBloc,
          listener: (context, state) {
            if (state is PolicyLoadedState) {
              if (state.policyResponseEntity.userType ==
                  AppConstants.CLIENT_USER_TYPE_MOBILE_USER) {
                Navigator.pushNamed(context, Routes.LEAD_GENERATOR_LOGIN_VIEW,
                    arguments: LeadData(
                        userType: state.policyResponseEntity.userType,
                        key: _nicController.text));
              } else if (state.policyResponseEntity.userType ==
                  AppConstants.CLIENT_USER_TYPE_VERIFIED_WEB_USER || state.policyResponseEntity.userType ==
                  AppConstants.CLIENT_USER_TYPE_NON_VERIFIED_WEB_USER) {
                Navigator.pushNamed(
                        context, Routes.COMMON_OTP_VERIFICATION_VIEW,
                        arguments: OTPRequestData(
                            keyType: 1,
                            otpReference: state.policyResponseEntity.otpRef,
                            maskedEmail: state.policyResponseEntity.email,
                            maskedMobile: state.policyResponseEntity.mobileNo,
                            key: _nicController.text,
                            appBarTitle: AppLocalizations.of(context).translate(
                                "lead_generator_registration_app_bar_title")))
                    .then((otpResponseData) {
                  if (otpResponseData is OTPResponseData) {
                    if (otpResponseData.isVerificationSuccess) {
                      LeadData leadData = LeadData(
                        userType: state.policyResponseEntity.userType,
                        key: _nicController.text,
                      );
                      Navigator.pushReplacementNamed(
                          context, Routes.LEAD_GENERATOR_USER_DETAILS_VIEW,
                          arguments: leadData);
                    } else
                      Navigator.pop(context);
                  }
                });
              }else if(state.policyResponseEntity.userType ==
                  AppConstants.CLIENT_USER_TYPE_NEW_USER){
                LeadData leadData = LeadData(
                  userType: state.policyResponseEntity.userType,
                  key: _nicController.text,
                );
                Navigator.pushReplacementNamed(
                    context, Routes.LEAD_GENERATOR_USER_DETAILS_VIEW,
                    arguments: leadData);
              }
            } else if (state is ValidationFailedState) {
              showCeylifeDialog(
                  title: AppLocalizations.of(context).translate('title_error'),
                  message: AppLocalizations.of(context).translate(state.error));
            } else if (state is PolicyFailedState) {
              showCeylifeDialog(
                  title: AppLocalizations.of(context).translate('title_error'),
                  message: state.error);
            }
          },
          child: Container(
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
                            Image.asset(AppImages.icReferral,
                                width: 168, height: 171),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'How to earn from leads?',
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
                                    'You will receive a commission for each successful policy created on your referral. It’s a simple and great way to earn some extra.',
                                    style: TextStyle(
                                      color: AppColors.indianRedLightColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 29),
                                  child: Text(
                                    'No matter whether you are a policyholder or not. After the registration only you have to do is refer our products to people you know.',
                                    style: TextStyle(
                                      color: AppColors.indianRedLightColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 29),
                                  child: Text(
                                    'Enter your NIC number to start the registration.',
                                    style: TextStyle(
                                      color: AppColors.indianRedLightColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CeyLifeTextField(
                              inputFormatter: r'[0-9vVxX]',
                              controller: _nicController,
                              onTextChanged: (value) {
                                setState(() {});
                              },
                              length: 12,
                              hint: AppLocalizations.of(context).translate(
                                  "policy_verification_hint_nic_number"),
                            ),
                            Spacer(),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              children: [
                                CeyLifeButton(
                                  buttonType: ButtonType.ENABLED,
                                  buttonText: 'Start Registration',
                                  onTapButton: () {
                                    policyBloc.add(GetPolicyEvent(
                                        registrationType: AppConstants
                                            .LEAD_GENERATOR_REGISTRATION,
                                        key: _nicController.text,
                                        keyType: 1));
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
  Bloc getBloc() {
    return policyBloc;
  }
}
