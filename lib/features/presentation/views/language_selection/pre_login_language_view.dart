import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/language_selection/language_selection_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/language_selection/language_selection_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/language_selection/language_selection_state.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_button_list.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_primary_button.dart';
import 'package:ceylife_digital/features/presentation/views/base_view.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/app_extensions.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:ceylife_digital/utils/navigation_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_builder.dart';

class PreLoginLanguageSelectionView extends BaseView {
  @override
  _PreLoginLanguageSelectionViewState createState() =>
      _PreLoginLanguageSelectionViewState();
}

class _PreLoginLanguageSelectionViewState
    extends BaseViewState<PreLoginLanguageSelectionView>
    with TickerProviderStateMixin {
  final bloc = injection<LanguageSelectionBloc>();
  int _languageIndex = 0;
  List<CheckableButton> buttonList = [
    CheckableButton(
      label: "English",
      isChecked: true,
    ),
    CheckableButton(
      label: "isxy,",
      fontFamily: 'FMEmanee',
      isChecked: false,
    ),
    CheckableButton(
      label: "தமிழ்",
      isChecked: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    bloc.add(GetLanguageEvent());
  }

  @override
  Widget buildView(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: AnnotatedRegion(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          body: BlocProvider<LanguageSelectionBloc>(
            create: (_) => bloc,
            child: BlocListener<LanguageSelectionBloc,
                BaseState<LanguageSelectionState>>(
              cubit: bloc,
              listener: (context, state) {
                if (state is LanguageChangeState) {
                  AppConstants.APP_LANGUAGE = state.languages;
                  switch (state.languages.getValue()) {
                    case 'en':
                      AppLocalizations.of(context).load(Locale("en", "US"));
                      break;
                    case 'si':
                      AppLocalizations.of(context).load(Locale("si", "LK"));
                      break;
                    case 'ta':
                      AppLocalizations.of(context).load(Locale("ta", "TA"));
                      break;
                  }

                  AppBuilder.of(context).rebuild();
                  Navigator.pushNamedAndRemoveUntil(
                      context, Routes.LOGIN_VIEW, (route) => false);
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
                child: Column(
                  children: [
                    Spacer(),
                    Column(
                      children: [
                        Text(
                          ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_PRE_LANGUAGE_TITLE, ''),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              color: AppColors.appbarPrimary,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 72,
                        ),
                        CeyLifeButtonList(
                          buttons: buttonList,
                          selectedIndex: (itemIndex) {
                            setState(() {
                              _languageIndex = itemIndex;
                              AppConstants.APP_LANGUAGE = _getLanguage(_languageIndex);
                            });
                          },
                        ),
                      ],
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 29, vertical: 18),
                      child: CeylifePrimaryButton(
                        width: double.infinity,
                        buttonLabel: ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_PRE_LANGUAGE_BUTTON, ''),
                        onTap: () {
                          bloc.add(SetLanguageEvent(
                              _getLanguage(_languageIndex),
                              isInitialValue: true));
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Languages _getLanguage(int index) {
    if (index == 0)
      return Languages.ENGLISH;
    else if (index == 1)
      return Languages.SINHALA;
    else
      return Languages.TAMIL;
  }

  @override
  Bloc getBloc() {
    return bloc;
  }
}
