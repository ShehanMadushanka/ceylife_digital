import 'package:ceylife_digital/features/data/datasources/shared_preference.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/buy_online/buy_online_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/buy_online/buy_online_state.dart';

import '../base_bloc.dart';

class BuyOnlineBloc
    extends BaseBloc<BuyOnlineEvent, BaseState<BuyOnlineState>> {
  final AppSharedData appSharedData;

  BuyOnlineBloc({this.appSharedData}) : super(InitialBuyOnlineState());

  @override
  Stream<BaseState<BuyOnlineState>> mapEventToState(
      BuyOnlineEvent event) async* {
    if (event is GetBuyOnlineLinks) {
      final configurationData = await appSharedData.getConfigurationData();
      yield BuyOnlineLinkLoaded(
          configurationData: configurationData);
    }
  }
}
