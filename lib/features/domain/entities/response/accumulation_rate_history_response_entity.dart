// To parse this JSON data, do
//
//     final accumulationRateHistoryResponse = accumulationRateHistoryResponseFromJson(jsonString);

import 'package:ceylife_digital/features/domain/entities/response/rates_response_entity.dart';
import 'package:equatable/equatable.dart';

class AccumulationRateHistoryResponseEntity extends Equatable{
  AccumulationRateHistoryResponseEntity({
    this.responseCode,
    this.responseError,
    this.rates,
  });

  String responseCode;
  String responseError;
  List<RateEntity> rates;

  @override
  List<Object> get props => [responseCode, responseError, rates];
}
