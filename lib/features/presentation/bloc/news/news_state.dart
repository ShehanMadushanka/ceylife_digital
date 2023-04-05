import 'package:ceylife_digital/features/domain/entities/response/news_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';

abstract class NewsState extends BaseState<NewsState> {}

class InitialNewsState extends NewsState {}

class NewsLoadedState extends NewsState {
  final GetNewsResponseEntity newsResponseEntity;

  NewsLoadedState({this.newsResponseEntity});
}

class NewsFailedState extends NewsState {
  final String error;

  NewsFailedState({this.error});
}
