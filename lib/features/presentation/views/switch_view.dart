import 'package:bloc/src/bloc.dart';
import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/home/home_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/home/home_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/home/home_state.dart';
import 'package:ceylife_digital/features/presentation/views/base_view.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SwitchView extends BaseView {
  final bool mode;

  SwitchView(this.mode);

  @override
  _SwitchViewState createState() => _SwitchViewState();
}

class _SwitchViewState extends BaseViewState<SwitchView> {
  final bloc = injection<HomeBloc>();

  @override
  void initState() {
    super.initState();

    if (widget.mode) {
      Future.delayed(Duration(seconds: 3), () {
        bloc.appSharedData.setCacheUser(isLeadGenerator: true);
        Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.LEAD_GENERATOR_DASHBOARD_VIEW,
            (Route<dynamic> route) => false);
      });
    } else {
      bloc.add(GetPoliciesEvent());
    }
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      body: BlocProvider<HomeBloc>(
        create: (_) => bloc,
        child: BlocListener<HomeBloc, BaseState<HomeState>>(
          cubit: bloc,
          listener: (context, state) {
            if (state is PolicyLoadedState) {
              bloc.appSharedData.setCacheUser(isLeadGenerator: false);
              Navigator.pushNamedAndRemoveUntil(
                  context, Routes.HOME_VIEW, (Route<dynamic> route) => false,
                  arguments: state.policyDetailsResponseEntity.data);
            } else if (state is PolicyLoadingFailedState) {
              showCeylifeDialog(
                  isSessionTimeout: true,
                  title: AppLocalizations.of(context).translate('title_error'),
                  message: state.error,
                  positiveButtonText: AppLocalizations.of(context)
                      .translate('try_again_button_label'),
                  negativeButtonText: AppLocalizations.of(context)
                      .translate('cancel_button_label'),
                  onNegativeCallback: () {
                    Navigator.pop(context);
                  },
                  onPositiveCallback: () {
                    bloc.add(GetPoliciesEvent());
                  });
            }
          },
          child: Container(
            decoration: new BoxDecoration(
                gradient: new LinearGradient(
              colors: [Colors.white, AppColors.splashGradient],
              stops: [0.0, 1.0],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
            )),
            child: Center(
              child: Image.asset(
                AppImages.splashLogo,
                width: 241,
                height: 367,
              ),
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
