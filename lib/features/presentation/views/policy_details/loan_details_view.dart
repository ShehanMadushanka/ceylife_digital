import 'package:bloc/src/bloc.dart';
import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/features/domain/entities/response/policy_info_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/policy_details/policy_details_bloc.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_appbar.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_empty_view.dart';
import 'package:ceylife_digital/features/presentation/common/ui_consts.dart';
import 'package:ceylife_digital/features/presentation/views/base_view.dart';
import 'package:ceylife_digital/features/presentation/views/policy_details/widgets/loan_details_table_item.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:ceylife_digital/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoanDetailsView extends BaseView {
  final List<PolicyLoanEntity> policyLoans;

  LoanDetailsView({Key key, @required this.policyLoans});

  @override
  _LoanDetailsViewState createState() => _LoanDetailsViewState();
}

class _LoanDetailsViewState extends BaseViewState<LoanDetailsView> {
  final _bloc = injection<PolicyDetailsBloc>();

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CeylifeAppbar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)
              .translate("appbar_title_loan_detail"),
          style: TextStyle(color: AppColors.appBarTitle, fontSize: 18),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(AppImages.appBarBackIcon),
        ),
      ),
      body: (widget.policyLoans != null && widget.policyLoans.isNotEmpty)
          ? Container(
              decoration: BoxDecoration(
                gradient: kBackgroundGradient,
              ),
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  widget.policyLoans != null && widget.policyLoans.isNotEmpty
                      ? LoanDetailsTableItem(
                          isHeader: true,
                        )
                      : SizedBox.shrink(),
                  widget.policyLoans != null && widget.policyLoans.isNotEmpty
                      ? Expanded(
                          child: ListView(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            children: widget.policyLoans
                                .map(
                                  (l) => InkWell(
                                    child: LoanDetailsTableItem(
                                      outstanding: l.loanBalance,
                                      loanNumber: l.loanNo,
                                    ),
                                    onTap: () {
                                      if (l.loanReceipts.isNotEmpty)
                                        Navigator.pushNamed(
                                            context, Routes.LOAN_RECEIPTS_VIEW,
                                            arguments: l.loanReceipts);
                                    },
                                  ),
                                )
                                .toList(),
                          ),
                        )
                      : SizedBox.shrink(),
                ],
              ),
            )
          : CeylifeEmptyView(
              status: EmptyStatus.LOAD_DETAIL,
            ),
    );
  }

  @override
  Bloc getBloc() => _bloc;
}
