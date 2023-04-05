import 'package:ceylife_digital/core/network/network_config.dart';
import 'package:ceylife_digital/core/usecase/usecase.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/features/data/datasources/shared_preference.dart';
import 'package:ceylife_digital/features/data/models/responses/common_error_response.dart';
import 'package:ceylife_digital/features/domain/entities/request/customer_initiated_category_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/customer_initiated_service_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/initiate_customer_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/policy_details_request_entity.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_csr_main_categories.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_customer_initiated_categories.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_customer_initiated_service.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_policy_details.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_initiate_customer_service.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';

import 'customer_service_event.dart';
import 'customer_service_state.dart';

class CustomerServiceBloc
    extends BaseBloc<CustomerServiceEvent, BaseState<CustomerServiceState>> {
  final UseCaseGetCustomerInitiatedService useCaseGetCustomerInitiatedService;
  final UseCaseGetCustomerInitiatedCategories getCustomerInitiatedCategories;
  final UseCaseInitiateCustomerService initiateCustomerService;
  final UseCaseGetCSRMainCategories useCaseGetCSRMainCategories;
  final UseCasePolicyDetails useCaseGetPolicy;
  final AppSharedData appSharedData;

  CustomerServiceBloc(
      {this.useCaseGetCustomerInitiatedService,
      this.appSharedData,
      this.initiateCustomerService,
      this.getCustomerInitiatedCategories,
      this.useCaseGetPolicy,
      this.useCaseGetCSRMainCategories})
      : super(InitialCustomerServiceState());

  @override
  Stream<BaseState<CustomerServiceState>> mapEventToState(
      CustomerServiceEvent event) async* {
    if (event is GetCustomerInitiatedServicesEvent) {
      yield APILoadingState();
      final cacheUser = await appSharedData.getCacheUser();
      final result = await useCaseGetCustomerInitiatedService(
          CustomerInitiatedServiceRequestEntity(
              mobileUserId: cacheUser.mobileUserId));
      yield result.fold((l) {
        if (l is AuthorizedFailure) {
          return SessionExpireState();
        } else
          return APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseError: ErrorMessages().mapFailureToMessage(l)));
      }, (r) {
        if (r.responseCode == APIResponse.RESPONSE_SUCCESS)
          return PreviousRequestsSuccessState(
              customerInitiatedServiceResponseEntity: r,
              isInitialRequest: event.isInitialRequest);
        else {
          return PreviousRequestsFailedState(
              error: ErrorMessages()
                  .mapAPIErrorCode(r.responseCode, r.responseError));
        }
      });
    } else if (event is GetCustomerInitiatedCategoriesEvent) {
      yield APILoadingState();
      final result = await getCustomerInitiatedCategories(
          CustomerInitiatedCategoryRequestEntity(
        mainCategoryId: event.categoryId,
      ));
      yield result.fold((l) {
        if (l is AuthorizedFailure) {
          return SessionExpireState();
        } else
          return APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseError: ErrorMessages().mapFailureToMessage(l)));
      }, (r) {
        if (r.responseCode == APIResponse.RESPONSE_SUCCESS)
          return CustomerInitiatedCategoriesSuccessState(
              categoryResponseEntity: r);
        else {
          return APIFailureState(
              errorResponseModel:
                  ErrorResponseModel(responseError: r.responseError));
        }
      });
    } else if (event is InitiateCustomerServiceEvent) {
      yield UploadLoadingState();
      final cacheUser = await appSharedData.getCacheUser();
      List<FileElementEntity> files = event.fileList
          .map((e) => FileElementEntity(
              encodedFile: e.base64File, fileType: e.extension))
          .toList();
      final result = await initiateCustomerService(
        InitiateCustomerServiceRequestEntity(
            serviceRequestCategoryId: event.serviceRequestCategoryId,
            comment: event.comment,
            mobileUserId: cacheUser.mobileUserId,
            serviceRequestMainCategoryId: event.serviceRequestMainCategoryId,
            policyNo: event.policyNo,
            files: files),
      );
      yield result.fold((l) {
        if (l is AuthorizedFailure) {
          return SessionExpireState();
        } else
          return APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseError: ErrorMessages().mapFailureToMessage(l)));
      }, (r) {
        if (r.responseCode == APIResponse.RESPONSE_SUCCESS)
          return InitiateCustomerServiceSuccessState(
              initiateCustomerServiceResponseEntity: r,
              requestType: event.requestType);
        else if (r.responseCode ==
            APIResponse.RESPONSE_FAILED_REQUEST_PENDING) {
          return RequestPendingErrorState(nickname: cacheUser.nickName);
        } else {
          return APIFailureState(
              errorResponseModel:
                  ErrorResponseModel(responseError: r.responseError));
        }
      });
    } else if (event is GetCSRMainCategoriesEvent) {
      yield APILoadingState();
      final result = await useCaseGetCSRMainCategories(NoParams());
      yield result.fold((l) {
        if (l is AuthorizedFailure) {
          return SessionExpireState();
        } else
          return APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseError: ErrorMessages().mapFailureToMessage(l)));
      }, (r) {
        if (r.resCode == APIResponse.RESPONSE_SUCCESS)
          return CSRMainCategoriesSuccessState(
              getCsrMainCategoryResponseEntity: r);
        else {
          return APIFailureState(
              errorResponseModel:
                  ErrorResponseModel(responseError: r.resError));
        }
      });
    } else if (event is GetPoliciesEvent) {
      yield APILoadingState();
      final cacheUser = await appSharedData.getCacheUser();
      final result = await useCaseGetPolicy(PolicyDetailsRequestEntity(
          clientNo: cacheUser.mobileUserId.toString()));
      yield result.fold((l) {
        if (l is AuthorizedFailure) {
          return SessionExpireState();
        } else
          return PolicyLoadingFailedState(
              error: ErrorMessages().mapFailureToMessage(l));
      }, (r) {
        if (r.responseCode == APIResponse.RESPONSE_SUCCESS) {
          return PolicyLoadedState(policyDetailsResponseEntity: r);
        } else
          return PolicyLoadingFailedState(
              error: ErrorMessages()
                  .mapAPIErrorCode(r.responseCode, r.responseError));
      });
    }
  }
}
