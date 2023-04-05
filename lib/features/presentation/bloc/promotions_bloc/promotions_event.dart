import 'package:ceylife_digital/features/domain/entities/request/promotions_request_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_event.dart';

abstract class PromotionsEvent extends BaseEvent{

}

class GetPromotionsEvent extends PromotionsEvent{
  final PromotionsRequestEntity promotionsRequestEntity;

  GetPromotionsEvent({this.promotionsRequestEntity});
}