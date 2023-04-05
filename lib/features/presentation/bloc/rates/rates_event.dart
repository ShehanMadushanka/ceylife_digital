import 'package:ceylife_digital/features/presentation/bloc/base_event.dart';

abstract class RatesEvent extends BaseEvent {}

class GetRatesEvent extends RatesEvent {}

class GetRateHistory extends RatesEvent{
  final int productDetailId;

  GetRateHistory({this.productDetailId});
}
