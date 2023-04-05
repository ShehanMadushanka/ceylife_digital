import 'package:ceylife_digital/features/domain/entities/response/accumulation_rate_history_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/rates_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';

abstract class RateState extends BaseState<RateState> {}

class InitialRateState extends RateState {}

class RatesLoadedState extends RateState {
  final AccumulationRateResponseEntity accumulationRateResponseEntity;

  RatesLoadedState({this.accumulationRateResponseEntity});
}

class RatesHistoryLoadedState extends RateState {
  final AccumulationRateHistoryResponseEntity
      accumulationRateHistoryResponseEntity;

  RatesHistoryLoadedState({this.accumulationRateHistoryResponseEntity});
}

class RatesFailedState extends RateState {
  final String error;

  RatesFailedState({this.error});
}

class RatesHistoryFailedState extends RateState {
  final String error;

  RatesHistoryFailedState({this.error});
}
