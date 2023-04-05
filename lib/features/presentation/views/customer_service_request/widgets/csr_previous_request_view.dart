import 'package:ceylife_digital/features/domain/entities/response/customer_initiated_service_response_entity.dart';
import 'package:ceylife_digital/features/presentation/common/ceylife_empty_view.dart';
import 'package:ceylife_digital/features/presentation/views/customer_service_request/widgets/csr_previous_request_item.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:ceylife_digital/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CSRPreviousRequestsView extends StatelessWidget {
  final List<CustomerInitiatedServiceRequestDetailEntity> previousRequests;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final VoidCallback refreshCallback;

  CSRPreviousRequestsView(
      {Key key, this.previousRequests, this.refreshCallback})
      : super(key: key);

  void _onRefresh() async {
    refreshCallback();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return previousRequests != null && previousRequests.isNotEmpty
        ? SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            controller: _refreshController,
            onRefresh: _onRefresh,
            physics: BouncingScrollPhysics(),
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 8),
              itemBuilder: (context, index) {
                return GestureDetector(
                  child:
                      CSRPreviousRequestItem(request: previousRequests[index]),
                  onTap: () {
                    Navigator.pushNamed(context,
                        Routes.CUSTOMER_SERVICE_REQUEST_VIEW_PREVIOUS_VIEW,
                        arguments: previousRequests[index]);
                  },
                );
              },
              physics: BouncingScrollPhysics(),
              itemCount: previousRequests.length,
            ),
          )
        : CeylifeEmptyView(
            status: EmptyStatus.CUSTOMER_SERVICE_REQUEST,
          );
  }
}
