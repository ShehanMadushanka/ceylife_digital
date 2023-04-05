import 'package:ceylife_digital/features/data/models/requests/get_promotions_request.dart';

class PromotionsRequestEntity extends GetPromotionsRequest{
  final String promotionType;

  PromotionsRequestEntity({this.promotionType}):super(promotionType: promotionType);
}