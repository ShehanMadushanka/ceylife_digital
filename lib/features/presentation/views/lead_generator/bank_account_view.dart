import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/lead_generation/lead_generation_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/lead_generation/lead_generation_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/lead_generation/lead_generation_state.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_appbar.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_dropdown.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_icons_icons.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_primary_button.dart';
import 'package:ceylife_digital/features/presentation/common/ui_consts.dart';
import 'package:ceylife_digital/features/presentation/views/base_view.dart';
import 'package:ceylife_digital/features/presentation/views/common/common_item_picker.dart';
import 'package:ceylife_digital/features/presentation/views/common/data/bottom_sheet_data.dart';
import 'package:ceylife_digital/features/presentation/views/common/data/otp_request_data.dart';
import 'package:ceylife_digital/features/presentation/views/common/data/otp_response_data.dart';
import 'package:ceylife_digital/features/presentation/views/lead_generator/data/lead_data_bean.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:ceylife_digital/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BankAccountDetailsView extends BaseView {
  final LeadData leadData;

  BankAccountDetailsView({this.leadData});

  @override
  _BankAccountDetailsViewState createState() => _BankAccountDetailsViewState();
}

class _BankAccountDetailsViewState
    extends BaseViewState<BankAccountDetailsView> {
  final leadGenerationBloc = injection<LeadGenerationBloc>();
  List<BottomSheetData> bankList = List();
  List<BottomSheetData> branchList = List();
  BottomSheetData _selectedBank, _selectedBranch;
  TextEditingController _holderNameController = TextEditingController();
  TextEditingController _accountNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    leadGenerationBloc.add(GetBanksEvent());
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CeylifeAppbar(
        elevation: 0,
        title: Text(
          'Bank Account Details',
          style: TextStyle(color: AppColors.appBarTitle, fontSize: 18),
        ),
        automaticallyImplyLeading: false,
      ),
      body: BlocProvider<LeadGenerationBloc>(
        create: (_) => leadGenerationBloc,
        child: BlocListener<LeadGenerationBloc, BaseState<LeadGenerationState>>(
          listener: (context, state) {
            if (state is LeadGenerationSuccessState) {
              if (widget.leadData.userType ==
                  AppConstants.CLIENT_USER_TYPE_MOBILE_USER) {
                Navigator.pushNamed(
                        context, Routes.COMMON_OTP_VERIFICATION_VIEW,
                        arguments: OTPRequestData(
                            keyType: 1,
                            otpReference:
                                state.submitBankDetailsResponseEntity.otpRef,
                            maskedEmail:
                                state.submitBankDetailsResponseEntity.email,
                            maskedMobile:
                                state.submitBankDetailsResponseEntity.mobileNo,
                            key: widget.leadData.key,
                            appBarTitle: AppLocalizations.of(context)
                                .translate("bank_detail_submit_app_bar_title")))
                    .then((otpResponseData) {
                  if (otpResponseData is OTPResponseData) {
                    if (otpResponseData.isVerificationSuccess) {
                      showCeylifeDialog(
                        alertType: AlertType.FAIL,
                        dialogContentWidget: Column(
                          children: [
                            SvgPicture.asset(AppImages.icAuthorizationPending,
                                height: 188),
                          ],
                        ),
                        message:
                            'Your bank details need to be authorized. One of our agents will contact you for authorization. Once it’s done you will able to submit leads and eligible for earnings.',
                        title: 'Authorization Pending',
                        positiveButtonText: 'Got It',
                        onPositiveCallback: () {
                          Navigator.pushReplacementNamed(
                            context,
                            Routes.LEAD_GENERATOR_DASHBOARD_VIEW,
                          );
                        },
                      );
                    } else
                      Navigator.pop(context);
                  }
                });
              } else {
                showCeylifeDialog(
                  alertType: AlertType.FAIL,
                  dialogContentWidget: Column(
                    children: [
                      SvgPicture.asset(AppImages.icAuthorizationPending,
                          height: 188),
                    ],
                  ),
                  message:
                      'Your bank details need to be authorized. One of our agents will contact you for authorization. Once it’s done you will able to submit leads and eligible for earnings.',
                  title: 'Authorization Pending',
                  positiveButtonText: 'Got It',
                  onPositiveCallback: () {
                    Navigator.pushReplacementNamed(
                      context,
                      Routes.LEAD_GENERATOR_DASHBOARD_VIEW,
                    );
                  },
                );
              }
            } else if (state is LeadGenerationFailedState) {
              showCeylifeDialog(
                  title: AppLocalizations.of(context).translate('title_error'),
                  message: state.error);
            } else if (state is GetBanksLoaded) {
              bankList.clear();
              state.banksResponseEntity.banks.forEach((element) {
                bankList.add(BottomSheetData(
                    id: int.parse(element.bankCode),
                    description: element.bankName));
              });

              setState(() {
                _selectedBank = null;
              });
            } else if (state is GetBanksFailedState) {
              showCeylifeDialog(
                  title: AppLocalizations.of(context).translate('title_error'),
                  message: state.error);
            } else if (state is BankBranchesLoadedState) {
              branchList.clear();
              state.bankBranchesResponseEntity.getBankBranches
                  .forEach((element) {
                branchList.add(BottomSheetData(
                    id: element.bankBranchId, description: element.branchName));
                setState(() {
                  _selectedBranch = null;
                });
              });
            } else if (state is BankBranchesFailedState) {
              showCeylifeDialog(
                  title: AppLocalizations.of(context).translate('title_error'),
                  message: state.error);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              gradient: kBackgroundGradient,
            ),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) =>
                  SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: constraints.maxWidth,
                      minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 30, horizontal: 29),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Bank',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textColorMaroon,
                                  fontSize: 16.0,
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              CeylifeDropdownView(
                                value: _selectedBank != null
                                    ? _selectedBank.description
                                    : '',
                                hint: 'Select your bank',
                                onTap: () => bankList.isNotEmpty
                                    ? AppDataPicker(
                                        title: 'Select Bank',
                                        defaultSelectedItem: _selectedBank,
                                        dataList: bankList,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.85,
                                        onSelectItem: (item) {
                                          setState(() {
                                            _selectedBank = item;
                                          });

                                          leadGenerationBloc.add(
                                              GetBankBranchesEvent(
                                                  bankCode: _selectedBank.id
                                                      .toString()));
                                        }).showPicker(context)
                                    : null,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Account Holder Name',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textColorMaroon,
                                  fontSize: 16.0,
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: TextFormField(
                                  controller: _holderNameController,
                                  textAlign: TextAlign.start,
                                  cursorColor: AppColors.appHighlightColor,
                                  style: TextStyle(
                                    color: AppColors.primaryAshColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 8),
                                    hintText:
                                        'Enter your name as in the bank account',
                                    fillColor: Colors.white,
                                    hintStyle: TextStyle(
                                        color: AppColors.textColorAsh,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0),
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: AppColors.primaryBackgroundColor,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0),
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: AppColors.primaryBackgroundColor,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0),
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: AppColors.primaryBackgroundColor,
                                      ),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0),
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: AppColors.primaryBackgroundColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Account Number',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textColorMaroon,
                                  fontSize: 16.0,
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: TextFormField(
                                  controller: _accountNumberController,
                                  textAlign: TextAlign.start,
                                  keyboardType: TextInputType.number,
                                  cursorColor: AppColors.appHighlightColor,
                                  style: TextStyle(
                                    color: AppColors.primaryAshColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 8),
                                    hintText: 'Enter your bank account number',
                                    fillColor: Colors.white,
                                    hintStyle: TextStyle(
                                        color: AppColors.textColorAsh,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0),
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: AppColors.primaryBackgroundColor,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0),
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: AppColors.primaryBackgroundColor,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0),
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: AppColors.primaryBackgroundColor,
                                      ),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0),
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: AppColors.primaryBackgroundColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Branch',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textColorMaroon,
                                  fontSize: 16.0,
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              CeylifeDropdownView(
                                value: _selectedBranch != null
                                    ? _selectedBranch.description
                                    : '',
                                hint: 'Select your branch',
                                onTap: () => branchList.isNotEmpty
                                    ? AppDataPicker(
                                        title: 'Select the branch',
                                        defaultSelectedItem: _selectedBranch,
                                        dataList: branchList,
                                        isSearchable: true,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        onSelectItem: (item) {
                                          setState(() {
                                            _selectedBranch = item;
                                          });
                                        }).showPicker(context)
                                    : null,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.indianRedLightColor
                                  .withOpacity(0.37),
                              border: Border(
                                top: BorderSide(
                                  width: 1,
                                  color: AppColors.appHighlightColor
                                      .withOpacity(0.37),
                                ),
                                bottom: BorderSide(
                                  width: 1,
                                  color: AppColors.appHighlightColor
                                      .withOpacity(0.37),
                                ),
                              )),
                          padding: EdgeInsets.all(16),
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(CeylifeIcons.ic_info,
                                      color: AppColors.primaryBackgroundColor),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    'Where to deposit your earnings?',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primaryHeadingTextColor,
                                      fontSize: 16.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                'Before you earn anything from the app, you need to\nsubmit these details to set the account as your\ndeposit bank account.',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textColorAmber,
                                  fontSize: 14.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: CeylifePrimaryButton(
                                buttonLabel: 'Submit Details',
                                buttonType: ButtonType.ENABLED,
                                onTap: () {
                                  if (_selectedBank == null) {
                                    showCeylifeDialog(
                                        title: AppLocalizations.of(context)
                                            .translate('title_error'),
                                        message: AppLocalizations.of(context)
                                            .translate('error_bank_empty'));
                                  } else if (_holderNameController
                                      .text.isEmpty) {
                                    showCeylifeDialog(
                                        title: AppLocalizations.of(context)
                                            .translate('title_error'),
                                        message: AppLocalizations.of(context)
                                            .translate(
                                                'error_holder_name_empty'));
                                  } else if (_accountNumberController
                                      .text.isEmpty) {
                                    showCeylifeDialog(
                                        title: AppLocalizations.of(context)
                                            .translate('title_error'),
                                        message: AppLocalizations.of(context)
                                            .translate(
                                                'error_account_number_empty'));
                                  } else if (_selectedBranch == null) {
                                    showCeylifeDialog(
                                        title: AppLocalizations.of(context)
                                            .translate('title_error'),
                                        message: AppLocalizations.of(context)
                                            .translate('error_branch_empty'));
                                  } else {
                                    leadGenerationBloc.add(LeadGeneration(
                                      accountHolderName:
                                          _holderNameController.text,
                                      accountNo: _accountNumberController.text,
                                      bankCode: _selectedBank.id.toString(),
                                      bankBranchId: _selectedBranch.id,
                                    ));
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: InkWell(
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
                              ),
                            )
                          ],
                        ),
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

  @override
  Bloc getBloc() => leadGenerationBloc;
}
