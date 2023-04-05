import 'package:ceylife_digital/core/network/network_config.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/features/data/datasources/shared_preference.dart';
import 'package:ceylife_digital/features/data/models/responses/common_error_response.dart';
import 'package:ceylife_digital/features/domain/entities/request/get_notification_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/notification_status_change_request_entity.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_change_notification_status.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_notifications.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/notification/notification_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/notification/notification_state.dart';

class NotificationBloc
    extends BaseBloc<NotificationEvent, BaseState<NotificationState>> {
  final UseCaseGetNotifications useCaseGetNotifications;
  final UseCaseChangeNotificationStatus useCaseChangeNotificationStatus;
  final AppSharedData appSharedData;

  NotificationBloc(
      {this.useCaseGetNotifications,
      this.useCaseChangeNotificationStatus,
      this.appSharedData})
      : super(InitialNotificationState());

  @override
  Stream<BaseState<NotificationState>> mapEventToState(
      NotificationEvent event) async* {
    if (event is GetNotificationsEvent) {
      yield APILoadingState();
      final cacheUser = await appSharedData.getCacheUser();
      final result = await useCaseGetNotifications(
          GetNotificationRequestEntity(mobileUserId: cacheUser.mobileUserId));

      yield result.fold((l) {
        if (l is AuthorizedFailure) {
          return SessionExpireState();
        } else
          return APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseError: ErrorMessages().mapFailureToMessage(l)));
      }, (r) {
        if (r.responseCode == APIResponse.RESPONSE_SUCCESS)
          return NotificationLoadedState(getNotificationResponseEntity: r);
        else
          return NotificationLoadingFailedState();
      });
    } else if (event is ChangeNotificationStatusEvent) {
      yield APILoadingState();
      final cacheUser = await appSharedData.getCacheUser();
      final result = await useCaseChangeNotificationStatus(
          NotificationStatusChangeRequestEntity(
              notificationReadHistoryIds: event.idList,
              status: event.status,
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
          return NotificationStatusChangeSuccessState(
              getNotificationResponseEntity: r);
        else
          return APIFailureState(
              errorResponseModel:
                  ErrorResponseModel(responseError: r.responseError));
      });
    }
  }
}
