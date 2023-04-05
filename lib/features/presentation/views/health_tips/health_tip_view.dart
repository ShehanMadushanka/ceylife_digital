import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/features/domain/entities/response/health_tip_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/health_tips/health_tips_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/health_tips/health_tips_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/health_tips/health_tips_state.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_appbar.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_empty_view.dart';
import 'package:ceylife_digital/features/presentation/views/base_view.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:ceylife_digital/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'widgets/age_group_selector.dart';
import 'widgets/health_tip_card.dart';

List<HealthTipEntity> filteredHealthTips = List();

class HealthTipView extends BaseView {
  final bool isFromHome;

  HealthTipView(this.isFromHome);

  @override
  _HealthTipViewState createState() => _HealthTipViewState();
}

class _HealthTipViewState extends BaseViewState<HealthTipView> {
  final bloc = injection<HealthTipsBloc>();
  bool isTipsLoaded = false;
  List<HealthTipEntity> healthTips = [];

  List<AgeRangeEntity> ageGroupEntities = [];

  @override
  void initState() {
    super.initState();
    bloc.add(GetHealthTips(fromHome: widget.isFromHome));
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CeylifeAppbar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context).translate("health_tips_appbar_title"),
          style: TextStyle(color: AppColors.appBarTitle, fontSize: 18),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(AppImages.appBarBackIcon),
        ),
      ),
      body: BlocProvider<HealthTipsBloc>(
        create: (_) => bloc,
        child: BlocListener<HealthTipsBloc, BaseState<HealthTipsState>>(
          cubit: bloc,
          listener: (context, state) {
            if (state is GetHealthTipsSuccessState) {
              ageGroupEntities.clear();
              healthTips.clear();
              ageGroupEntities.add(AgeRangeEntity(
                  isInitialItem: true,
                  isSelected:
                      state.healthTipsResponseEntity.userAgeRange == null));
              state.healthTipsResponseEntity.ageRanges.forEach((element) {
                if (element.status == 'ACT') ageGroupEntities.add(element);
              });

              healthTips.addAll(state.healthTipsResponseEntity.healthTips);

              if (state.healthTipsResponseEntity.userAgeRange != null && state.healthTipsResponseEntity.userAgeRange != 0) {
                ageGroupEntities.forEach((element) {
                  if (element.healthAgeRangeId ==
                      state.healthTipsResponseEntity.userAgeRange) {
                    element.isSelected = true;
                    filteredHealthTips.clear();
                    healthTips.forEach((tip) {
                      tip.ageRangeIds.forEach((id) {
                        if (id == element.healthAgeRangeId) {
                          filteredHealthTips.add(tip);
                        }
                      });
                    });

                    healthTips.forEach((element) {
                      if(element.ageRangeIds.isEmpty)
                        filteredHealthTips.add(element);
                    });
                  }
                });
              } else {
                filteredHealthTips.clear();
                ageGroupEntities[0].isSelected = true;
                filteredHealthTips.addAll(healthTips);
              }

              setState(() {
                isTipsLoaded = true;
              });
            } else if (state is GetHealthTipsFailedState) {
              setState(() {
                isTipsLoaded = false;
              });
            }
          },
          child: isTipsLoaded
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AgeGroupSelector(
                      ageRangeList: ageGroupEntities,
                      selectedAgeGroup: (ageGroup) {
                        filteredHealthTips.clear();
                        if (ageGroup.isInitialItem)
                          filteredHealthTips.addAll(healthTips);
                        else {
                          healthTips.forEach((tip) {
                            tip.ageRangeIds.forEach((id) {
                              if (id == ageGroup.healthAgeRangeId) {
                                filteredHealthTips.add(tip);
                              }
                            });
                          });

                          healthTips.forEach((element) {
                            if(element.ageRangeIds.isEmpty)
                              filteredHealthTips.add(element);
                          });
                        }

                        setState(() {});
                      },
                    ),
                    Expanded(
                      child: Container(
                        margin: filteredHealthTips.isEmpty
                            ? EdgeInsets.zero
                            : EdgeInsets.only(top: 18),
                        color: AppColors.appBarTitle,
                        child: filteredHealthTips.length != 0
                            ? ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context,
                                          Routes.HEALTH_TIPS_DETAIL_VIEW,
                                          arguments: index);
                                    },
                                    child: HealthTipCard(
                                      healthTipResponseEntity:
                                          filteredHealthTips[index],
                                    ),
                                  );
                                },
                                itemCount: filteredHealthTips.length,
                              )
                            : CeylifeEmptyView(
                                status: EmptyStatus.HEALTH_TIPS,
                              ),
                      ),
                    )
                  ],
                )
              : CeylifeEmptyView(
                  status: EmptyStatus.HEALTH_TIPS,
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
