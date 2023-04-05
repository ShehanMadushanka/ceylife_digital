import 'package:ceylife_digital/core/network/network_config.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_promotions.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/promotions_bloc/promotions_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/promotions_bloc/promotions_state.dart';
import 'package:ceylife_digital/utils/app_constants.dart';

class PromotionsBloc
    extends BaseBloc<PromotionsEvent, BaseState<PromotionsState>> {
  final UseCaseGetPromotions useCaseGetPromotions;

  PromotionsBloc({this.useCaseGetPromotions}) : super(InitialPromotionsState());

  @override
  Stream<BaseState<PromotionsState>> mapEventToState(
      PromotionsEvent event) async* {
    if (event is GetPromotionsEvent) {
      yield APILoadingState();
      final result = await useCaseGetPromotions(event.promotionsRequestEntity);
      yield result.fold((l) {
        if (l is AuthorizedFailure) {
          if (AppConstants.IS_USER_LOGGED)
            return SessionExpireState();
          else
            return PromotionsFailedState(
                error: ErrorMessages().mapFailureToMessage(l));
        } else
          return PromotionsFailedState(
              error: ErrorMessages().mapFailureToMessage(l));
      }, (r) {
        if (r.responseCode == APIResponse.RESPONSE_SUCCESS)
          return PromotionsLoadedState(promotionResponseEntity: r);
        else
          return PromotionsFailedState(error: ErrorMessages().mapAPIErrorCode(r.responseCode, r.responseError));
      });
    }
  }
}
