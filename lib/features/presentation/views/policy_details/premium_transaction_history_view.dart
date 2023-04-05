import 'package:bloc/src/bloc.dart';
import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/features/domain/entities/response/payment_details_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/policy_details/policy_details_bloc.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_appbar.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_empty_view.dart';
import 'package:ceylife_digital/features/presentation/common/ui_consts.dart';
import 'package:ceylife_digital/features/presentation/views/base_view.dart';
import 'package:ceylife_digital/features/presentation/views/payment_history/widgets/table_item.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PremiumTransactionHistoryView extends BaseView {
  final List<PaymentHistoryItemEntity> transactions;

  PremiumTransactionHistoryView({Key key, @required this.transactions});

  @override
  _PremiumTransactionHistoryViewState createState() =>
      _PremiumTransactionHistoryViewState();
}

class _PremiumTransactionHistoryViewState
    extends BaseViewState<PremiumTransactionHistoryView> {
  final _bloc = injection<PolicyDetailsBloc>();

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CeylifeAppbar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)
              .translate("appbar_title_transaction_history"),
          style: TextStyle(color: AppColors.appBarTitle, fontSize: 18),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(AppImages.appBarBackIcon),
        ),
      ),
      body: (widget.transactions != null && widget.transactions.isNotEmpty)
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
                  widget.transactions != null && widget.transactions.isNotEmpty
                      ? DataRowItem(
                          isHeader: true,
                        )
                      : SizedBox.shrink(),
                  widget.transactions != null && widget.transactions.isNotEmpty
                      ? Expanded(
                          child: ListView(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            children: widget.transactions
                                .map(
                                  (e) => DataRowItem(
                                    date: e.receiptDate,
                                    amount: e.amount,
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
              status: EmptyStatus.PAYMENT_HISTORY,
            ),
    );
  }

  @override
  Bloc getBloc() => _bloc;
}
