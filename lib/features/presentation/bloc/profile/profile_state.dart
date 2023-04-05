import 'package:ceylife_digital/features/domain/entities/response/customer_initiated_category_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/initiate_customer_service_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/profile_data_update_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';

abstract class ProfileState extends BaseState<ProfileState> {}

class InitialProfileState extends ProfileState {}

class UpdateProfileImageSuccessState extends ProfileState {
  final ProfileDataUpdateResponseEntity userProfileResponseEntity;

  UpdateProfileImageSuccessState({this.userProfileResponseEntity});
}

class UpdateNicknameSuccessState extends ProfileState {
  final ProfileDataUpdateResponseEntity userProfileResponseEntity;

  UpdateNicknameSuccessState({this.userProfileResponseEntity});
}

class CustomerInitiatedCategoriesSuccessState extends ProfileState {
  final CustomerInitiatedCategoryResponseEntity categoryResponseEntity;

  CustomerInitiatedCategoriesSuccessState({this.categoryResponseEntity});
}

class InitiateCustomerServiceSuccessState extends ProfileState {
  final InitiateCustomerServiceResponseEntity
      initiateCustomerServiceResponseEntity;
  final String requestType;

  InitiateCustomerServiceSuccessState(
      {this.initiateCustomerServiceResponseEntity, this.requestType});
}

class RequestPendingErrorState extends ProfileState{
  final String nickname;

  RequestPendingErrorState({this.nickname});
}
