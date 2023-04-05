import 'package:ceylife_digital/features/domain/entities/response/health_tip_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';

abstract class HealthTipsState extends BaseState<HealthTipsState> {}

class InitialHealthTipsState extends HealthTipsState {}

class GetHealthTipsSuccessState extends HealthTipsState {
  final HealthTipsResponseEntity healthTipsResponseEntity;

  GetHealthTipsSuccessState({this.healthTipsResponseEntity});
}

class GetHealthTipsFailedState extends HealthTipsState {}
