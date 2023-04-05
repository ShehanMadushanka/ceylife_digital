import 'package:bloc/bloc.dart';

import 'base_event.dart';
import 'base_state.dart';

abstract class BaseBloc<T extends BaseEvent, K extends BaseState>
    extends Bloc<T, K> {
  BaseBloc(K initialState) : super(initialState);
}
