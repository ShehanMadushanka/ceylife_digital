import 'package:ceylife_digital/features/domain/entities/response/customer_initiated_category_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/customer_initiated_service_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/get_csr_main_category_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/initiate_customer_service_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/policy_details_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';

abstract class CustomerServiceState extends BaseState<CustomerServiceState> {}

class InitialCustomerServiceState extends CustomerServiceState {}

class CustomerInitiatedCategoriesSuccessState extends CustomerServiceState {
  final CustomerInitiatedCategoryResponseEntity categoryResponseEntity;

  CustomerInitiatedCategoriesSuccessState({this.categoryResponseEntity});
}

class InitiateCustomerServiceSuccessState extends CustomerServiceState {
  final InitiateCustomerServiceResponseEntity
      initiateCustomerServiceResponseEntity;
  final String requestType;

  InitiateCustomerServiceSuccessState(
      {this.initiateCustomerServiceResponseEntity, this.requestType});
}

class PreviousRequestsSuccessState extends CustomerServiceState {
  final CustomerInitiatedServiceResponseEntity
      customerInitiatedServiceResponseEntity;
  final bool isInitialRequest;

  PreviousRequestsSuccessState(
      {this.customerInitiatedServiceResponseEntity, this.isInitialRequest});
}

class PreviousRequestsFailedState extends CustomerServiceState {
  final String error;

  PreviousRequestsFailedState({this.error});
}

class RequestPendingErrorState extends CustomerServiceState {
  final String nickname;

  RequestPendingErrorState({this.nickname});
}

class CSRMainCategoriesSuccessState extends CustomerServiceState {
  final GetCsrMainCategoryResponseEntity getCsrMainCategoryResponseEntity;

  CSRMainCategoriesSuccessState({this.getCsrMainCategoryResponseEntity});
}

class PolicyLoadedState extends CustomerServiceState {
  final PolicyDetailsResponseEntity policyDetailsResponseEntity;

  PolicyLoadedState({this.policyDetailsResponseEntity});
}

class PolicyLoadingFailedState extends CustomerServiceState {
  final String error;

  PolicyLoadingFailedState({this.error});
}
