import 'package:ceylife_digital/core/network/network_config.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/features/data/datasources/shared_preference.dart';
import 'package:ceylife_digital/features/domain/entities/request/health_tips_request_entity.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_healthtips.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';

import 'health_tips_event.dart';
import 'health_tips_state.dart';

class HealthTipsBloc
    extends BaseBloc<HealthTipsEvent, BaseState<HealthTipsState>> {
  final UseCaseGetHealthTips useCaseGetHealthTips;
  final AppSharedData appSharedData;

  HealthTipsBloc({this.useCaseGetHealthTips, this.appSharedData})
      : super(InitialHealthTipsState());

  @override
  Stream<BaseState<HealthTipsState>> mapEventToState(
      HealthTipsEvent event) async* {
    if (event is GetHealthTips) {
      final cacheUser = await appSharedData.getCacheUser();
      yield APILoadingState();
      final result = await useCaseGetHealthTips(HealthTipsRequestEntity(
          mobileUserId: event.fromHome
              ? cacheUser.mobileUserId
              : null));
      yield result.fold((l) {
        if (l is AuthorizedFailure) {
          if (event.fromHome)
            return SessionExpireState();
          else
            return GetHealthTipsFailedState();
        } else
          return GetHealthTipsFailedState();
      }, (r) {
        if (r.responseCode == APIResponse.RESPONSE_SUCCESS)
          return GetHealthTipsSuccessState(healthTipsResponseEntity: r);
        else
          return GetHealthTipsFailedState();
      });
    }
  }
}
