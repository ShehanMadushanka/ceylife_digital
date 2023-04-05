import 'dart:ui';

import 'package:bloc/src/bloc.dart';
import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/features/domain/entities/response/generate_payment_link_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/directpay_bloc/directpay_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/directpay_bloc/directpay_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/directpay_bloc/directpay_state.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_appbar.dart';
import 'package:ceylife_digital/features/presentation/views/base_view.dart';
import 'package:ceylife_digital/utils/app_animation.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_extensions.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:ceylife_digital/utils/navigation_routes.dart';
import 'package:ceylife_digital/utils/query_string.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

import 'direct_pay_status_view.dart';

class DirectPayView extends BaseView {
  final GeneratePaymentLinkResponseEntity paymentLinkResponseEntity;

  DirectPayView(this.paymentLinkResponseEntity);

  @override
  _DirectPayViewState createState() => _DirectPayViewState();
}

class _DirectPayViewState extends BaseViewState<DirectPayView> {
  final bloc = injection<DirectPayBloc>();
  bool isLoaded = false;

  @override
  Widget buildView(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bloc.add(CheckPaymentStatusEvent(
            referenceNumber: widget.paymentLinkResponseEntity.refCode));
        return false;
      },
      child: Scaffold(
          appBar: CeylifeAppbar(
            elevation: 0,
            title: Text(
              AppLocalizations.of(context)
                  .translate("pay_premium_appbar_title"),
              style: TextStyle(color: AppColors.appBarTitle, fontSize: 18),
            ),
            leading: IconButton(
              onPressed: () {
                bloc.add(CheckPaymentStatusEvent(
                    referenceNumber: widget.paymentLinkResponseEntity.refCode));
              },
              icon: SvgPicture.asset(AppImages.appBarBackIcon),
            ),
          ),
          body: BlocProvider(
            create: (_) => bloc,
            child: BlocListener<DirectPayBloc, BaseState<DirectPayState>>(
              cubit: bloc,
              listener: (context, state) {
                if (state is DirectPayPaymentSuccessState) {
                  Navigator.pushNamed(context, Routes.DIRECT_PAY_STATUS_VIEW,
                      arguments: DirectPayArgs(paymentStatus: DirectPayStatus.SUCCESS, amount: widget.paymentLinkResponseEntity.paymentAmount));
                } else if (state is DirectPayPaymentFailedState) {
                  Navigator.pushNamed(context, Routes.DIRECT_PAY_STATUS_VIEW,
                      arguments: DirectPayArgs(paymentStatus: DirectPayStatus.FAILED, amount: widget.paymentLinkResponseEntity.paymentAmount));
                } else if (state is PaymentFailedState) {
                  Navigator.pop(context);
                }
              },
              child: Stack(
                children: [
                  InAppWebView(
                    initialUrl:
                        widget.paymentLinkResponseEntity.paymentGatewayUrl,
                    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                      new Factory<OneSequenceGestureRecognizer>(
                        () => new EagerGestureRecognizer(),
                      ),
                    ].toSet(),
                    initialOptions: InAppWebViewGroupOptions(
                        crossPlatform: InAppWebViewOptions(
                            verticalScrollBarEnabled: true,
                            javaScriptEnabled: true)),
                    onWebViewCreated: (InAppWebViewController controller) {},
                    onLoadStart:
                        (InAppWebViewController controller, String url) {
                      var result = QueryString.parse(url);
                      if (result["status"] ==
                          DirectPayStatus.SUCCESS.getStatus()) {
                        Navigator.pushNamed(
                            context, Routes.DIRECT_PAY_STATUS_VIEW,
                            arguments: DirectPayArgs(paymentStatus: DirectPayStatus.SUCCESS, amount: widget.paymentLinkResponseEntity.paymentAmount));
                      } else if (result["status"] ==
                          DirectPayStatus.FAILED.getStatus()) {
                        Navigator.pushNamed(
                            context, Routes.DIRECT_PAY_STATUS_VIEW,
                            arguments: DirectPayArgs(paymentStatus: DirectPayStatus.FAILED, amount: widget.paymentLinkResponseEntity.paymentAmount));
                      }
                    },
                    onLoadStop: (controller, url) {
                      setState(() {
                        isLoaded = true;
                      });
                    },
                  ),
                  isLoaded
                      ? SizedBox.shrink()
                      : BackdropFilter(
                          child: Container(
                            alignment: FractionalOffset.center,
                            child: Wrap(
                              children: [
                                Container(
                                  color: Colors.transparent,
                                  child: Lottie.asset(
                                    AppAnimation.animLoading,
                                    onLoaded: (composition) {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                        )
                ],
              ),
            ),
          )),
    );
  }

  @override
  Bloc getBloc() {
    return bloc;
  }
}
