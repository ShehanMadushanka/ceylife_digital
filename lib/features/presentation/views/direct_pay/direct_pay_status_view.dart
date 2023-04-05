import 'dart:ui';

import 'package:bloc/src/bloc.dart';
import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/directpay_bloc/directpay_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/directpay_bloc/directpay_state.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_anim_widget.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_appbar.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_icons_icons.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_primary_button.dart';
import 'package:ceylife_digital/features/presentation/views/base_view.dart';
import 'package:ceylife_digital/utils/app_animation.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:ceylife_digital/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class DirectPayArgs {
  final DirectPayStatus paymentStatus;
  final double amount;

  DirectPayArgs({this.paymentStatus, this.amount});
}

class DirectPayStatusView extends BaseView {
  final DirectPayArgs paymentArgs;

  DirectPayStatusView(this.paymentArgs);

  @override
  _DirectPayStatusViewState createState() => _DirectPayStatusViewState();
}

class _DirectPayStatusViewState extends BaseViewState<DirectPayStatusView>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  final bloc = injection<DirectPayBloc>();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget buildView(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).popUntil(ModalRoute.withName(
            widget.paymentArgs.paymentStatus == DirectPayStatus.SUCCESS
                ? Routes.HOME_VIEW
                : Routes.PAY_PREMIUM_VIEW));
        return true;
      },
      child: Scaffold(
        appBar: CeylifeAppbar(
          elevation: 0,
          title: Text(
            AppLocalizations.of(context).translate("pay_premium_appbar_title"),
            style: TextStyle(color: AppColors.appBarTitle, fontSize: 18),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).popUntil(ModalRoute.withName(
                  widget.paymentArgs.paymentStatus == DirectPayStatus.SUCCESS
                      ? Routes.HOME_VIEW
                      : Routes.PAY_PREMIUM_VIEW));
            },
            icon: SvgPicture.asset(AppImages.appBarBackIcon),
          ),
        ),
        body: BlocProvider<DirectPayBloc>(
          create: (_) => bloc,
          child: BlocListener<DirectPayBloc, BaseState<DirectPayState>>(
            cubit: bloc,
            listener: (context, state) {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 18, bottom: 13, right: 46, left: 46),
                  child: Text(
                    widget.paymentArgs.paymentStatus == DirectPayStatus.SUCCESS
                        ? AppLocalizations.of(context)
                            .translate("label_status_directpay_success")
                        : AppLocalizations.of(context)
                            .translate("label_status_directpay_failed"),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.textColorMaroon,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                CeylifeAnimWidget(
                    controller: _animationController,
                    anim: widget.paymentArgs.paymentStatus ==
                            DirectPayStatus.SUCCESS
                        ? AppAnimation.animSuccess
                        : AppAnimation.animFailed),
                widget.paymentArgs.paymentStatus == DirectPayStatus.SUCCESS
                    ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40,),
                      child: Column(
                        children: [
                          SizedBox(height: 50,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)
                                    .translate("label_amount"),
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: AppColors.textColorAsh2),
                              ),
                              Text.rich(
                                TextSpan(
                                    text: 'LKR  ',
                                    style: TextStyle(
                                        color: AppColors.buttonBorderColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                    children: [
                                      TextSpan(
                                          text: NumberFormat.currency(
                                              symbol: '')
                                              .format(
                                            widget.paymentArgs.amount,
                                          ),
                                          style: TextStyle(
                                              color:
                                              AppColors.primaryHeadingTextColor,
                                              fontSize: 24,
                                              fontWeight: FontWeight.w700))
                                    ]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                    : SizedBox(
                        height: 20,
                      ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 37),
                  child: Text(
                    widget.paymentArgs.paymentStatus == DirectPayStatus.SUCCESS
                        ? AppLocalizations.of(context)
                            .translate("desc_status_directpay_success")
                        : AppLocalizations.of(context)
                            .translate("desc_status_directpay_failed"),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.primaryBlackColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: (widget.paymentArgs.paymentStatus ==
                              DirectPayStatus.SUCCESS)
                          ? 30
                          : 0),
                  child: CeylifePrimaryButton(
                    buttonLabel: widget.paymentArgs.paymentStatus ==
                            DirectPayStatus.SUCCESS
                        ? AppLocalizations.of(context)
                            .translate("home_button_label")
                        : AppLocalizations.of(context)
                            .translate("try_again_button_label"),
                    width: MediaQuery.of(context).size.width,
                    onTap: () {
                      Navigator.of(context).popUntil(ModalRoute.withName(
                          widget.paymentArgs.paymentStatus ==
                                  DirectPayStatus.SUCCESS
                              ? Routes.HOME_VIEW
                              : Routes.PAY_PREMIUM_VIEW));
                    },
                  ),
                ),
                widget.paymentArgs.paymentStatus == DirectPayStatus.FAILED
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        child: Container(
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.CONTACT_US_VIEW);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(CeylifeIcons.ic_help,
                                    color: AppColors.primaryHeadingTextColor),
                                SizedBox(width: 10),
                                Text(
                                  AppLocalizations.of(context)
                                      .translate("label_get_help"),
                                  style: TextStyle(
                                    color: AppColors.primaryHeadingTextColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : SizedBox.shrink()
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
