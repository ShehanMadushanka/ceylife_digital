import 'package:bloc/src/bloc.dart';
import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/features/presentation/bloc/policy_details/policy_details_bloc.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_appbar.dart';
import 'package:ceylife_digital/features/presentation/common/ui_consts.dart';
import 'package:ceylife_digital/features/presentation/views/base_view.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BeneficiaryDetailsView extends BaseView {
  @override
  _BeneficiaryDetailsViewState createState() => _BeneficiaryDetailsViewState();
}

class _BeneficiaryDetailsViewState
    extends BaseViewState<BeneficiaryDetailsView> {
  final _bloc = injection<PolicyDetailsBloc>();

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CeylifeAppbar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)
              .translate("appbar_title_beneficiary_detail"),
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
      ),
    );
  }

  @override
  Bloc getBloc() => _bloc;
}
