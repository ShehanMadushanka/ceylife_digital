import 'package:ceylife_digital/core/network/network_config.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/features/data/datasources/shared_preference.dart';
import 'package:ceylife_digital/features/data/models/responses/common_error_response.dart';
import 'package:ceylife_digital/features/domain/entities/request/customer_initiated_category_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/initiate_customer_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/profile_data_update_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/profile_data_update_response_entity.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_customer_initiated_categories.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_initiate_customer_service.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_update_profile.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/profile/profile_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/profile/profile_state.dart';

class ProfileBloc extends BaseBloc<ProfileEvent, BaseState<ProfileState>> {
  final UseCaseUpdateProfile updateProfile;
  final UseCaseGetCustomerInitiatedCategories getCustomerInitiatedCategories;
  final UseCaseInitiateCustomerService initiateCustomerService;
  final AppSharedData appSharedData;

  ProfileBloc(
      {this.updateProfile,
      this.appSharedData,
      this.initiateCustomerService,
      this.getCustomerInitiatedCategories})
      : super(InitialProfileState());

  @override
  Stream<BaseState<ProfileState>> mapEventToState(ProfileEvent event) async* {
    if (event is UpdateNicknameEvent) {
      yield APILoadingState();
      final cacheUser = await appSharedData.getCacheUser();
      final result = await updateProfile(ProfileDataUpdateRequestEntity(
          key: event.nickname,
          keyType: 1,
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
          return UpdateNicknameSuccessState(
              userProfileResponseEntity:
                  ProfileDataUpdateResponseEntity(data: event.nickname));
        else {
          return APIFailureState(
              errorResponseModel:
                  ErrorResponseModel(responseError: r.responseError));
        }
      });
    } else if (event is UpdateProfileImageEvent) {
      yield APILoadingState();
      final cacheUser = await appSharedData.getCacheUser();
      final result = await updateProfile(ProfileDataUpdateRequestEntity(
          key: event.imageData,
          keyType: 2,
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
          return UpdateProfileImageSuccessState(userProfileResponseEntity: r);
        else {
          return APIFailureState(
              errorResponseModel:
                  ErrorResponseModel(responseError: r.responseError));
        }
      });
    } else if (event is CacheProfileDataEvent) {
      if (event.dataType == 1)
        appSharedData.setCacheUser(nickname: event.data);
      else
        appSharedData.setCacheUser(profileImage: event.data);
    } else if (event is GetCustomerInitiatedCategoriesEvent) {
      yield APILoadingState();
      final result = await getCustomerInitiatedCategories(
          CustomerInitiatedCategoryRequestEntity(
        mainCategoryId: 0,
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
      yield APILoadingState();
      final cacheUser = await appSharedData.getCacheUser();
      final result = await initiateCustomerService(
          InitiateCustomerServiceRequestEntity(
              serviceRequestCategoryId: event.serviceRequestCategoryId,
              comment: event.comment,
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
    }
  }
}
