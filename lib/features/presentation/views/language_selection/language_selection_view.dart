import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/language_selection/language_selection_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/language_selection/language_selection_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/language_selection/language_selection_state.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_appbar.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_bottom_sheet.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_primary_button.dart';
import 'package:ceylife_digital/features/presentation/views/base_view.dart';
import 'package:ceylife_digital/features/presentation/views/common/data/bottom_sheet_data.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/app_extensions.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../app_builder.dart';

class LanguageSelectionView extends BaseView {
  @override
  _LanguageSelectionViewState createState() => _LanguageSelectionViewState();
}

class _LanguageSelectionViewState extends BaseViewState<LanguageSelectionView> {
  final String english = "English";
  final String sinhala = "isxy,";
  final String tamil = "தமிழ்";

  final bloc = injection<LanguageSelectionBloc>();
  BottomSheetData _selectedLanguage;
  int _defaultIndex = 0;
  List<BottomSheetData> dataSet = [
    BottomSheetData(description: 'English'),
    BottomSheetData(description: 'isxy,', fontFamily: 'FMEmanee'),
    BottomSheetData(description: 'தமிழ்'),
  ];

  @override
  void initState() {
    setLanguage();
    super.initState();
    bloc.add(GetLanguageEvent());
  }

  setLanguage(){
    switch (AppConstants.APP_LANGUAGE) {
      case Languages.ENGLISH:
        _defaultIndex = 0;
        break;
      case Languages.SINHALA:
        _defaultIndex = 1;
        break;
      case Languages.TAMIL:
        _defaultIndex = 2;
        break;
    }

    setState(() {

    });
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CeylifeAppbar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context).translate("language_appbar_title"),
          style: TextStyle(color: AppColors.appBarTitle, fontSize: 18),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(AppImages.appBarBackIcon),
        ),
      ),
      body: BlocProvider<LanguageSelectionBloc>(
        create: (_) => bloc,
        child: BlocListener<LanguageSelectionBloc,
            BaseState<LanguageSelectionState>>(
          cubit: bloc,
          listener: (context, state) {
            if (state is LanguageLoadedState) {
              setState(() {
                switch (state.languages) {
                  case Languages.ENGLISH:
                    _selectedLanguage = dataSet[0];
                    break;
                  case Languages.SINHALA:
                    _selectedLanguage = dataSet[1];
                    break;
                  case Languages.TAMIL:
                    _selectedLanguage = dataSet[2];
                    break;
                }
              });

              setState(() {});
            } else if (state is LanguageChangeState) {
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
              Navigator.of(context).pop();
            }
          },
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: CeylifeBottomSheet(
                    isSearchable: false,
                    isDividerAvailable: true,
                    shouldBoldText: true,
                    getSelectOnTap: true,
                    dataList: dataSet,
                    callback: (selectedData) {
                      if (selectedData != null) {
                        _selectedLanguage = selectedData;
                      }
                    },
                    selectedIndex: _defaultIndex,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 29, vertical: 18),
                child: CeylifePrimaryButton(
                  width: double.infinity,
                  buttonLabel: AppLocalizations.of(context)
                      .translate("change_language_button_label"),
                  onTap: () {
                    showCeylifeDialog(
                        title: AppLocalizations.of(context)
                            .translate("change_language_title_label"),
                        dialogContentWidget: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${AppLocalizations.of(context).translate("label_change_language_desc")} ${_getLanguageDesc()}.\n",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textColorAshDark2),
                                textAlign: TextAlign.start,
                              ),
                              Text(
                                AppLocalizations.of(context).translate(
                                    "label_change_language_question"),
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textColorAshDark2),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                        positiveButtonText: AppLocalizations.of(context)
                            .translate("button_label_yes"),
                        negativeButtonText: AppLocalizations.of(context)
                            .translate("button_label_no"),
                        onPositiveCallback: () {
                          bloc.add(SetLanguageEvent(_getLanguage()));
                        });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String _getLanguageDesc() {
    if (_selectedLanguage.description == english)
      return english;
    else if (_selectedLanguage.description == sinhala)
      return "සිංහල";
    else if (_selectedLanguage.description == tamil) return tamil;
  }

  Languages _getLanguage() {
    if (_selectedLanguage.description == english)
      return Languages.ENGLISH;
    else if (_selectedLanguage.description == sinhala)
      return Languages.SINHALA;
    else if (_selectedLanguage.description == tamil) return Languages.TAMIL;
  }

  @override
  Bloc getBloc() {
    return bloc;
  }
}
