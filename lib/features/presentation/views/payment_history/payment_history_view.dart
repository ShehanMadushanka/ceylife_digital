import 'dart:ui';

import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/features/domain/entities/response/payment_details_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/policy_details_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/payment_history/payment_history_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/payment_history/payment_history_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/payment_history/payment_history_state.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_appbar.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_empty_view.dart';
import 'package:ceylife_digital/features/presentation/common/ui_consts.dart';
import 'package:ceylife_digital/features/presentation/views/base_view.dart';
import 'package:ceylife_digital/features/presentation/views/payment_history/widgets/policy_item.dart';
import 'package:ceylife_digital/features/presentation/views/payment_history/widgets/table_item.dart';
import 'package:ceylife_digital/utils/app_animation.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PaymentHistoryView extends BaseView {
  @override
  _PaymentHistoryViewState createState() => _PaymentHistoryViewState();
}

class _PaymentHistoryViewState extends BaseViewState<PaymentHistoryView> {
  final bloc = injection<PaymentHistoryBloc>();
  bool _transactionLoadingCompleted = false;
  bool shouldRefresh = true;
  int pageIndex = 0;
  List<PolicyDetailItemEntity> policies = List();
  PolicyDetailItemEntity _selectedPolicy;
  List<PaymentHistoryItemEntity> transactions = List();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    bloc.add(GetPoliciesEvent());
  }

  void _onRefresh() async {
    bloc.add(GetPaymentHistoryEvent(
        policyNo: _selectedPolicy.policyNo, pageNo: pageIndex));
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CeylifeAppbar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)
              .translate("payment_history_appbar_title"),
          style: TextStyle(color: AppColors.appBarTitle, fontSize: 18),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(AppImages.appBarBackIcon),
        ),
      ),
      body: BlocProvider<PaymentHistoryBloc>(
        create: (_) => bloc,
        child: Container(
          decoration: BoxDecoration(
            gradient: kBackgroundGradient,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 31,
              ),
              BlocListener<PaymentHistoryBloc, BaseState<PaymentHistoryState>>(
                cubit: bloc,
                listener: (context, state) {
                  if (state is PolicyLoadedState) {
                    policies.clear();
                    policies.addAll(state.policyDetailsResponseEntity.data);

                    if (policies.length != 0) {
                      _selectedPolicy = policies[0];
                      bloc.add(GetPaymentHistoryEvent(
                          policyNo: _selectedPolicy.policyNo));
                    }

                    setState(() {
                      _transactionLoadingCompleted = false;
                    });
                  } else if (state is PolicyLoadingFailedState) {
                    showCeylifeDialog(
                        isSessionTimeout: true,
                        title: AppLocalizations.of(context)
                            .translate('title_error'),
                        message: state.error,
                        onPositiveCallback: () {
                          Navigator.pop(context);
                        });
                  } else if (state is PaymentHistoryLoadedState) {
                    if (!state.isPageRefreshed) transactions.clear();
                    transactions
                        .addAll(state.paymentDetailsResponseEntity.data);
                    setState(() {
                      pageIndex++;
                      _refreshController.refreshCompleted();
                      _refreshController.loadComplete();
                      _transactionLoadingCompleted = true;
                      if (state.paymentDetailsResponseEntity.data.isEmpty)
                        shouldRefresh = false;
                    });
                  } else if (state is PaymentHistoryLoadingFailedState) {
                    showCeylifeDialog(
                      isSessionTimeout: true,
                      title:
                          AppLocalizations.of(context).translate('title_error'),
                      message: state.error,
                    );
                  }
                },
                child: SizedBox(
                  height: 170,
                  child: Swiper(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return PolicyItemUI(
                        policyDetailIItemEntity: policies[index],
                      );
                    },
                    itemCount: policies.length,
                    pagination: policies.length == 1
                        ? null
                        : SwiperPagination(
                            builder: DotSwiperPaginationBuilder(
                              color: AppColors.inactiveIndicatorColor,
                              activeColor: AppColors.activeIndicatorColor,
                            ),
                            margin: EdgeInsets.only(top: 20)),
                    viewportFraction: 0.75,
                    fade: 0.2,
                    loop: false,
                    scale: 0.9,
                    autoplay: false,
                    layout: SwiperLayout.DEFAULT,
                    onIndexChanged: (index) {
                      _selectedPolicy = policies[index];
                      bloc.add(GetPaymentHistoryEvent(
                          policyNo: _selectedPolicy.policyNo));
                      setState(() {
                        pageIndex = 0;
                        shouldRefresh = true;
                        _transactionLoadingCompleted = false;
                      });
                    },
                  ),
                ),
              ),
              _transactionLoadingCompleted
                  ? SizedBox(
                      height: 30,
                    )
                  : SizedBox.shrink(),
              (_transactionLoadingCompleted && transactions.length != 0)
                  ? DataRowItem(
                      isHeader: true,
                    )
                  : SizedBox.shrink(),
              BlocBuilder<PaymentHistoryBloc, BaseState<PaymentHistoryState>>(
                cubit: bloc,
                builder: (context, state) {
                  if (state is PaymentHistoryLoadingState) {
                    return Expanded(
                      child: Center(
                        child: Lottie.asset(
                          AppAnimation.animLoading,
                          onLoaded: (composition) {},
                        ),
                      ),
                    );
                  } else if (state is PaymentHistoryLoadedState) {
                    if (transactions.length == 0) {
                      return Expanded(
                        child: CeylifeEmptyView(
                          status: EmptyStatus.PAYMENT_HISTORY,
                        ),
                      );
                    } else {
                      return Expanded(
                        child: RefreshConfiguration(
                          enableScrollWhenRefreshCompleted: true,
                          enableLoadingWhenFailed: true,
                          child: SmartRefresher(
                            enablePullDown: false,
                            physics: BouncingScrollPhysics(),
                            enablePullUp: shouldRefresh ? true : false,
                            footer: CustomFooter(
                              builder: (context, status) {
                                return Container(
                                  height: 100,
                                  child: Lottie.asset(
                                    AppAnimation.animLoading,
                                    onLoaded: (composition) {},
                                  ),
                                );
                              },
                            ),
                            controller: _refreshController,
                            onLoading: _onRefresh,
                            child: ListView(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              children: transactions
                                  .map((e) => DataRowItem(
                                        date: e.receiptDate,
                                        amount: e.amount,
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),
                      );
                    }
                  } else
                    return Expanded(
                      child: CeylifeEmptyView(
                        status: EmptyStatus.PAYMENT_HISTORY,
                      ),
                    );
                },
              )
            ],
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
