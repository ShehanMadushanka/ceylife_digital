import 'dart:ui';

import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/features/domain/entities/response/product_detail_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/rates_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/rates/rates_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/rates/rates_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/rates/rates_state.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_appbar.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_empty_view.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_icons_icons.dart';
import 'package:ceylife_digital/features/presentation/common/ui_consts.dart';
import 'package:ceylife_digital/features/presentation/views/base_view.dart';
import 'package:ceylife_digital/features/presentation/views/rates/widgets/rate_item.dart';
import 'package:ceylife_digital/features/presentation/views/rates/widgets/rates_table_item.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:ceylife_digital/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class RatesHistoryView extends BaseView {
  final RateEntity rateEntity;

  RatesHistoryView({this.rateEntity});

  @override
  _RatesHistoryViewState createState() => _RatesHistoryViewState();
}

class _RatesHistoryViewState extends BaseViewState<RatesHistoryView> {
  final bloc = injection<RatesBloc>();
  List<RateEntity> rateList = List();

  @override
  void initState() {
    super.initState();
    bloc.add(GetRateHistory(
        productDetailId: widget.rateEntity.productType.productId));
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CeylifeAppbar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context).translate("accumulation_appbar_title"),
          style: TextStyle(color: AppColors.appBarTitle, fontSize: 18),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(AppImages.appBarBackIcon),
        ),
      ),
      body: BlocProvider<RatesBloc>(
        create: (_) => bloc,
        child: BlocListener<RatesBloc, BaseState<RateState>>(
          cubit: bloc,
          listener: (context, state) {
            if (state is RatesHistoryLoadedState) {
              rateList.clear();
              rateList
                  .addAll(state.accumulationRateHistoryResponseEntity.rates);
              setState(() {});
            } else if (state is RatesHistoryFailedState) {
              rateList.clear();
              setState(() {});
            }
          },
          child: Container(
            decoration: BoxDecoration(
              gradient: kBackgroundGradient,
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 28,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 47),
                      child: RatesItemUI(
                        planName: widget.rateEntity.productType.productName,
                        rate: widget.rateEntity.rate,
                      ),
                    ),
                    SizedBox(
                      height: 27,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 47),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        color: AppColors.textColorAmber2,
                        child: Container(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate("previous_rates"),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    (rateList.length != 0)
                        ? SizedBox(
                            height: 24,
                          )
                        : SizedBox.shrink(),
                    (rateList.length != 0)
                        ? RateDataRowItem(
                            isHeader: true,
                          )
                        : SizedBox.shrink(),
                    (rateList.length != 0)
                        ? Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: rateList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return (index == rateList.length - 1)
                                          ? Column(
                                              children: [
                                                RateDataRowItem(
                                                  date: rateList[index]
                                                      .createdTime,
                                                  rate: rateList[index].rate,
                                                ),
                                                SizedBox(
                                                  height: 40,
                                                )
                                              ],
                                            )
                                          : RateDataRowItem(
                                              date: rateList[index].createdTime,
                                              rate: rateList[index].rate,
                                            );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Expanded(
                            child: CeylifeEmptyView(
                              status: EmptyStatus.RATE_HISTORY,
                            ),
                          ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Color(0xE5FFFFFF),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x33000000),
                          blurRadius: 10,
                          offset: Offset(0, -2),
                        )
                      ],
                    ),
                    child: InkWell(
                      onTap: () {
                        var _product = ProductDetailEntity(
                            widget.rateEntity.productType.productName,
                            widget.rateEntity.productType.content,
                            widget.rateEntity.productType.detailSummaryLink,
                            widget.rateEntity.productType.brochureUrl);
                        _product.productCategoryName = widget
                            .rateEntity.productCategory.productCategoryName;

                        Navigator.pushNamed(
                            context, Routes.PRODUCTS_SERVICES_PLAN_DETAIL_VIEW,
                            arguments: _product);
                      },
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                          child: Wrap(
                            direction: Axis.vertical,
                            runAlignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 9),
                                  Icon(
                                    CeylifeIcons.ic_help,
                                    size: 18,
                                    color: AppColors.textColorMaroon,
                                  ),
                                  SizedBox(
                                    width: 9,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)
                                        .translate("learn_more_product"),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.textColorMaroon,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
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
