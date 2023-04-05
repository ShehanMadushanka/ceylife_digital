// To parse this JSON data, do
//
//     final accumulationRateHistoryRequest = accumulationRateHistoryRequestFromJson(jsonString);

import 'package:ceylife_digital/features/data/models/requests/accoumulation_rate_history_request.dart';

class AccumulationRateHistoryRequestEntity
    extends AccumulationRateHistoryRequest {
  AccumulationRateHistoryRequestEntity({
    this.productDetailId,
  }) : super(productDetailId: productDetailId);

  int productDetailId;
}
