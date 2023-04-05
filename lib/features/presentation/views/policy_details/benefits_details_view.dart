import 'package:bloc/src/bloc.dart';
import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/features/domain/entities/response/policy_info_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/policy_details/policy_details_bloc.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_appbar.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_empty_view.dart';
import 'package:ceylife_digital/features/presentation/common/ui_consts.dart';
import 'package:ceylife_digital/features/presentation/views/base_view.dart';
import 'package:ceylife_digital/features/presentation/views/policy_details/widgets/benefits_table_item.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BenefitsDetailsView extends BaseView {
  final List<BenefitEntity> benefits;

  BenefitsDetailsView({Key key, @required this.benefits});

  @override
  _BenefitsDetailsViewState createState() => _BenefitsDetailsViewState();
}

class _BenefitsDetailsViewState extends BaseViewState<BenefitsDetailsView> {
  final _bloc = injection<PolicyDetailsBloc>();

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CeylifeAppbar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)
              .translate("appbar_title_benefit_detail"),
          style: TextStyle(color: AppColors.appBarTitle, fontSize: 18),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(AppImages.appBarBackIcon),
        ),
      ),
      body: (widget.benefits!=null && widget.benefits.isNotEmpty)?Container(
        decoration: BoxDecoration(
          gradient: kBackgroundGradient,
        ),
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            widget.benefits != null && widget.benefits.isNotEmpty
                ? BenefitsTableItem(
                    isHeader: true,
                  )
                : SizedBox.shrink(),
            widget.benefits != null && widget.benefits.isNotEmpty
                ? Expanded(
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      children: widget.benefits
                          .map(
                            (b) => BenefitsTableItem(
                              amount:
                                  b.coverAmount != null ? b.coverAmount : '',
                              coveredDescription: b.benefitMaster != null
                                  ? b.benefitMaster.description
                                  : '',
                              name: b.lifeno != null ? b.lifeno : '',
                            ),
                          )
                          .toList(),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ):CeylifeEmptyView(
        status: EmptyStatus.BENEFITS,
      ),
    );
  }

  @override
  Bloc getBloc() => _bloc;
}
