import 'package:ceylife_digital/features/domain/entities/response/rates_response_entity.dart';
import 'package:ceylife_digital/features/presentation/common/expandable.dart';
import 'package:ceylife_digital/features/presentation/views/rates/widgets/rate_expanded.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/navigation_routes.dart';
import 'package:flutter/material.dart';

class RatesExpandableItem extends StatelessWidget {
  final List<RateEntity> rateList;
  final String categoryName;

  RatesExpandableItem({Key key, this.rateList, this.categoryName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      initialExpanded: false,
      child: ScrollOnExpand(
        scrollOnExpand: true,
        scrollOnCollapse: true,
        child: Container(
          color: AppColors.primaryBackgroundColor,
          child: ExpandablePanel(
            iconColor: Colors.white,
            tapHeaderToExpand: true,
            tapBodyToCollapse: false,
            isFromFAQ: false,
            headerAlignment: ExpandablePanelHeaderAlignment.center,
            header: Padding(
              padding: const EdgeInsets.only(
                  left: 12, right: 12, top: 10, bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      (categoryName != null || categoryName.isNotEmpty)
                          ? categoryName
                          : 'N/A',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
            expanded: Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _arrangeRateItems(context),
              ),
            ),
            builder: (_, collapsed, expanded) {
              return Expandable(
                collapsed: collapsed,
                expanded: expanded,
                crossFadePoint: 0,
              );
            },
          ),
        ),
      ),
    );
  }

  _arrangeRateItems(BuildContext context) {
    List<RateExpandedItem> items = List();

    for (int r = 0; r < rateList.length; r++) {
      items.add(
        RateExpandedItem(
          index: r,
          rateEntity: rateList[r],
          onTap: () {
            Navigator.pushNamed(context, Routes.RATES_HISTORY_VIEW,
                arguments: rateList[r]);
          },
        ),
      );
    }

    return items;
  }
}
