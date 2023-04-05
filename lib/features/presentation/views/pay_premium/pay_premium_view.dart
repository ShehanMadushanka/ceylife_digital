import 'package:bloc/src/bloc.dart';
import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/features/domain/entities/response/login_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/policy_details_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/pay_premium/pay_premium_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/pay_premium/pay_premium_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/pay_premium/pay_premium_state.dart';
import 'package:ceylife_digital/features/presentation/common/calendar.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_appbar.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_icons_icons.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_primary_button.dart';
import 'package:ceylife_digital/features/presentation/common/ui_consts.dart';
import 'package:ceylife_digital/features/presentation/views/base_view.dart';
import 'package:ceylife_digital/features/presentation/views/pay_premium/widgets/policy_view.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:ceylife_digital/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class PaymentType {
  final int index;
  final int id;
  final String description;

  PaymentType(this.index, this.description, this.id);
}

class PayPremiumView extends BaseView {
  final PolicyDetailItemEntity policy;

  PayPremiumView({
    this.policy,
  });

  @override
  _PayPremiumViewState createState() => _PayPremiumViewState();
}

class _PayPremiumViewState extends BaseViewState<PayPremiumView> {
  var _bloc = injection<PayPremiumBloc>();
  MoneyMaskedTextController _amountController;
  TextEditingController _mobileNumberController;
  TextEditingController _startDateController;
  ButtonType _buttonType = ButtonType.DISABLED;

  final List<PaymentType> _paymentTypes = [
    PaymentType(
        0,
        ErrorMessages()
            .mapAPIErrorCode(ErrorMessages.APP_PAYMENT_TYPE_RECURRING, ''),
        AppConstants.PAYMENT_TYPE_RECURRING),
    PaymentType(
        1,
        ErrorMessages()
            .mapAPIErrorCode(ErrorMessages.APP_PAYMENT_TYPE_ONE_TIME, ''),
        AppConstants.PAYMENT_TYPE_ONE_TIME),
  ];

  PaymentType _selectedPaymentType;
  DateTime _premiumCessDate;
  ProfileEntity _profile;
  DateTime _calculatedEndDate;
  DateTime _selectedStartDate;

  int value = 0;

  @override
  void initState() {
    super.initState();
    _amountController = MoneyMaskedTextController(
        decimalSeparator: '.', thousandSeparator: ',');
    _mobileNumberController = TextEditingController();
    _startDateController = TextEditingController();
    _selectedPaymentType = _paymentTypes[0];
    _premiumCessDate =
        DateFormat(YYYY_MM_DD).parse(widget.policy.premiumCessDate);

    _setDefaultStartDate();
    _bloc.add(GetProfileDataEvent());
  }

  _setDefaultStartDate() {
    var _now = DateTime.now();
    int _year = _now.year;
    int _month = _now.month;
    int _day = _now.day;

    if (_day != 29 && _day != 30 && _day != 31)
      _calculateEndDate(DateTime.now());
    else {
      _calculateEndDate((DateTime(_year, _month + 1, 1)));
    }
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      appBar: CeylifeAppbar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context).translate('pay_premium_appbar_title'),
          style: TextStyle(color: AppColors.appBarTitle, fontSize: 18),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(AppImages.appBarBackIcon),
        ),
      ),
      body: BlocProvider<PayPremiumBloc>(
        create: (_) => _bloc,
        child: BlocListener<PayPremiumBloc, BaseState<PayPremiumState>>(
          cubit: _bloc,
          listener: (context, state) {
            if (state is PaymentLinkGenerateSuccessState) {
              state.generatePaymentLinkResponseEntity.paymentAmount =
                  _amountController.numberValue;
              Navigator.pushNamed(context, Routes.DIRECT_PAY_VIEW,
                  arguments: state.generatePaymentLinkResponseEntity);
            } else if (state is CheckPaymentStatusSuccessState) {
            } else if (state is ProfileDataLoadedState) {
              setState(() {
                _profile = state.profileEntity;
                if (_profile != null &&
                    _profile.mobileNo != null &&
                    _profile.mobileNo.isNotEmpty)
                  _mobileNumberController.text = _profile.mobileNo;
              });
            }
          },
          child: Container(
            decoration: BoxDecoration(
              gradient: kBackgroundGradient,
            ),
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PayPremiumPolicyView(
                    policy: widget.policy,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)
                                  .translate('payment_amount_label'),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.primaryBlackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _amountController,
                              maxLength: 9,
                              showCursor: false,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true, signed: false),
                              textInputAction: TextInputAction.done,
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryHeadingTextColor,
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: InputDecoration(
                                counterText: '',
                                hintText: '0.00',
                                isCollapsed: true,
                                prefixIcon: Text(
                                  '$CURRENCY_CODE     ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xffB59091),
                                  ),
                                ),
                                contentPadding: EdgeInsets.zero,
                                prefixIconConstraints:
                                    BoxConstraints(minWidth: 0, minHeight: 0),
                                alignLabelWithHint: true,
                                isDense: true,
                                focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.primaryBackgroundColor,
                                      width: 1),
                                ),
                                filled: false,
                                errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.primaryBackgroundColor,
                                      width: 1),
                                ),
                                labelStyle: TextStyle(
                                    color: AppColors.primaryBackgroundColor),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.primaryBackgroundColor,
                                      width: 1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.primaryBackgroundColor,
                                      width: 1),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.primaryBackgroundColor,
                                      width: 1),
                                ),
                                hintStyle: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryHeadingTextColor,
                                  height: 1.4,
                                ),
                              ),
                              onChanged: (text) {
                                if (_selectedPaymentType.id ==
                                    AppConstants.PAYMENT_TYPE_RECURRING) {
                                  _selectedStartDate != null &&
                                          _calculatedEndDate != null &&
                                          _mobileNumberController
                                              .text.isNotEmpty &&
                                          _amountController.numberValue > 0
                                      ? _buttonType = ButtonType.ENABLED
                                      : _buttonType = ButtonType.DISABLED;
                                } else {
                                  (_mobileNumberController.text.isNotEmpty &&
                                          _amountController.numberValue > 0)
                                      ? _buttonType = ButtonType.ENABLED
                                      : _buttonType = ButtonType.DISABLED;
                                }

                                setState(() {});
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              AppLocalizations.of(context)
                                  .translate('payment_type_label'),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.primaryBlackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Column(
                              children: _paymentTypes
                                  .map((type) => Theme(
                                        data: ThemeData(
                                          unselectedWidgetColor:
                                              AppColors.primaryBackgroundColor,
                                        ),
                                        child: RadioListTile(
                                          dense: true,
                                          title: Text(
                                            type.description,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color:
                                                  AppColors.primaryBlackColor,
                                              fontFamily:
                                                  AppConstants.fontFamily,
                                            ),
                                          ),
                                          value: type.index,
                                          activeColor:
                                              AppColors.primaryBackgroundColor,
                                          controlAffinity:
                                              ListTileControlAffinity.leading,
                                          onChanged: (val) {
                                            value = val;
                                            _selectedPaymentType =
                                                _paymentTypes[value];

                                            if (_selectedPaymentType.id ==
                                                AppConstants
                                                    .PAYMENT_TYPE_RECURRING) {
                                              _selectedStartDate != null &&
                                                      _calculatedEndDate !=
                                                          null &&
                                                      _mobileNumberController
                                                          .text.isNotEmpty &&
                                                      _amountController
                                                              .numberValue >
                                                          0
                                                  ? _buttonType =
                                                      ButtonType.ENABLED
                                                  : _buttonType =
                                                      ButtonType.DISABLED;
                                            } else {
                                              (_mobileNumberController
                                                          .text.isNotEmpty &&
                                                      _amountController
                                                              .numberValue >
                                                          0)
                                                  ? _buttonType =
                                                      ButtonType.ENABLED
                                                  : _buttonType =
                                                      ButtonType.DISABLED;
                                            }

                                            setState(() {});
                                          },
                                          groupValue: value,
                                        ),
                                      ))
                                  .toList(),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              AppLocalizations.of(context)
                                  .translate('payment_frequency_label'),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.primaryBlackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              _paymentModeMapping(widget.policy.paymentMode),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.primaryHeadingTextColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            _selectedPaymentType.id ==
                                    AppConstants.PAYMENT_TYPE_RECURRING
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate('star_date_label'),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: AppColors.primaryBlackColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextFormField(
                                        controller: _startDateController,
                                        maxLength: 10,
                                        showCursor: false,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        onTap: _showBottomSheet,
                                        readOnly: true,
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              AppColors.primaryHeadingTextColor,
                                        ),
                                        decoration: InputDecoration(
                                          counterText: '',
                                          hintText: 'yyyy-mm-dd',
                                          contentPadding: EdgeInsets.zero,
                                          focusedErrorBorder:
                                              UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors
                                                    .primaryBackgroundColor,
                                                width: 1),
                                          ),
                                          errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors
                                                    .primaryBackgroundColor,
                                                width: 1),
                                          ),
                                          labelStyle: TextStyle(
                                              color: AppColors
                                                  .primaryBackgroundColor),
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors
                                                    .primaryBackgroundColor,
                                                width: 1),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors
                                                    .primaryBackgroundColor,
                                                width: 1),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors
                                                    .primaryBackgroundColor,
                                                width: 1),
                                          ),
                                          hintStyle: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.textColorAsh,
                                          ),
                                          suffixIcon: Icon(
                                              CeylifeIcons.ic_calendar,
                                              color: AppColors
                                                  .primaryBackgroundColor),
                                        ),
                                        onChanged: (text) {
                                          if (_selectedPaymentType.id ==
                                              AppConstants
                                                  .PAYMENT_TYPE_RECURRING) {
                                            _selectedStartDate != null &&
                                                    _calculatedEndDate !=
                                                        null &&
                                                    _mobileNumberController
                                                        .text.isNotEmpty &&
                                                    _amountController
                                                            .numberValue >
                                                        0
                                                ? _buttonType =
                                                    ButtonType.ENABLED
                                                : _buttonType =
                                                    ButtonType.DISABLED;
                                          } else {
                                            (_mobileNumberController
                                                        .text.isNotEmpty &&
                                                    _amountController
                                                            .numberValue >
                                                        0)
                                                ? _buttonType =
                                                    ButtonType.ENABLED
                                                : _buttonType =
                                                    ButtonType.DISABLED;
                                          }

                                          setState(() {});
                                        },
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          showCeylifeDialog(
                                            title: AppLocalizations.of(context)
                                                .translate(
                                                    'change_end_date_label'),
                                            message: AppLocalizations.of(
                                                    context)
                                                .translate(
                                                    'change_end_date_description_label'),
                                            positiveButtonText:
                                                AppLocalizations.of(context)
                                                    .translate(
                                                        'got_it_button_label'),
                                          );
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)
                                                      .translate(
                                                          'end_date_label'),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: AppColors
                                                        .primaryBlackColor,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Icon(CeylifeIcons.ic_info,
                                                    size: 12,
                                                    color: AppColors
                                                        .primaryBackgroundColor),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              _calculatedEndDate == null
                                                  ? "yyyy-mm-dd"
                                                  : DateFormat(YYYY_MM_DD)
                                                      .format(
                                                          _calculatedEndDate),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: AppColors
                                                    .primaryHeadingTextColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  )
                                : SizedBox.shrink(),
                            Text(
                              AppLocalizations.of(context)
                                  .translate('mobile_number_label'),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.primaryBlackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextFormField(
                              maxLength: 10,
                              controller: _mobileNumberController,
                              showCursor: true,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              textAlignVertical: TextAlignVertical.center,
                              cursorColor: AppColors.appHighlightColor,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryHeadingTextColor,
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: InputDecoration(
                                counterText: '',
                                hintText: '07x xxxxxx',
                                focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.primaryBackgroundColor,
                                      width: 1),
                                ),
                                errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.primaryBackgroundColor,
                                      width: 1),
                                ),
                                labelStyle: TextStyle(
                                    color: AppColors.primaryBackgroundColor),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.primaryBackgroundColor,
                                      width: 1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.primaryBackgroundColor,
                                      width: 1),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.primaryBackgroundColor,
                                      width: 1),
                                ),
                                hintStyle: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textColorAsh,
                                ),
                              ),
                              onChanged: (text) {
                                if (_selectedPaymentType.id ==
                                    AppConstants.PAYMENT_TYPE_RECURRING) {
                                  _selectedStartDate != null &&
                                          _calculatedEndDate != null &&
                                          _mobileNumberController
                                              .text.isNotEmpty &&
                                          _amountController.numberValue > 0
                                      ? _buttonType = ButtonType.ENABLED
                                      : _buttonType = ButtonType.DISABLED;
                                } else {
                                  (_mobileNumberController.text.isNotEmpty &&
                                          _amountController.numberValue > 0)
                                      ? _buttonType = ButtonType.ENABLED
                                      : _buttonType = ButtonType.DISABLED;
                                }

                                setState(() {});
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: CeylifePrimaryButton(
                                buttonType: _buttonType,
                                buttonLabel: AppLocalizations.of(context)
                                    .translate('pay_now_button'),
                                onTap: () {
                                  (_selectedPaymentType.id ==
                                          AppConstants.PAYMENT_TYPE_RECURRING)
                                      ? showCeylifeDialog(
                                          title: AppLocalizations.of(context)
                                              .translate(
                                                  'recurring_payment_label'),
                                          message: ErrorMessages().mapAPIErrorCode(
                                              ErrorMessages
                                                  .APP_PAY_PREMIUM_RECURRING,
                                              "${DateFormat(YYYY_MM_DD).format(_calculatedEndDate)}"),
                                          positiveButtonText:
                                              AppLocalizations.of(context)
                                                  .translate('confirm_label'),
                                          negativeButtonText:
                                              AppLocalizations.of(context)
                                                  .translate(
                                                      "button_label_back"),
                                          onPositiveCallback: _initiatePayment,
                                        )
                                      : _initiatePayment();
                                },
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _paymentModeMapping(String paymentMode) {
    if (paymentMode == "QUARTERLY") {
      return ErrorMessages().mapAPIErrorCode(
          ErrorMessages.APP_PAYMENT_FREQUENCY_QUARTERLY, paymentMode);
    } else if (paymentMode == "MONTHLY") {
      return ErrorMessages().mapAPIErrorCode(
          ErrorMessages.APP_PAYMENT_FREQUENCY_MONTHLY, paymentMode);
    } else if (paymentMode == "YEARLY") {
      return ErrorMessages().mapAPIErrorCode(
          ErrorMessages.APP_PAYMENT_FREQUENCY_YEARLY, paymentMode);
    } else
      return paymentMode;
  }

  void _calculateEndDate(DateTime selectedDate) {
    _selectedStartDate = selectedDate;
    _startDateController.text = DateFormat(YYYY_MM_DD).format(selectedDate);

    if (widget.policy.paymentMode == "QUARTERLY") {
      _calculatedEndDate = DateTime(
          _premiumCessDate.year, _premiumCessDate.month - 3, selectedDate.day);
    } else if (widget.policy.paymentMode == "MONTHLY") {
      _calculatedEndDate = DateTime(
          _premiumCessDate.year, _premiumCessDate.month - 1, selectedDate.day);
    } else if (widget.policy.paymentMode == "YEARLY") {
      _calculatedEndDate = DateTime(
          _premiumCessDate.year - 1, _premiumCessDate.month, selectedDate.day);
    }

    if (_calculatedEndDate.isBefore(_selectedStartDate)) {
      _calculatedEndDate = _selectedStartDate;
    }

    setState(() {});
  }

  _showBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Calendar(
          premiumCessDate: _premiumCessDate,
          selectedDate: _calculateEndDate,
        );
      },
    );
  }

  _initiatePayment() {
    _bloc.add(GetGeneratedPaymentLink(
        amount: _amountController.numberValue,
        mobileNumber: _mobileNumberController.text,
        paymentType: _selectedPaymentType.id,
        endDate:
            (_selectedPaymentType.id == AppConstants.PAYMENT_TYPE_RECURRING &&
                    _calculatedEndDate != null)
                ? _getFormatedDate(_calculatedEndDate)
                : '',
        interval: widget.policy.paymentMode,
        policyNumber: widget.policy.policyNo,
        premium: widget.policy.premium,
        startDate:
            (_selectedPaymentType.id == AppConstants.PAYMENT_TYPE_RECURRING &&
                    _selectedStartDate != null)
                ? _getFormatedDate(_selectedStartDate)
                : ''));
  }

  String _getFormatedDate(DateTime date) => DateFormat(YYYY_MM_DD).format(date);

  @override
  Bloc getBloc() => _bloc;
}
