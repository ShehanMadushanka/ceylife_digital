import 'package:ceylife_digital/core/network/network_config.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_news.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/news/news_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/news/news_state.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:huawei_map/constants/param.dart';

class NewsBloc extends BaseBloc<NewsEvent, BaseState<NewsState>> {
  final UseCaseGetNews useCaseGetNews;

  NewsBloc({this.useCaseGetNews}) : super(InitialNewsState());

  @override
  Stream<BaseState<NewsState>> mapEventToState(NewsEvent event) async* {
    if (event is GetNewsEvent) {
      yield APILoadingState();
      final result = await useCaseGetNews(Param());
      yield result.fold((l) {
        if (l is AuthorizedFailure) {
          if (AppConstants.IS_USER_LOGGED)
            return SessionExpireState();
          else
            return NewsFailedState(
                error: ErrorMessages().mapFailureToMessage(l));
        } else
          return NewsFailedState(error: ErrorMessages().mapFailureToMessage(l));
      }, (r) {
        if (r.responseCode == APIResponse.RESPONSE_SUCCESS)
          return NewsLoadedState(newsResponseEntity: r);
        else
          return NewsFailedState(error: ErrorMessages().mapAPIErrorCode(r.responseCode, r.responseError));
      });
    }
  }
}
