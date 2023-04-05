// To parse this JSON data, do
//
//     final customerInitiatedCategoryRequest = customerInitiatedCategoryRequestFromJson(jsonString);

import 'package:ceylife_digital/features/data/models/requests/customer_initiated_category_request.dart';

class CustomerInitiatedCategoryRequestEntity
    extends CustomerInitiatedCategoryRequest {
  CustomerInitiatedCategoryRequestEntity({
    this.mainCategoryId,
  }) : super(mainCategoryId: mainCategoryId);

  int mainCategoryId;
}
