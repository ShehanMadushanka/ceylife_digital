import 'package:ceylife_digital/features/data/models/common/configuration_data.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';

abstract class BuyOnlineState extends BaseState<BuyOnlineState> {}

class InitialBuyOnlineState extends BuyOnlineState{}

class BuyOnlineLinkLoaded extends BuyOnlineState{
  final ConfigurationData configurationData;

  BuyOnlineLinkLoaded({this.configurationData});
}

