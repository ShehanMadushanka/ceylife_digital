import 'dart:math' as math;
import 'dart:ui';

import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/features/domain/entities/response/policy_details_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/policy_details/policy_details_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/policy_details/policy_details_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/policy_details/product_services_status.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_appbar.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_icons_icons.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_primary_button.dart';
import 'package:ceylife_digital/features/presentation/common/ui_consts.dart';
import 'package:ceylife_digital/features/presentation/views/base_view.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/app_extensions.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:ceylife_digital/utils/navigation_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart' as intl;
import 'package:marquee_widget/marquee_widget.dart';

class PolicyDetailsView extends BaseView {
  final PolicyDetailItemEntity policy;

  PolicyDetailsView({this.policy});

  @override
  _PolicyDetailsViewState createState() => _PolicyDetailsViewState();
}

class _PolicyDetailsViewState extends BaseViewState<PolicyDetailsView> {
  final bloc = injection<PolicyDetailsBloc>();

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CeylifeAppbar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context).translate("appbar_title_policy_detail"),
          style: TextStyle(color: AppColors.appBarTitle, fontSize: 18),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(AppImages.appBarBackIcon),
        ),
      ),
      body: BlocProvider<PolicyDetailsBloc>(
        create: (_) => bloc,
        child: BlocListener<PolicyDetailsBloc, BaseState<PolicyDetailsState>>(
          cubit: bloc,
          listener: (context, state) {
            if (state is PaymentHistoryLoadedState) {
              if (state.paymentDetailsResponseEntity.data.isEmpty) {
                Navigator.pushNamed(
                    context, Routes.PREMIUM_TRANSACTION_HISTORY_VIEW,
                    arguments: null);
              } else {
                Navigator.pushNamed(
                    context, Routes.PREMIUM_TRANSACTION_HISTORY_VIEW,
                    arguments: state.paymentDetailsResponseEntity.data);
              }
            } else if (state is PolicyBenefitsLoadedState) {
              if (state.policyInfoResponseEntity.benefits.isEmpty) {
                Navigator.pushNamed(context, Routes.BENEFITS_DETAILS_VIEW,
                    arguments: null);
              } else {
                Navigator.pushNamed(context, Routes.BENEFITS_DETAILS_VIEW,
                    arguments: state.policyInfoResponseEntity.benefits);
              }
            } else if (state is PolicyLoansLoadedState) {
              if (state.policyInfoResponseEntity.policyLoans.isEmpty) {
                Navigator.pushNamed(context, Routes.LOAN_DETAILS_VIEW,
                    arguments: null);
              } else {
                Navigator.pushNamed(context, Routes.LOAN_DETAILS_VIEW,
                    arguments: state.policyInfoResponseEntity.policyLoans);
              }
            }
          },
          child: Container(
            decoration: BoxDecoration(
              gradient: kBackgroundGradient,
            ),
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 20.0, right: 20.0),
                      child: Container(
                        padding: const EdgeInsets.all(7),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            end: Alignment.centerRight,
                            begin: Alignment.centerLeft,
                            colors: [
                              AppColors.primaryBackgroundColor,
                              Color(0xff631829)
                            ],
                            stops: [0.2, 1],
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Color(0xffD4A5A6), width: 1),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        CEYLINCO_LIFE,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Marquee(
                                        child: Text(
                                          widget.policy.planName,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                        ),
                                        textDirection: TextDirection.ltr,
                                        animationDuration: Duration(seconds: 2),
                                        backDuration: Duration(seconds: 2),
                                        pauseDuration:
                                            Duration(milliseconds: 500),
                                        directionMarguee:
                                            DirectionMarguee.TwoDirection,
                                        direction: Axis.horizontal,
                                        forwardAnimation: Curves.easeOut,
                                        backwardAnimation: Curves.easeOut,
                                      ),
                                      Text(
                                        widget.policy.name,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Wrap(
                                          direction: Axis.vertical,
                                          crossAxisAlignment:
                                              WrapCrossAlignment.start,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)
                                                  .translate(
                                                      'policy_number_label'),
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              widget.policy.policyNo,
                                              maxLines: 2,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ),
                                      fit: FlexFit.loose,
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Wrap(
                                          direction: Axis.vertical,
                                          crossAxisAlignment:
                                              WrapCrossAlignment.end,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)
                                                  .translate(
                                                      'insurance_premium_label'),
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text.rich(
                                              new TextSpan(
                                                text: CURRENCY_CODE,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 10,
                                                ),
                                                children: <TextSpan>[
                                                  new TextSpan(
                                                    text: intl.NumberFormat
                                                            .currency(
                                                                symbol: '')
                                                        .format(
                                                      widget.policy.premium,
                                                    ),
                                                    style: new TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      fit: FlexFit.loose,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          SizedBox(height: 20),
                          (widget.policy.policyStatusEnum.value != null &&
                                  widget
                                      .policy.policyStatusEnum.value.isNotEmpty)
                              ? PolicyData(
                                  title: AppLocalizations.of(context)
                                      .translate('label_policy_status'),
                                  value: widget.policy.policyStatusEnum.value,
                                )
                              : SizedBox.shrink(),
                          (widget.policy.riskDate != null &&
                                  widget.policy.riskDate.isNotEmpty)
                              ? PolicyData(
                                  title: AppLocalizations.of(context)
                                      .translate('label_commence_date'),
                                  value: widget.policy.riskDate,
                                )
                              : SizedBox.shrink(),
                          (widget.policy.premiumCessDate != null &&
                                  widget.policy.premiumCessDate.isNotEmpty)
                              ? PolicyData(
                                  title: AppLocalizations.of(context)
                                      .translate('label_maturity_date'),
                                  value: widget.policy.premiumCessDate,
                                )
                              : SizedBox.shrink(),
                          (widget.policy.term != null)
                              ? PolicyData(
                                  title: AppLocalizations.of(context)
                                      .translate('label_paying_term'),
                                  value: widget.policy.term.toInt().toString(),
                                )
                              : SizedBox.shrink(),
                          (widget.policy.sumAssured != null &&
                                  widget.policy.sumAssured
                                      .toString()
                                      .isNotEmpty)
                              ? PolicyData(
                                  title: AppLocalizations.of(context)
                                      .translate('label_sum_assured'),
                                  isAmount: true,
                                  value: widget.policy.sumAssured.toString(),
                                )
                              : SizedBox.shrink(),
                          (widget.policy.accountBalance != null &&
                                  widget.policy.accountBalance
                                      .toString()
                                      .isNotEmpty)
                              ? PolicyData(
                                  title: AppLocalizations.of(context)
                                      .translate('label_account_balance'),
                                  isAmount: true,
                                  value:
                                      widget.policy.accountBalance.toString(),
                                )
                              : SizedBox.shrink(),
                          (widget.policy.sundryBalance != null &&
                                  widget.policy.sundryBalance
                                      .toString()
                                      .isNotEmpty)
                              ? PolicyData(
                                  title: AppLocalizations.of(context)
                                      .translate('label_axcess_balance'),
                                  isAmount: true,
                                  value: widget.policy.sundryBalance.toString(),
                                )
                              : SizedBox.shrink(),
                          (widget.policy.policyNo != null &&
                                  widget.policy.policyNo.isNotEmpty)
                              ? PolicyListTile(
                                  title: AppLocalizations.of(context)
                                      .translate('appbar_title_benefit_detail'),
                                  onTap: () {
                                    bloc.add(GetPolicyBenefitsEvent(
                                        policyNo: widget.policy.policyNo));
                                  })
                              : SizedBox.shrink(),
                          /*PolicyListTile(
                            title: 'Beneficiary Details',
                            onTap: () => Navigator.pushNamed(
                                context, Routes.BENEFICIARY_DETAILS_VIEW),
                          ),*/
                          PolicyListTile(
                              title: AppLocalizations.of(context).translate(
                                  'appbar_title_transaction_history'),
                              onTap: () {
                                bloc.add(GetPaymentHistoryEvent(
                                    policyNo: widget.policy.policyNo));
                              }),
                          PolicyListTile(
                              title: AppLocalizations.of(context)
                                  .translate('appbar_title_loan_detail'),
                              onTap: () {
                                bloc.add(GetPolicyLoansEvent(
                                    policyNo: widget.policy.policyNo));
                              }),
                          SizedBox(
                              height: widget.policy.policyStatusEnum ==
                                          PolicyStatus.MATURED ||
                                      widget.policy.policyStatusEnum ==
                                          PolicyStatus.MATURED
                                  ? 20
                                  : 160),
                        ],
                      ),
                    ),
                  ],
                ),
                widget.policy.policyStatusEnum == PolicyStatus.MATURED ||
                        widget.policy.policyStatusEnum == PolicyStatus.MATURED
                    ? SizedBox.shrink()
                    : Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: Color(0xB2FFFFFF),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x21070707),
                                blurRadius: 8,
                                offset: Offset(0, -4),
                              )
                            ],
                          ),
                          child: ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                              child: Wrap(
                                direction: Axis.vertical,
                                runAlignment: WrapAlignment.center,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  SizedBox(height: 9),
                                  Text(
                                    AppLocalizations.of(context)
                                        .translate('label_amount_due'),
                                    style: TextStyle(
                                      color: AppColors.primaryHeadingTextColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      text: 'LKR  ',
                                      style: TextStyle(
                                        color:
                                            AppColors.primaryHeadingTextColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: intl.NumberFormat.currency(
                                                  symbol: '')
                                              .format(
                                            widget.policy.totalDue,
                                          ),
                                          style: TextStyle(
                                              color: AppColors
                                                  .primaryHeadingTextColor,
                                              fontSize: 24,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context).translate(
                                                'paid_up_date_label') +
                                            ' : ',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: AppColors.redwoodOne,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        widget.policy.paidUpDate,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: AppColors.redwoodOne,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  CeylifePrimaryButton(
                                    buttonLabel: AppLocalizations.of(context)
                                        .translate('pay_now_button'),
                                    width:
                                        MediaQuery.of(context).size.width - 60,
                                    onTap: () => Navigator.pushNamed(
                                        context, Routes.PAY_PREMIUM_VIEW,
                                        arguments: widget.policy),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                        ),
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

class PolicyListTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const PolicyListTile({Key key, @required this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: AppColors.dividerColor.withOpacity(0.6),
                width: 1,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: AppColors.primaryBlackColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Transform.rotate(
                angle: 270 * math.pi / 180,
                alignment: Alignment.center,
                child: Icon(
                  CeylifeIcons.ic_rounded_arrow_down,
                  color: AppColors.primaryBackgroundColor,
                  size: 25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PolicyData extends StatelessWidget {
  final String title;
  final String value;
  final bool isAmount;

  const PolicyData({this.title, this.value, this.isAmount = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.primaryBlackColor,
            ),
            textAlign: TextAlign.start,
          ),
          isAmount
              ? Text.rich(
                  TextSpan(
                    text: 'LKR  ',
                    style: TextStyle(
                      color: AppColors.primaryHeadingTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      TextSpan(
                        text: intl.NumberFormat.currency(symbol: '').format(
                          double.parse(value),
                        ),
                        style: TextStyle(
                            color: AppColors.primaryHeadingTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  textAlign: TextAlign.start,
                )
              : Text(
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
      ),
    );
  }
}
