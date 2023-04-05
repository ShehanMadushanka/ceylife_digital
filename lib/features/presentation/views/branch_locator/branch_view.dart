import 'package:ceylife_digital/core/configurations/app_config.dart';
import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/features/domain/entities/request/branches_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/branch_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/branches_bloc/branches_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/branches_bloc/branches_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/branches_bloc/branches_state.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_appbar.dart';
import 'package:ceylife_digital/features/presentation/views/base_view.dart';
import 'package:ceylife_digital/features/presentation/views/branch_locator/huawei_map_view.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'google_map_view.dart';

class BranchView extends BaseView {
  @override
  _BranchViewState createState() => _BranchViewState();
}

class _BranchViewState extends BaseViewState<BranchView> {
  bool isBranchesLoaded = false;
  final branchesBloc = injection<BranchesBloc>();
  final List<BranchEntity> branchData = List();

  @override
  void initState() {
    super.initState();
    branchesBloc.add(GetBranchesEvent(
        branchesRequestEntity: BranchesRequestEntity(categoryCode: 'INSBR')));
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CeylifeAppbar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context).translate("branch_locator_appbar_title"),
          style: TextStyle(color: AppColors.appBarTitle, fontSize: 18),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(AppImages.appBarBackIcon),
        ),
      ),
      body: BlocProvider<BranchesBloc>(
        create: (_) => branchesBloc,
        child: BlocListener<BranchesBloc, BaseState<BranchesState>>(
          cubit: branchesBloc,
          listener: (context, state) {
             if (state is BranchesLoadedState) {
              branchData.clear();
              branchData.addAll(state.branchResponseEntity.branches);
              setState(() {
                isBranchesLoaded = true;
              });
            } else if (state is BranchesFailedState) {
               showCeylifeDialog(
                   title: AppLocalizations.of(context).translate('title_error'),
                   message: state.error,
                   onPositiveCallback: (){
                     Navigator.pop(context);
                   }
               );
            }
          },
          child: isBranchesLoaded
              ? AppConfig.deviceOS == DeviceOS.ANDROID
                  ? GoogleMapView(
                      branchData: branchData,
                    )
                  : HuaweiMapView(
                      branchData: branchData,
                    )
              : SizedBox(),
        ),
      ),
    );
  }

  @override
  Bloc getBloc() {
    return branchesBloc;
  }
}
