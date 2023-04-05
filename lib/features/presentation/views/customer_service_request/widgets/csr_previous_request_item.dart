import 'dart:math' as math;

import 'package:ceylife_digital/features/domain/entities/response/customer_initiated_service_response_entity.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_icons_icons.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:flutter/material.dart';

class CSRPreviousRequestItem extends StatelessWidget {
  final CustomerInitiatedServiceRequestDetailEntity request;

  const CSRPreviousRequestItem({Key key, this.request}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _viewColor = request.status == SERVICE_REQUEST_STATUS_CLOSED
        ? AppColors.primaryBackgroundColor
        : AppColors.chiliRed;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: _viewColor, width: 1),
        ),
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    request.serviceRequestCategory.description,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: _viewColor,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '${AppLocalizations.of(context)
                            .translate("policy_number_label").substring(0,AppLocalizations.of(context)
                            .translate("policy_number_label").length-1)} :',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: _viewColor,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        request.policyNo,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: _viewColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)
                            .translate("status_label"),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: _viewColor,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        _getStatusDescription(context),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: _viewColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    _getDate(context),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: _viewColor,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  color: _viewColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)
                            .translate("view_more_label"),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Transform.rotate(
                        angle: 270 * math.pi / 180,
                        child: Icon(
                          CeylifeIcons.ic_rounded_arrow_down,
                          color: Colors.white,
                          size: 20,
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  _getStatusDescription(BuildContext context) {
    switch (request.status) {
      case SERVICE_REQUEST_STATUS_PENDING_INPUT:
        return AppLocalizations.of(context)
            .translate("label_status_in_progress");
      case SERVICE_REQUEST_STATUS_CLOSED:
        return AppLocalizations.of(context)
            .translate("label_status_completed");
    }
  }

  _getDate(BuildContext context) {
    switch (request.status) {
      case SERVICE_REQUEST_STATUS_PENDING_INPUT:
        return "${AppLocalizations.of(context)
            .translate("label_status_initial_date")} ${request.createdDate}";
      case SERVICE_REQUEST_STATUS_CLOSED:
        return "${AppLocalizations.of(context)
            .translate("label_status_completed_date")} ${request.lastUpdatedDate}";
    }
  }
}
