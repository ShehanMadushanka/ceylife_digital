import 'dart:ui';

import 'package:bloc/src/bloc.dart';
import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/features/domain/entities/response/policy_info_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/policy_details/policy_details_bloc.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_appbar.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_primary_button.dart';
import 'package:ceylife_digital/features/presentation/common/ui_consts.dart';
import 'package:ceylife_digital/features/presentation/views/base_view.dart';
import 'package:ceylife_digital/features/presentation/views/payment_history/widgets/table_item.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class LoanReceiptsView extends BaseView {
  final List<LoanReceiptEntity> loanReceipts;

  LoanReceiptsView({Key key, this.loanReceipts});

  @override
  _LoanReceiptsViewState createState() => _LoanReceiptsViewState();
}

class _LoanReceiptsViewState extends BaseViewState<LoanReceiptsView> {
  final _bloc = injection<PolicyDetailsBloc>();

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CeylifeAppbar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)
              .translate("appbar_title_loan_receipt"),
          style: TextStyle(color: AppColors.appBarTitle, fontSize: 18),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(AppImages.appBarBackIcon),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: kBackgroundGradient,
        ),
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  '${AppLocalizations.of(context)
                      .translate("label_load_number")} - ${widget.loanReceipts[0].loanNo}',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.primaryHeadingTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                widget.loanReceipts != null && widget.loanReceipts.isNotEmpty
                    ? DataRowItem(
                        isHeader: true,
                      )
                    : SizedBox.shrink(),
                widget.loanReceipts != null && widget.loanReceipts.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          itemBuilder: (_, index) {
                            return (index == widget.loanReceipts.length - 1)
                                ? Column(
                                    children: [
                                      DataRowItem(
                                        amount:
                                            widget.loanReceipts[index].amount,
                                        date: DateFormat('yyyy-MM-dd').format(
                                            widget.loanReceipts[index]
                                                .receiptDate),
                                      ),
                                      SizedBox(
                                        height: 90,
                                      )
                                    ],
                                  )
                                : DataRowItem(
                                    amount: widget.loanReceipts[index].amount,
                                    date: DateFormat('yyyy-MM-dd').format(
                                        widget.loanReceipts[index].receiptDate),
                                  );
                          },
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.loanReceipts.length,
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                    child: CeylifePrimaryButton(
                      buttonLabel: AppLocalizations.of(context)
                          .translate('home_button_label'),
                      width: MediaQuery.of(context).size.width - 60,
                      onTap: () => Navigator.of(context)
                          .popUntil(ModalRoute.withName(Routes.HOME_VIEW)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Bloc getBloc() => _bloc;
}
