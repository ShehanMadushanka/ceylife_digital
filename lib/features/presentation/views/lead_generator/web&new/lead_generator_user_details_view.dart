import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/features/domain/entities/request/branches_request_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/user_details/user_details_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/user_details/user_details_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/user_details/user_details_state.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_button.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_icons_icons.dart';
import 'package:ceylife_digital/features/presentation/common/ceylinco_edit_text_field.dart';
import 'package:ceylife_digital/features/presentation/views/base_view.dart';
import 'package:ceylife_digital/features/presentation/views/common/common_item_picker.dart';
import 'package:ceylife_digital/features/presentation/views/common/data/bottom_sheet_data.dart';
import 'package:ceylife_digital/features/presentation/views/common/data/otp_request_data.dart';
import 'package:ceylife_digital/features/presentation/views/common/data/otp_response_data.dart';
import 'package:ceylife_digital/features/presentation/views/lead_generator/data/lead_data_bean.dart';
import 'package:ceylife_digital/features/presentation/views/lead_generator/widgets/dropdown_field.dart';
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
import 'package:lottie/lottie.dart';

class LeadGeneratorUserDetailsView extends BaseView {
  final LeadData leadData;

  LeadGeneratorUserDetailsView({this.leadData});

  @override
  _LeadGeneratorUserDetailsViewState createState() =>
      _LeadGeneratorUserDetailsViewState();
}

class _LeadGeneratorUserDetailsViewState
    extends BaseViewState<LeadGeneratorUserDetailsView> {
  final bloc = injection<UserDetailsBloc>();
  final List<BottomSheetData> branchData = List();
  BottomSheetData _selectedBranch;

  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nicknameController = TextEditingController();
  TextEditingController _contactMobileController = TextEditingController();
  TextEditingController _contactHomeController = TextEditingController();
  TextEditingController _addressLine1Controller = TextEditingController();
  TextEditingController _addressLine2Controller = TextEditingController();
  TextEditingController _addressLine3Controller = TextEditingController();
  TextEditingController _branchController = TextEditingController();

  ButtonType _buttonType = ButtonType.ENABLED;

  @override
  void initState() {
    super.initState();
    bloc.add(GetBranchesEvent(
        branchesRequestEntity: BranchesRequestEntity(categoryCode: 'INSBR')));
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
      body: BlocProvider<UserDetailsBloc>(
        create: (_) => bloc,
        child: BlocListener<UserDetailsBloc, BaseState<UserDetailsState>>(
          cubit: bloc,
          listener: (context, state) {
            if (state is ValidateUserEmailSuccessState) {
              widget.leadData.nickname = _nicknameController.text;
              widget.leadData.email = _emailController.text;
              widget.leadData.nearestBranchId =
                  _selectedBranch != null ? _selectedBranch.id : null;
              widget.leadData.fullName = _fullNameController.text;
              widget.leadData.mobileNumber = _contactMobileController.text;
              widget.leadData.telephoneNumber = _contactHomeController.text;
              widget.leadData.address1 = _addressLine1Controller.text;
              widget.leadData.address2 = _addressLine2Controller.text;
              widget.leadData.address3 = _addressLine3Controller.text;

              if (widget.leadData.userType ==
                  AppConstants.CLIENT_USER_TYPE_NEW_USER) {
                bloc.add(
                  NewLeadGeneratorEvent(
                    email: widget.leadData.email,
                    contactNo: widget.leadData.mobileNumber,
                    contactNo2: widget.leadData.telephoneNumber,
                  ),
                );
              } else {
                Navigator.pushNamed(
                    context, Routes.LEAD_GENERATOR_ACCOUNT_CREATION_VIEW,
                    arguments: widget.leadData);
              }
            } else if (state is ValidateUserEmailFailedState) {
              showCeylifeDialog(
                  title: AppLocalizations.of(context).translate('title_error'),
                  message: AppLocalizations.of(context).translate(state.error));
            } else if (state is BranchesLoadedState) {
              branchData.clear();
              state.branchResponseEntity.branches.forEach((element) {
                branchData.add(BottomSheetData(
                    id: element.serviceProviderId, description: element.title));
              });
              setState(() {});
            } else if (state is BranchesFailedState) {
              showCeylifeDialog(
                  title: AppLocalizations.of(context).translate('title_error'),
                  message: state.error,
                  onPositiveCallback: () {
                    Navigator.pop(context);
                  });
            } else if (state is NewLeadGeneratorSuccessState) {
              if (widget.leadData.userType ==
                  AppConstants.CLIENT_USER_TYPE_NEW_USER) {
                Navigator.pushNamed(
                        context, Routes.COMMON_OTP_VERIFICATION_VIEW,
                        arguments: OTPRequestData(
                            keyType: 1,
                            otpReference: state
                                .verifyNewLeadGeneratorResponseEntity.otpRef,
                            maskedEmail: state
                                .verifyNewLeadGeneratorResponseEntity.email,
                            maskedMobile: state
                                .verifyNewLeadGeneratorResponseEntity.mobileNo,
                            key: widget.leadData.key,
                            appBarTitle: AppLocalizations.of(context).translate(
                                "lead_generator_registration_app_bar_title")))
                    .then((otpResponseData) {
                  if (otpResponseData is OTPResponseData) {
                    if (otpResponseData.isVerificationSuccess) {
                      Navigator.pushNamed(
                          context, Routes.LEAD_GENERATOR_ACCOUNT_CREATION_VIEW,
                          arguments: widget.leadData);
                    } else
                      Navigator.pop(context);
                  }
                });
              } else {
                Navigator.pushNamed(
                    context, Routes.LEAD_GENERATOR_ACCOUNT_CREATION_VIEW,
                    arguments: widget.leadData);
              }
            }else if(state is NewLeadGeneratorFailedState){
              showCeylifeDialog(
                  title: AppLocalizations.of(context).translate('title_error'),
                  message: state.error,
                  onPositiveCallback: () {
                    Navigator.pop(context);
                  });
            }else if(state is SubmitNearestBranchState){
              if(branchData.isNotEmpty){
                AppDataPicker(
                  title: "Select your nearest branch",
                    defaultSelectedItem: _selectedBranch,
                    height:
                    MediaQuery.of(context).size.height *
                        0.85,
                    isSearchable: true,
                    dataList: branchData,
                    onSelectItem: (item) {
                      setState(() {
                        _selectedBranch = item;
                        _branchController.text =
                            item.description;
                      });
                    }).showPicker(context);
              }
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
                builder: (BuildContext context, BoxConstraints constraints) {
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
                            SizedBox(
                              height: 5,
                            ),
                            Hero(
                              tag: 'icon',
                              child: Material(
                                type: MaterialType.transparency,
                                child: Lottie.asset(
                                  AppAnimation.animDetails,
                                  repeat: false,
                                  width: 200,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Hero(
                              tag: 'title',
                              child: Material(
                                type: MaterialType.transparency,
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate("user_details_label"),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 29),
                              child: Material(
                                type: MaterialType.transparency,
                                child: Text(
                                  AppLocalizations.of(context).translate(
                                      "lead_generator_user_details_description"),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 45,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                (widget.leadData != null &&
                                    (widget.leadData.userType ==
                                        AppConstants
                                            .CLIENT_USER_TYPE_POLICY_HOLDER || widget.leadData.userType ==
                                        AppConstants
                                            .CLIENT_USER_TYPE_NEW_USER))
                                    ? CeyLifeTextField(
                                        controller: _fullNameController,
                                        hint: 'Full Name',
                                        floatingEnabled: true,
                                      )
                                    : SizedBox.shrink(),
                                (widget.leadData != null &&
                                        (widget.leadData.userType ==
                                        AppConstants
                                            .CLIENT_USER_TYPE_POLICY_HOLDER || widget.leadData.userType ==
                                        AppConstants
                                            .CLIENT_USER_TYPE_NEW_USER))
                                    ? SizedBox(
                                        height: 30,
                                      )
                                    : SizedBox.shrink(),
                                CeyLifeTextField(
                                  controller: _nicknameController,
                                  hint: AppLocalizations.of(context)
                                      .translate("user_details_hint_nickname"),
                                  floatingEnabled: true,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                CeyLifeTextField(
                                  controller: _emailController,
                                  hint: AppLocalizations.of(context)
                                      .translate("user_details_hint_email"),
                                  floatingEnabled: true,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                (widget.leadData != null &&
                                        (widget.leadData.userType ==
                                        AppConstants
                                            .CLIENT_USER_TYPE_POLICY_HOLDER || widget.leadData.userType ==
                                        AppConstants
                                            .CLIENT_USER_TYPE_NEW_USER))
                                    ? CeyLifeTextField(
                                        controller: _contactMobileController,
                                        hint: 'Contact No. - Mobile',
                                        floatingEnabled: true,
                                      )
                                    : SizedBox.shrink(),
                                (widget.leadData != null &&
                                        (widget.leadData.userType ==
                                        AppConstants
                                            .CLIENT_USER_TYPE_POLICY_HOLDER || widget.leadData.userType ==
                                        AppConstants
                                            .CLIENT_USER_TYPE_NEW_USER))
                                    ? SizedBox(
                                        height: 30,
                                      )
                                    : SizedBox.shrink(),
                                (widget.leadData != null &&
                                        (widget.leadData.userType ==
                                        AppConstants
                                            .CLIENT_USER_TYPE_POLICY_HOLDER || widget.leadData.userType ==
                                        AppConstants
                                            .CLIENT_USER_TYPE_NEW_USER))
                                    ? CeyLifeTextField(
                                        controller: _contactHomeController,
                                        hint: 'Contact No. - Home ( Optional )',
                                        floatingEnabled: true,
                                      )
                                    : SizedBox.shrink(),
                                (widget.leadData != null &&
                                        (widget.leadData.userType ==
                                        AppConstants
                                            .CLIENT_USER_TYPE_POLICY_HOLDER || widget.leadData.userType ==
                                        AppConstants
                                            .CLIENT_USER_TYPE_NEW_USER))
                                    ? SizedBox(
                                        height: 40,
                                      )
                                    : SizedBox.shrink(),
                                (widget.leadData != null &&
                                        (widget.leadData.userType ==
                                        AppConstants
                                            .CLIENT_USER_TYPE_POLICY_HOLDER || widget.leadData.userType ==
                                        AppConstants
                                            .CLIENT_USER_TYPE_NEW_USER))
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 29),
                                        child: Text('Permanent Address :',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16),
                                            textAlign: TextAlign.start),
                                      )
                                    : SizedBox.shrink(),
                                (widget.leadData != null &&
                                        (widget.leadData.userType ==
                                        AppConstants
                                            .CLIENT_USER_TYPE_POLICY_HOLDER || widget.leadData.userType ==
                                        AppConstants
                                            .CLIENT_USER_TYPE_NEW_USER))
                                    ? SizedBox(
                                        height: 15,
                                      )
                                    : SizedBox.shrink(),
                                (widget.leadData != null &&
                                        (widget.leadData.userType ==
                                        AppConstants
                                            .CLIENT_USER_TYPE_POLICY_HOLDER || widget.leadData.userType ==
                                        AppConstants
                                            .CLIENT_USER_TYPE_NEW_USER))
                                    ? CeyLifeTextField(
                                        controller: _addressLine1Controller,
                                        hint: 'Address Line 01',
                                        floatingEnabled: false,
                                        optionalHint: true,
                                      )
                                    : SizedBox.shrink(),
                                (widget.leadData != null &&
                                        (widget.leadData.userType ==
                                        AppConstants
                                            .CLIENT_USER_TYPE_POLICY_HOLDER || widget.leadData.userType ==
                                        AppConstants
                                            .CLIENT_USER_TYPE_NEW_USER))
                                    ? CeyLifeTextField(
                                        controller: _addressLine2Controller,
                                        hint: 'Address Line 02',
                                        floatingEnabled: false,
                                        optionalHint: true,
                                      )
                                    : SizedBox.shrink(),
                                (widget.leadData != null &&
                                        (widget.leadData.userType ==
                                        AppConstants
                                            .CLIENT_USER_TYPE_POLICY_HOLDER || widget.leadData.userType ==
                                        AppConstants
                                            .CLIENT_USER_TYPE_NEW_USER))
                                    ? CeyLifeTextField(
                                        controller: _addressLine3Controller,
                                        hint: 'Address Line 03',
                                        floatingEnabled: false,
                                        optionalHint: true,
                                      )
                                    : SizedBox.shrink(),
                                (widget.leadData != null &&
                                        (widget.leadData.userType ==
                                        AppConstants
                                            .CLIENT_USER_TYPE_POLICY_HOLDER || widget.leadData.userType ==
                                        AppConstants
                                            .CLIENT_USER_TYPE_NEW_USER))
                                    ? SizedBox(
                                        height: 50,
                                      )
                                    : SizedBox.shrink(),
                                DropdownField(
                                  controller: _branchController,
                                  hint: 'Your  Nearest Branch ( Optional )',
                                  callBack: (){
                                    bloc.add(SubmitNearestBranchEvent());
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 80,
                            ),
                            Hero(
                              tag: 'buttons',
                              child: Material(
                                type: MaterialType.transparency,
                                child: Column(
                                  children: [
                                    CeyLifeButton(
                                      buttonType: _buttonType,
                                      onTapButton: () {
                                        if ((widget.leadData != null &&
                                            (widget.leadData.userType ==
                                        AppConstants
                                            .CLIENT_USER_TYPE_POLICY_HOLDER || widget.leadData.userType ==
                                        AppConstants
                                            .CLIENT_USER_TYPE_NEW_USER) &&
                                            _fullNameController.text.isEmpty)) {
                                          showCeylifeDialog(
                                              title:
                                                  AppLocalizations.of(context)
                                                      .translate('title_error'),
                                              message: AppLocalizations.of(
                                                      context)
                                                  .translate(
                                                      'error_full_name_empty'));
                                        } else if (_nicknameController
                                            .text.isEmpty) {
                                          showCeylifeDialog(
                                              title:
                                                  AppLocalizations.of(context)
                                                      .translate('title_error'),
                                              message: AppLocalizations.of(
                                                      context)
                                                  .translate(
                                                      'error_nickname_empty'));
                                        } else if ((widget.leadData != null &&
                                            (widget.leadData.userType ==
                                        AppConstants
                                            .CLIENT_USER_TYPE_POLICY_HOLDER || widget.leadData.userType ==
                                        AppConstants
                                            .CLIENT_USER_TYPE_NEW_USER) &&
                                            _contactMobileController
                                                .text.isEmpty)) {
                                          showCeylifeDialog(
                                              title:
                                                  AppLocalizations.of(context)
                                                      .translate('title_error'),
                                              message: AppLocalizations.of(
                                                      context)
                                                  .translate(
                                                      'error_contact_number_empty'));
                                        } else if ((widget.leadData != null &&
                                            (widget.leadData.userType ==
                                        AppConstants
                                            .CLIENT_USER_TYPE_POLICY_HOLDER || widget.leadData.userType ==
                                        AppConstants
                                            .CLIENT_USER_TYPE_NEW_USER) &&
                                            _addressLine1Controller
                                                .text.isEmpty)) {
                                          showCeylifeDialog(
                                              title:
                                                  AppLocalizations.of(context)
                                                      .translate('title_error'),
                                              message: AppLocalizations.of(
                                                      context)
                                                  .translate(
                                                      'error_address_1_empty'));
                                        } else if ((widget.leadData != null &&
                                            (widget.leadData.userType ==
                                        AppConstants
                                            .CLIENT_USER_TYPE_POLICY_HOLDER || widget.leadData.userType ==
                                        AppConstants
                                            .CLIENT_USER_TYPE_NEW_USER) &&
                                            _addressLine2Controller
                                                .text.isEmpty)) {
                                          showCeylifeDialog(
                                              title:
                                                  AppLocalizations.of(context)
                                                      .translate('title_error'),
                                              message: AppLocalizations.of(
                                                      context)
                                                  .translate(
                                                      'error_address_2_empty'));
                                        } else if ((widget.leadData != null &&
                                            (widget.leadData.userType ==
                                        AppConstants
                                            .CLIENT_USER_TYPE_POLICY_HOLDER || widget.leadData.userType ==
                                        AppConstants
                                            .CLIENT_USER_TYPE_NEW_USER) &&
                                            _addressLine3Controller
                                                .text.isEmpty)) {
                                          showCeylifeDialog(
                                              title:
                                                  AppLocalizations.of(context)
                                                      .translate('title_error'),
                                              message: AppLocalizations.of(
                                                      context)
                                                  .translate(
                                                      'error_address_3_empty'));
                                        } else {
                                          bloc.add(ValidateUserEmailEvent(
                                              email: _emailController.text));
                                        }
                                      },
                                      buttonText: AppLocalizations.of(context)
                                          .translate("continue_button_label"),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(CeylifeIcons.ic_help,
                                            color: Colors.white),
                                        SizedBox(width: 8),
                                        Text(
                                          'Having Trouble? Click here to get help',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
    return bloc;
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _nicknameController.dispose();
    _emailController.dispose();
    _contactMobileController.dispose();
    _contactHomeController.dispose();
    _addressLine1Controller.dispose();
    _addressLine2Controller.dispose();
    _addressLine3Controller.dispose();
    _branchController.dispose();
    super.dispose();
  }
}
