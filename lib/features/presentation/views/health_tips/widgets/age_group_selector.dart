import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/features/domain/entities/response/health_tip_response_entity.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AgeGroupSelector extends StatefulWidget {
  final List<AgeRangeEntity> ageRangeList;
  final Function(AgeRangeEntity) selectedAgeGroup;

  AgeGroupSelector({this.ageRangeList, this.selectedAgeGroup});

  @override
  _AgeGroupSelectorState createState() => _AgeGroupSelectorState();
}

class _AgeGroupSelectorState extends State<AgeGroupSelector>
    with AutomaticKeepAliveClientMixin<AgeGroupSelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(0, 5), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 6,
          ),
          Text(AppLocalizations.of(context)
              .translate("label_health_tips_age_group"),
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColors.primaryAshColor,
                fontWeight: FontWeight.w500,
                fontSize: 14),
          ),
          SizedBox(
            height: 13,
          ),
          Container(
            height: 30,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: widget.ageRangeList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    setState(() {
                      if (!widget.ageRangeList[index].isSelected) {
                        widget.ageRangeList.forEach((element) {
                          element.isSelected = false;
                        });
                        widget.ageRangeList[index].isSelected = true;
                        widget.selectedAgeGroup(widget.ageRangeList[index]);
                      }
                    });
                  },
                  child: Container(
                    width: AppConstants.APP_LANGUAGE == Languages.ENGLISH?81:120,
                    margin: EdgeInsets.only(left: 16),
                    decoration: BoxDecoration(
                        color: widget.ageRangeList[index].isSelected
                            ? AppColors.appbarPrimary
                            : AppColors.appBarTitle,
                        border: Border.all(
                            color: AppColors.appbarPrimary, width: 1)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 3, bottom: 3),
                        child: Text(
                          widget.ageRangeList[index].isInitialItem
                              ? ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_HEALTH_TIP_ALL, '')
                              : ErrorMessages().mapAPIErrorCode(ErrorMessages.APP_HEALTH_TIP_AGE_RANGE, '${widget.ageRangeList[index].ageFrom}|${widget.ageRangeList[index].ageTo}'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: widget.ageRangeList[index].isSelected
                                  ? AppColors.appBarTitle
                                  : AppColors.appbarPrimary,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
