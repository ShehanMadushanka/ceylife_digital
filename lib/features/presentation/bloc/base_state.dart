import 'package:ceylife_digital/features/data/models/responses/common_error_response.dart';

abstract class BaseState<K> {
  const BaseState();
}

class BaseInitial extends BaseState {}

class SessionExpireState<K> extends BaseState<K> {}

class APIFailureState<K> extends BaseState<K> {
  final ErrorResponseModel errorResponseModel;

  APIFailureState({this.errorResponseModel});
}

class APILoadingState<K> extends BaseState<K> {}

class UploadLoadingState<K> extends BaseState<K> {}

/*class ClaimInitiationMajorCategoryHit extends BaseState{
  @override
  List<Object> get props => [];
}*/
