import 'package:equatable/equatable.dart';

import 'customer_initiated_category_response_entity.dart';
import 'get_csr_main_category_response_entity.dart';

class CustomerInitiatedServiceResponseEntity extends Equatable {
  CustomerInitiatedServiceResponseEntity({
    this.responseCode,
    this.responseError,
    this.customerInitiatedServiceRequestDetails,
  });

  String responseCode;
  String responseError;
  List<CustomerInitiatedServiceRequestDetailEntity>
      customerInitiatedServiceRequestDetails;

  @override
  List<Object> get props =>
      [responseCode, responseError, customerInitiatedServiceRequestDetails];
}

class CustomerInitiatedServiceRequestDetailEntity extends Equatable {
  CustomerInitiatedServiceRequestDetailEntity({
    this.customerInitiatedServiceRequestId,
    this.serviceRequestCategory,
    this.serviceRequestMainCategory,
    this.nicNo,
    this.comment,
    this.status,
    this.statusDescription,
    this.policyNo,
    this.remark,
    this.createdDate,
    this.lastUpdatedDate,
  });

  int customerInitiatedServiceRequestId;
  ServiceRequestCategoryEntity serviceRequestCategory;
  ServiceRequestMainCategoryEntity serviceRequestMainCategory;
  String nicNo;
  String comment;
  String status;
  String statusDescription;
  String policyNo;
  String remark;
  String createdDate;
  String lastUpdatedDate;

  @override
  List<Object> get props => [nicNo];
}
