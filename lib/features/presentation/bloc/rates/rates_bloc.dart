import 'package:ceylife_digital/core/network/network_config.dart';
import 'package:ceylife_digital/core/usecase/usecase.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/features/domain/entities/request/accumulation_rate_history_request_entity.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_accumulation_rate_history.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_accumulation_rates.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/rates/rates_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/rates/rates_state.dart';
import 'package:ceylife_digital/utils/app_constants.dart';

class RatesBloc extends BaseBloc<RatesEvent, BaseState<RateState>> {
  final UseCaseAccumulationRate useCaseAccumulationRate;
  final UseCaseAccumulationRateHistory useCaseAccumulationRateHistory;

  RatesBloc({this.useCaseAccumulationRate, this.useCaseAccumulationRateHistory})
      : super(InitialRateState());

  @override
  Stream<BaseState<RateState>> mapEventToState(RatesEvent event) async* {
    if (event is GetRatesEvent) {
      yield APILoadingState();
      final result = await useCaseAccumulationRate(NoParams());
      yield result.fold((l) {
        if (l is AuthorizedFailure) {
          if (AppConstants.IS_USER_LOGGED)
            return SessionExpireState();
          else
            return RatesFailedState(
                error: ErrorMessages().mapFailureToMessage(l));
        } else
          return RatesFailedState(
              error: ErrorMessages().mapFailureToMessage(l));
      }, (r) {
        if (r.responseCode == APIResponse.RESPONSE_SUCCESS)
          return RatesLoadedState(accumulationRateResponseEntity: r);
        else
          return RatesFailedState(error: ErrorMessages().mapAPIErrorCode(r.responseCode, r.responseError));
      });
    } else if (event is GetRateHistory) {
      yield APILoadingState();
      final result = await useCaseAccumulationRateHistory(
          AccumulationRateHistoryRequestEntity(
              productDetailId: event.productDetailId));
      yield result.fold((l) {
        if (l is AuthorizedFailure) {
          if (AppConstants.IS_USER_LOGGED)
            return SessionExpireState();
          else
            return RatesHistoryFailedState(
                error: ErrorMessages().mapFailureToMessage(l));
        } else
          return RatesHistoryFailedState(
              error: ErrorMessages().mapFailureToMessage(l));
      }, (r) {
        if (r.responseCode == APIResponse.RESPONSE_SUCCESS)
          return RatesHistoryLoadedState(
              accumulationRateHistoryResponseEntity: r);
        else
          return RatesHistoryFailedState(error: ErrorMessages().mapAPIErrorCode(r.responseCode, r.responseError));
      });
    }
  }
}
