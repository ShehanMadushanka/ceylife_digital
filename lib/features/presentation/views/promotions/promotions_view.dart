import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/features/domain/entities/request/promotions_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/promotion_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/promotions_bloc/promotions_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/promotions_bloc/promotions_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/promotions_bloc/promotions_state.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_appbar.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_empty_view.dart';
import 'package:ceylife_digital/features/presentation/views/base_view.dart';
import 'package:ceylife_digital/features/presentation/views/promotions/widgets/promotion_card.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:ceylife_digital/utils/navigation_routes.dart';
import 'package:ceylife_digital/utils/string_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class PromotionsView extends BaseView {
  @override
  _PromotionsViewState createState() => _PromotionsViewState();
}

class _PromotionsViewState extends BaseViewState<PromotionsView> {
  final promotionsBloc = injection<PromotionsBloc>();
  bool isPromotionsLoaded = false;
  List<PromotionsEntity> promotions = List();

  @override
  void initState() {
    super.initState();
    promotionsBloc.add(GetPromotionsEvent(
        promotionsRequestEntity: PromotionsRequestEntity(
            promotionType: AppConstants.IS_USER_LOGGED
                ? AppConstants.PROMOTION_TYPE_POST
                : AppConstants.PROMOTION_TYPE_PRE)));
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CeylifeAppbar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context).translate("promotions_appbar_title"),
          style: TextStyle(color: AppColors.appBarTitle, fontSize: 18),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(AppImages.appBarBackIcon),
        ),
      ),
      body: BlocProvider<PromotionsBloc>(
        create: (_) => promotionsBloc,
        child: BlocListener<PromotionsBloc, BaseState<PromotionsState>>(
          cubit: promotionsBloc,
          listener: (context, state) {
            if (state is PromotionsLoadedState) {
              promotions.clear();
              if (state.promotionResponseEntity.promotions.isEmpty) {
                isPromotionsLoaded = false;
              } else {
                promotions.addAll(state.promotionResponseEntity.promotions);
                promotions
                    .sort((b, a) => a.createdTime.compareTo(b.createdTime));
                isPromotionsLoaded = true;
              }
              setState(() {});
            } else if (state is PromotionsFailedState) {
              setState(() {
                isPromotionsLoaded = false;
              });
            }
          },
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                isPromotionsLoaded ? SizedBox(height: 10) : SizedBox.shrink(),
                isPromotionsLoaded && promotions.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(left: 24, right: 24),
                        child: Text(ErrorMessages().mapAPIErrorCode(
                            ErrorMessages
                                .APP_PROMOTION_TITLE_HEAD,
                            StringUtils.numberZeroPad(promotions.length)),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColors.primaryHeadingTextColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 18)),
                      )
                    : SizedBox(),
                isPromotionsLoaded && promotions.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(left: 35, right: 35),
                        child: Row(
                          children: [
                            SvgPicture.asset(AppImages.promotionBell1),
                            Spacer(),
                            SvgPicture.asset(AppImages.promotionBell2),
                          ],
                        ),
                      )
                    : SizedBox(),
                isPromotionsLoaded ? SizedBox(height: 30) : SizedBox.shrink(),
                promotions.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return PromotionCard(
                            promotionsResponseEntity: promotions[index],
                            callback: () {
                              Navigator.pushNamed(
                                  context, Routes.PROMOTION_DETAIL_VIEW,
                                  arguments: promotions[index]);
                            },
                          );
                        },
                        itemCount: promotions.length,
                      )
                    : CeylifeEmptyView(
                        status: EmptyStatus.PROMOTIONS,
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Bloc getBloc() {
    return promotionsBloc;
  }
}
