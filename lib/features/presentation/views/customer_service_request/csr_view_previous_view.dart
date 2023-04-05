import 'package:ceylife_digital/features/domain/entities/response/customer_initiated_service_response_entity.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_appbar.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CSRViewPreviousRequestsView extends StatelessWidget {
  final CustomerInitiatedServiceRequestDetailEntity request;

  const CSRViewPreviousRequestsView({Key key, this.request}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CeylifeAppbar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)
              .translate("view_previous_requests_labels"),
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
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${AppLocalizations.of(context).translate("policy_number_label")} :',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: AppColors.textColorMaroon,
                  fontSize: 14.0,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                request.policyNo,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryAshColor,
                  fontSize: 18.0,
                ),
              ),

              SizedBox(
                height: 24,
              ),

              Text(
                '${AppLocalizations.of(context).translate("customer_service_request_reason")} :',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: AppColors.textColorMaroon,
                  fontSize: 14.0,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                request.serviceRequestCategory.description,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryAshColor,
                  fontSize: 18.0,
                ),
              ),
              request.comment.isNotEmpty
                  ? SizedBox(
                      height: 24,
                    )
                  : SizedBox.shrink(),
              request.comment.isNotEmpty
                  ? Text(
                      '${AppLocalizations.of(context).translate("customer_service_request_request_description")} :',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColors.textColorMaroon,
                        fontSize: 14.0,
                      ),
                    )
                  : SizedBox.shrink(),
              request.comment.isNotEmpty
                  ? SizedBox(
                      height: 5,
                    )
                  : SizedBox.shrink(),
              request.comment.isNotEmpty
                  ? Text(
                      request.comment,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryAshColor,
                        fontSize: 14.0,
                      ),
                    )
                  : SizedBox.shrink(),
              request.remark.isNotEmpty
                  ? SizedBox(
                      height: 16,
                    )
                  : SizedBox.shrink(),
              request.remark.isNotEmpty
                  ? Text(
                      '${AppLocalizations.of(context).translate("label_crm_agent_remark")} :',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColors.textColorMaroon,
                        fontSize: 14.0,
                      ),
                    )
                  : SizedBox.shrink(),
              request.remark.isNotEmpty
                  ? SizedBox(
                      height: 8,
                    )
                  : SizedBox.shrink(),
              request.remark.isNotEmpty
                  ? Container(
                      color: AppColors.textColorAmber2,
                      padding: EdgeInsets.all(12),
                      child: Text(
                        request.remark,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    )
                  : SizedBox.shrink(),
              SizedBox(
                height: 28,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)
                            .translate("label_status_initial_date"),
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: AppColors.textColorMaroon,
                          fontSize: 14.0,
                        ),
                      ),
                      Text(
                        request.createdDate,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryAshColor,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                  request.status == SERVICE_REQUEST_STATUS_CLOSED
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              AppLocalizations.of(context)
                                  .translate("label_status_completed_date"),
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: AppColors.textColorMaroon,
                                fontSize: 14.0,
                              ),
                            ),
                            Text(
                              request.lastUpdatedDate,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: AppColors.primaryAshColor,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        )
                      : SizedBox.shrink()
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context).translate("status_label"),
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColors.textColorMaroon,
                      fontSize: 14.0,
                    ),
                  ),
                  Text(
                    _getStatusDescription(context),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryBackgroundColor,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
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
        return AppLocalizations.of(context).translate("label_status_completed");
    }
  }
}
