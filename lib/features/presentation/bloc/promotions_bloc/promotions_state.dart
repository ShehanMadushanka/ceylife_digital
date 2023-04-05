import 'package:ceylife_digital/features/domain/entities/response/promotion_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';

abstract class PromotionsState extends BaseState<PromotionsState> {}

class InitialPromotionsState extends PromotionsState {}

class PromotionsLoadedState extends PromotionsState {
  final PromotionResponseEntity promotionResponseEntity;

  PromotionsLoadedState({this.promotionResponseEntity});
}

class PromotionsFailedState extends PromotionsState {
  final String error;

  PromotionsFailedState({this.error});
}
