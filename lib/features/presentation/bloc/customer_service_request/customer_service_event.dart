import 'package:ceylife_digital/features/presentation/bloc/base_event.dart';
import 'package:ceylife_digital/features/presentation/views/customer_service_request/data/attachment_data.dart';
import 'package:flutter/cupertino.dart';

abstract class CustomerServiceEvent extends BaseEvent {}

class ResetCustomerServiceEvent extends CustomerServiceEvent {}

class GetCustomerInitiatedCategoriesEvent extends CustomerServiceEvent {
  final int categoryId;

  GetCustomerInitiatedCategoriesEvent({this.categoryId});
}

class GetCustomerInitiatedServicesEvent extends CustomerServiceEvent {
  final bool isInitialRequest;

  GetCustomerInitiatedServicesEvent({this.isInitialRequest});
}

class InitiateCustomerServiceEvent extends CustomerServiceEvent {
  final String comment;
  final int serviceRequestCategoryId;
  final String requestType;
  final String policyNo;
  final int serviceRequestMainCategoryId;
  final List<AttachmentData> fileList;

  InitiateCustomerServiceEvent(
      {this.comment,
      @required this.serviceRequestCategoryId,
      @required this.requestType,
      this.policyNo,
      this.serviceRequestMainCategoryId,
      this.fileList});
}

class GetCSRMainCategoriesEvent extends CustomerServiceEvent {}

class GetPoliciesEvent extends CustomerServiceEvent {}
