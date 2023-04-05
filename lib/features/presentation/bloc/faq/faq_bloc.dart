import 'package:ceylife_digital/core/network/network_config.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/error/messages.dart';
import 'package:ceylife_digital/features/domain/usecases/usecase_get_faq.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:huawei_map/constants/param.dart';

import 'faq_event.dart';
import 'faq_state.dart';

class FAQBloc extends BaseBloc<FAQEvent, BaseState<FAQState>> {
  final UseCaseGetFAQ useCaseGetFAQ;

  FAQBloc({this.useCaseGetFAQ}) : super(InitialFAQState());

  @override
  Stream<BaseState<FAQState>> mapEventToState(FAQEvent event) async* {
    if (event is GetFAQEvent) {
      yield APILoadingState();
      final result = await useCaseGetFAQ(Param());
      yield result.fold((l) {
        if (l is AuthorizedFailure) {
          if (AppConstants.IS_USER_LOGGED)
            return SessionExpireState();
          else
            return FAQFailedState(
                error: ErrorMessages().mapFailureToMessage(l));
        } else
          return FAQFailedState(error: ErrorMessages().mapFailureToMessage(l));
      }, (r) {
        if (r.responseCode == APIResponse.RESPONSE_SUCCESS)
          return FAQLoadedState(faqResponseEntity: r);
        else
          return FAQFailedState(error: ErrorMessages().mapAPIErrorCode(r.responseCode, r.responseError));
      });
    }
  }
}
