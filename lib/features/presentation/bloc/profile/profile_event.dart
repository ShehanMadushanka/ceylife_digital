import 'package:ceylife_digital/features/presentation/bloc/base_event.dart';

abstract class ProfileEvent extends BaseEvent {}

class UpdateNicknameEvent extends ProfileEvent {
  final String nickname;

  UpdateNicknameEvent({this.nickname});
}

class UpdateProfileImageEvent extends ProfileEvent {
  final String imageData;

  UpdateProfileImageEvent({this.imageData});
}

class CacheProfileDataEvent extends ProfileEvent {
  final String data;
  final int dataType;

  CacheProfileDataEvent({this.data, this.dataType});
}

class GetCustomerInitiatedCategoriesEvent extends ProfileEvent {
  final String serviceType;

  GetCustomerInitiatedCategoriesEvent({this.serviceType});
}

class InitiateCustomerServiceEvent extends ProfileEvent {
  final String comment;
  final int serviceRequestCategoryId;
  final String requestType;

  InitiateCustomerServiceEvent(
      {this.comment, this.serviceRequestCategoryId, this.requestType});
}
