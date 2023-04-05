import 'package:ceylife_digital/features/domain/entities/response/faq_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';

abstract class FAQState extends BaseState<FAQState> {}

class InitialFAQState extends FAQState {}

class FAQLoadedState extends FAQState {
  final FAQResponseEntity faqResponseEntity;

  FAQLoadedState({this.faqResponseEntity});
}

class FAQFailedState extends FAQState {
  final String error;

  FAQFailedState({this.error});
}
